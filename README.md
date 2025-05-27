


# README - Carbon Craft Labs

## 🚗 Descripción del Proyecto

Este proyecto fué hecho para un trabajo de grado.

Carbon Craft Labs es una plataforma de e-commerce especializada en la venta de piezas automotrices de alto rendimiento y accesorios de detailing. [1](#0-0)  El proyecto implementa una experiencia web moderna con animaciones 3D interactivas, gestión de carrito de compras, procesamiento de órdenes y autenticación de usuarios.

## ✨ Características Principales

- **Página de inicio interactiva**: Experiencia visual con animaciones 3D que responden al movimiento del cursor [2](#0-1) 
- **Catálogo de productos**: Sistema completo de navegación por categorías (Performance y Detailing) [3](#0-2) 
- **Carrito de compras**: Gestión persistente del carrito usando cookies del navegador
- **Procesamiento de órdenes**: Sistema transaccional con validación de inventario [4](#0-3) 
- **Autenticación**: Integración con Clerk para gestión de usuarios [5](#0-4) 
- **Búsqueda avanzada**: Funcionalidad de filtrado por categorías, marcas y especificaciones

## 🛠️ Stack Tecnológico

### Frontend
- **HTML5, CSS3, JavaScript Vanilla**: Interfaz de usuario modular
- **Vite 6.3.5**: Servidor de desarrollo y herramienta de construcción [6](#0-5) 
- **Three.js 0.176.0**: Animaciones 3D para la página de inicio

### Backend
- **Express.js 5.1.0**: Servidor API RESTful [7](#0-6) 
- **MySQL2**: Base de datos relacional para productos y órdenes
- **CORS**: Manejo de peticiones cross-origin

### Servicios Externos
- **Clerk 5.67.4**: Autenticación y gestión de usuarios

## 📁 Estructura del Proyecto

```
proyecto-lenguaje/
├── server/
│   ├── middleware.js          # Servidor Express con API endpoints
│   └── tablesandinsertion.sql # Schema de base de datos
├── src/
│   ├── cart/                  # Módulos del carrito de compras
│   ├── checkout/              # Lógica de checkout
│   ├── common/                # Componentes compartidos
│   ├── landing/               # Página de inicio
│   ├── producto/              # Detalles de productos
│   ├── search/                # Funcionalidad de búsqueda
│   ├── shop/                  # Catálogo de productos
│   └── clerk.js              # Integración de autenticación
├── ScriptsUsed/              # Scripts de utilidad
├── index.html                # Página principal
├── shop.html                 # Página de la tienda
├── product.html              # Página de producto individual
├── cart.html                 # Página del carrito
├── checkout.html             # Página de checkout
├── search.html               # Página de búsqueda
└── contacto.html             # Página de contacto
```

## 🚀 Instalación y Configuración

### Prerrequisitos
- Node.js (versión 16 o superior)
- MySQL
- pnpm (recomendado)

### Variables de Entorno
Crea un archivo `.env` con las siguientes variables: [8](#0-7) 

```env
DB_HOST=localhost
DB_USER=tu_usuario
DB_PASSWORD=tu_contraseña
DB_NAME=carbon_craft_labs
DB_PORT=3306
PORT=5173
VITE_CLERK_PUBLISHABLE_KEY=tu_clerk_key
RESTRICTED_FILES=archivo1.ext,archivo2.ext
```

### Instalación de Dependencias
```bash
pnpm install
```

### Configuración de Base de Datos
Ejecuta el script SQL para crear las tablas necesarias: [9](#0-8) 

```bash
mysql -u tu_usuario -p tu_base_de_datos < server/tablesandinsertion.sql
```

### Iniciar el Servidor
```bash
node server/middleware.js
```

El servidor estará disponible en `http://localhost:5173`

## 📡 API Endpoints

### GET /api/products
Obtiene todos los productos con información completa incluyendo categorías, marcas, características y especificaciones. [10](#0-9) 

### POST /api/orders
Procesa nuevas órdenes con validación de inventario y gestión transaccional. [11](#0-10) 

**Formato de petición:**
```json
{
  "username": "nombre_usuario",
  "items": [
    {
      "id": 1,
      "quantity": 2,
      "price": 99.99
    }
  ]
}
```

## 🗄️ Esquema de Base de Datos

La base de datos utiliza un diseño relacional normalizado con las siguientes entidades principales: [12](#0-11) 

- **products**: Catálogo principal de productos
- **categories/subcategories**: Organización jerárquica de productos
- **brands**: Marcas de productos
- **orders/order_items**: Gestión de órdenes y transacciones
- **product_features/specifications/compatibility**: Metadatos de productos

## 🎯 Categorías de Productos

### Performance
- DownPipes
- Embragues  
- Frenos
- Suspensión
- Escapes
- Intercoolers
- Radiadores

### Detailing
- Body Kits
- Vinilos
- Pegatinas
- Alerones
- Frontales
- Difusores
- Paragolpes [13](#0-12) 

## 🔐 Autenticación

El sistema utiliza Clerk para la gestión de autenticación: [14](#0-13) 

- Registro e inicio de sesión de usuarios
- Gestión de perfiles de usuario
- Protección de rutas sensibles (checkout)
- Integración seamless con el flujo de compra

## 🛒 Flujo de Compra

1. **Navegación**: Los usuarios exploran productos por categorías
2. **Selección**: Agregar productos al carrito desde páginas de detalle
3. **Carrito**: Revisar y modificar items en el carrito
4. **Checkout**: Autenticación y procesamiento de la orden
5. **Confirmación**: Validación de inventario y creación de la orden

## 🎨 Experiencia de Usuario

- **Página de inicio dinámica**: Animaciones 3D que cambian según la posición del cursor [2](#0-1) 
- **Navegación intuitiva**: Sistema de categorías dropdown y búsqueda
- **Responsive design**: Adaptado para diferentes dispositivos
- **Feedback visual**: Estados de carga y confirmaciones de acciones

## 📧 Newsletter

Sistema de suscripción a newsletter integrado en la página principal: [15](#0-14) 

## 🤝 Contribución

Para contribuir al proyecto:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agrega nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Crea un Pull Request
---

**Carbon Craft Labs** - Rendimiento y estilo, sin concesiones. [17](#0-16) 
