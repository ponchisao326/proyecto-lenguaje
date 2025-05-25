import {API_URL} from "../common/globalVars.js";

// Obtener productos
async function loadProducts() {
    try {
        const response = await fetch(`${API_URL}/products`);
        if (!response.ok) throw new Error('Error HTTP: ' + response.status);

        const products = await response.json();

        // Guardar en variables o procesar
        const [firstProduct, ...restProducts] = products;

        // Renderizar
        const container = document.getElementById('products-container');

        // ${product.images.map(img => `<img src="${img}" alt="${product.name}">`).join('')} => Coger todas las imágenes
        products.forEach(product => {
            const productHTML = `
        <div class="product-card" onclick="productClicked(${product.id})">
          <div class="gallery">
          <img src="${product.images[0]}" alt="${product.name}">
          </div>
          <h2>${product.name}</h2>
          <p class="price">$${product.price}</p>
          <div class="specs">
            ${Object.entries(product.specifications).map(([key, val]) => `
              <p><strong>${key}:</strong> ${val}</p>
            `).join('')}
          </div>
        </div>
      `;
            container.insertAdjacentHTML('beforeend', productHTML);
        });

    } catch (error) {
        console.error('Error cargando productos:', error);
        // Mostrar mensaje de error al usuario
    }
}

// Iniciar carga
loadProducts();