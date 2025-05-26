const product_container = document.getElementById('product-container');

async function getProduct(productId) {
    const response = await fetch(`/api/products`);
    if (!response.ok) {
        throw new Error('Error al obtener el producto: ' + response.status);
    }
    const products = await response.json();

    const [firstProduct, ...restProducts] = products;

    // Recorrer los productos y buscar el que coincida con el ID
    if (productId) {
        const product = products.find(p => p.id === productId);
        return product || null; // Retorna el producto encontrado o null si no existe
    }
    return product;
}

// carrousel.js
document.addEventListener('DOMContentLoaded', async () => {
    // 1) Get the “id” query-param
    const urlParams = new URLSearchParams(window.location.search);
    const idParam = urlParams.get('id');
    if (!idParam) {
        console.warn('No product ID provided in URL');
        alert('No se ha proporcionado un ID de producto');
        window.location.href = '/shop'; // Redirigir al catálogo de productos
        return;
    }

    const productId = parseInt(idParam, 10);
    if (Number.isNaN(productId)) {
        console.error('Invalid product ID:', idParam);
        alert('ID de producto inválido');
        window.location.href = '/shop'; // Redirigir al catálogo de productos
        return;
    }

    // 2) Fetch only that product
    const product = await getProduct(productId);
    if (!product) {
        console.error(`Product with ID ${productId} not found`);
        alert(`Producto con ID ${productId} no encontrado`);
        window.location.href = '/shop'; // Redirigir al catálogo de productos
        return;
    }

    renderProduct(product);
});

// 1) Función que crea el HTML de las estrellas
function renderStars(rating, maxStars = 5) {
    const fullStars  = Math.floor(rating);
    const halfStar   = (rating - fullStars) >= 0.5 ? 1 : 0;
    const emptyStars = maxStars - fullStars - halfStar;
    let html = '';

    // Estrellas llenas
    for (let i = 0; i < fullStars; i++) {
        html += '★';
    }
    // Media estrella (puedes sustituir por otro carácter o ícono si lo prefieres)
    if (halfStar) {
        html += '☆';
    }
    // Estrellas vacías
    for (let i = 0; i < emptyStars; i++) {
        html += '☆';
    }
    return html;
}

// ${Object.entries(product.specifications).map(([key, value]) => `<li>${key}: ${value}</li>`).join('')}
function renderProduct(product) {
    const starsHtml = renderStars(product.rating);

    const productHTML = `<div class="gallery-section">
        <div class="carousel">
            <button class="carousel-btn prev" aria-label="Imagen anterior">‹</button>
            <div class="carousel-track" id="carousel-track">
                <img src="${product.images[0]}" alt="${(product.description || '').replace(/"/g, '&quot;').replace(/'/g, '&#39;')} 1" class="carousel-slide">
                <img src="${product.images[1]}" alt="${(product.description || '').replace(/"/g, '&quot;').replace(/'/g, '&#39;')} 2" class="carousel-slide">
                <img src="${product.images[2]}" alt="${(product.description || '').replace(/"/g, '&quot;').replace(/'/g, '&#39;')} 3" class="carousel-slide">
                <img src="${product.images[3]}" alt="${(product.description || '').replace(/"/g, '&quot;').replace(/'/g, '&#39;')} 4" class="carousel-slide">
            </div>
            <button class="carousel-btn next" aria-label="Imagen siguiente">›</button>
        </div>

        <div class="thumbnails">
            <img src="${product.images[0]}" data-index="0" class="thumbnail">
            <img src="${product.images[1]}" data-index="1" class="thumbnail">
            <img src="${product.images[2]}" data-index="2" class="thumbnail">
            <img src="${product.images[3]}" data-index="3" class="thumbnail">
        </div>
    </div>


    <div class="product-info">
        <div class="brand">${product.brand_name}</div>
        <h1 class="product-title">${product.name}</h1>
        
        <div class="rating">
          <span class="stars">${starsHtml}</span>
          <span class="info">${product.rating} (${product.reviews} reseñas)</span>
        </div>

        <div class="price">${product.price} €</div>

        <div class="stock">${product.stock_count > 0 ? `En stock: (${product.stock_count} unidades)` : 'Agotado'}</div>

        <p class="description">${product.description}</p>

        <ul class="features-list">
            <li>${product.features[0]}</li>
            <li>${product.features[1]}</li>
            <li>${product.features[2]}</li>
            <li>${product.features[3]}</li>
        </ul>

        <div class="specs-grid">
            ${Object.entries(product.specifications)
        .map(([key, value]) => `
    <div class="spec-item">
      <strong>${key}</strong><br>
      ${value}
    </div>
  `)
        .join('')}
        </div>

        <div class="compatibility">
            Compatible con: ${product.compatible_models}
        </div>

        <button class="add-to-cart">Añadir al carrito</button>
    </div>`

    product_container.innerHTML = productHTML;
    initCarousel();
}
