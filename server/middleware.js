import express from 'express';
import { createServer as createViteServer } from 'vite';
import mysql from 'mysql2/promise';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5173;

// Middlewares
app.use(cors());
app.use(express.json());

// Configuración de MySQL
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Middleware de seguridad
const RESTRICTED_FILES = process.env.RESTRICTED_FILES?.split(',') || [];
app.use((req, res, next) => {
    const requestedFile = req.originalUrl.split('/').pop();
    if (RESTRICTED_FILES.includes(requestedFile)) {
        return res.status(403).send('Acceso prohibido');
    }
    next();
});

// Endpoint de productos
app.get('/api/products', async (req, res) => {
    try {
        const [products] = await pool.query(`
            SELECT
                p.*,
                sub.name AS subcategory_name,
                cat.name AS category_name,
                b.name AS brand_name,
                GROUP_CONCAT(DISTINCT f.feature) AS features,
                GROUP_CONCAT(DISTINCT CONCAT(s.spec_name, ':', s.spec_value) ORDER BY s.spec_name) AS specifications,
                GROUP_CONCAT(DISTINCT c.compatible_model ORDER BY c.compatible_model) AS compatible_models,
                GROUP_CONCAT(DISTINCT i.image_url ORDER BY i.image_url) AS images
            FROM products p
                     LEFT JOIN subcategories sub ON p.subcategory_id = sub.id
                     LEFT JOIN categories cat ON sub.category_id = cat.id
                     LEFT JOIN brands b ON p.brand_id = b.id
                     LEFT JOIN product_features f ON p.id = f.product_id
                     LEFT JOIN product_specifications s ON p.id = s.product_id
                     LEFT JOIN product_compatibility c ON p.id = c.product_id
                     LEFT JOIN product_images i ON p.id = i.product_id
            GROUP BY p.id
            ORDER BY p.id
        `);

        const parsedProducts = products.map(product => ({
            ...product,
            features: product.features?.split(',') || [],
            specifications: product.specifications
                ? Object.fromEntries(product.specifications.split(',').map(s => s.split(':')))
                : {},
            compatible_models: product.compatible_models?.split(',') || [],
            images: product.images?.split(',') || []
        }));

        res.json(parsedProducts);
    } catch (error) {
        console.error('Error en GET /api/products:', error);
        res.status(500).json({ error: 'Error al obtener productos' });
    }
});

// Endpoint para procesar órdenes
app.post('/api/orders', async (req, res) => {
    let connection;
    try {
        const { username, items: cartItems } = req.body; // Cambio aquí para obtener username

        // Validación mejorada
        if (!username || !username.trim()) {
            return res.status(400).json({
                success: false,
                error: 'Nombre de usuario requerido'
            });
        }

        if (!Array.isArray(cartItems)) {
            return res.status(400).json({
                success: false,
                error: 'Formato de carrito inválido'
            });
        }

        if (cartItems.length === 0) {
            return res.status(400).json({
                success: false,
                error: 'El carrito está vacío'
            });
        }

        connection = await pool.getConnection();
        await connection.beginTransaction();

        try {
            let total = 0;
            const stockValidations = [];

            // Validar stock y calcular total
            for (const item of cartItems) {
                if (!item.id || !item.price || !item.quantity) {
                    throw new Error('Datos del producto incompletos');
                }

                const [product] = await connection.query(
                    'SELECT name, stock_count FROM products WHERE id = ?',
                    [item.id]
                );

                if (!product.length) {
                    throw new Error(`Producto no encontrado: ID ${item.id}`);
                }

                if (product[0].stock_count < item.quantity) {
                    throw new Error(`Stock insuficiente para: ${product[0].name}`);
                }

                total += item.price * item.quantity;
                stockValidations.push({
                    id: item.id,
                    quantity: item.quantity
                });
            }

            // Crear orden con username
            const [orderResult] = await connection.query(
                'INSERT INTO orders (username, total) VALUES (?, ?)', // Query modificada
                [username.trim(), total] // Valores actualizados
            );
            const orderId = orderResult.insertId;

            // Insertar items y actualizar stock
            for (const item of cartItems) {
                await connection.query(
                    'INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)',
                    [orderId, item.id, item.quantity, item.price]
                );

                await connection.query(
                    'UPDATE products SET stock_count = stock_count - ? WHERE id = ?',
                    [item.quantity, item.id]
                );
            }

            await connection.commit();

            res.status(201).json({
                success: true,
                orderId,
                total: total + 5.99,
                message: 'Orden procesada exitosamente'
            });

        } catch (error) {
            await connection.rollback();
            console.error('Error en transacción:', error);
            res.status(400).json({
                success: false,
                error: error.message
            });
        } finally {
            if (connection) connection.release();
        }
    } catch (error) {
        console.error('Error general:', error);
        res.status(500).json({
            success: false,
            error: 'Error interno del servidor'
        });
    }
});

// Configuración de Vite
(async () => {
    const vite = await createViteServer({
        server: { middlewareMode: true },
        appType: 'spa'
    });

    app.use(vite.middlewares);

    app.use(async (req, res) => {
        try {
            const html = await vite.transformIndexHtml(
                req.originalUrl,
                '<div id="app"></div>'
            );
            res.status(200).set({ 'Content-Type': 'text/html' }).end(html);
        } catch (e) {
            vite.ssrFixStacktrace(e);
            console.error('Error en Vite middleware:', e);
            res.status(500).end(e.message);
        }
    });

    app.listen(PORT, () => {
        console.log(`Servidor ejecutando en http://localhost:${PORT}`);
    });
})();