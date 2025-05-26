// Variable global para almacenar los productos cargados
let allProducts = [];

// Cargar productos al inicio y guardar en allProducts
async function fetchAndStoreProducts() {
    const response = await fetch('/api/products');
    allProducts = await response.json();
    renderProducts(allProducts);
}

// Renderiza los productos en el contenedor
function renderProducts(products) {
    const container = document.getElementById('products-container');
    container.innerHTML = '';
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
}

// Obtiene los filtros seleccionados y filtra los productos
function applyFilters() {
    // Categorías seleccionadas
    const selectedCategories = Array.from(document.querySelectorAll('input[name="category"]:checked')).map(cb => cb.value);
    // Marcas seleccionadas
    const selectedBrands = Array.from(document.querySelectorAll('input[name="brand"]:checked')).map(cb => cb.value);
    // Precio
    const minPrice = parseFloat(document.getElementById('min-price').value) || 0;
    const maxPrice = parseFloat(document.getElementById('max-price').value) || Infinity;
    // Stock
    const inStock = document.getElementById('in-stock').checked;

    const filtered = allProducts.filter(product => {
        const matchCategory = selectedCategories.length === 0 || selectedCategories.includes(product.subcategory_name);
        const matchBrand = selectedBrands.length === 0 || selectedBrands.includes(product.brand_name);
        const matchPrice = product.price >= minPrice && product.price <= maxPrice;
        const matchStock = !inStock || product.in_stock > 0;
        return matchCategory && matchBrand && matchPrice && matchStock;
    });

    renderProducts(filtered);
}

// Escucha cambios en todos los filtros
document.addEventListener('input', (event) => {
    if (
        event.target.name === 'category' ||
        event.target.name === 'brand' ||
        event.target.id === 'min-price' ||
        event.target.id === 'max-price' ||
        event.target.id === 'in-stock'
    ) {
        applyFilters();
    }
});

// Inicializa productos y filtros al cargar la página
fetchAndStoreProducts();