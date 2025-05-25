import express from 'express';
import { createServer as createViteServer } from 'vite';
import mysql from 'mysql2/promise';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5173;

// Configurar CORS
app.use(cors());

// Configurar conexión MySQL
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Middleware de restricción
const RESTRICTED_FILES = process.env.RESTRICTED_FILES?.split(',') || [];
app.use((req, res, next) => {
    const requestedFile = req.originalUrl.split('/').pop();
    if (RESTRICTED_FILES.includes(requestedFile)) {
        return res.status(403).send('Acceso prohibido');
    }
    next();
});

// 👇🏼 Aquí agregamos el endpoint de productos
app.get('/api/products', async (req, res) => {
    try {
        const [products] = await pool.query(`
            SELECT
                p.*,
                GROUP_CONCAT(DISTINCT f.feature) AS features,
                GROUP_CONCAT(DISTINCT CONCAT(s.spec_name, ':', s.spec_value) ORDER BY s.spec_name) AS specifications,
                GROUP_CONCAT(DISTINCT c.compatible_model ORDER BY c.compatible_model) AS compatible_models,
                GROUP_CONCAT(DISTINCT i.image_url ORDER BY i.image_url) AS images
            FROM products p
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
        console.error(error);
        res.status(500).json({ error: 'Error al obtener productos' });
    }
});

// Configuración de Vite
(async () => {
    const vite = await createViteServer({
        server: { middlewareMode: true },
        appType: 'spa'
    });

    // Usar el middleware de Vite
    app.use(vite.middlewares);

    // Manejar todas las rutas
    app.use(async (req, res) => {
        try {
            const html = await vite.transformIndexHtml(
                req.originalUrl,
                '<div id="app"></div>'
            );
            res.status(200).set({ 'Content-Type': 'text/html' }).end(html);
        } catch (e) {
            vite.ssrFixStacktrace(e);
            console.error(e);
            res.status(500).end(e.message);
        }
    });

    app.listen(PORT, () => {
        console.log(`Servidor ejecutando en http://localhost:${PORT}`);
    });
})();