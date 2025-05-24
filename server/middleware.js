import express from 'express';
import { createServer as createViteServer } from 'vite';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5173;

// Lista de archivos prohibidos
const RESTRICTED_FILES = process.env.RESTRICTED_FILES?.split(',') || [];

// Middleware de restricción
app.use((req, res, next) => {
    const requestedFile = req.originalUrl.split('/').pop();
    if (RESTRICTED_FILES.includes(requestedFile)) {
        return res.status(403).send('Acceso prohibido');
    }
    next();
});

// Configuración de Vite
(async () => {
    const vite = await createViteServer({
        server: { middlewareMode: true },
        appType: 'spa' // Cambiado a SPA
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