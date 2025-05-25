import {API_URL} from "../common/globalVars.js";

// Cargar productos desde la API
async function loadProducts() {
    try {
        const response = await fetch(`${API_URL}/products`);
        if (!response.ok) throw new Error('Error HTTP: ' + response.status);

        return await response.json();
    } catch (error) {
        console.error('Error cargando productos:', error);
        return [];
    }
}

// Obtener categorías y marcas únicas de los productos
async function loadCategoriesAndBrands() {
    try {
        const productos = await loadProducts();

        const categories = new Set();
        const brands = new Set();
        productos.forEach(product => {
            if (product.subcategory_name) categories.add(product.subcategory_name);
            if (product.brand_name) brands.add(product.brand_name);
        });
        // Convertir Set a Array y ordenar
        const sortedCategories = Array.from(categories).sort();
        const sortedBrands = Array.from(brands).sort();

        return {
            categories: sortedCategories,
            brands: sortedBrands
        };
    } catch (error) {
        console.error('Error cargando categorías y marcas:', error);
        return { categories: [], brands: [] };
    }
}

// Renderizar lista de checkboxes para filtros
function renderCheckboxList(list, containerId, name) {
    const container = document.getElementById(containerId);
    container.innerHTML = '';
    list.forEach(item => {
        const id = `${name}-${item}`;
        container.innerHTML += `
      <div class="filter-checkbox">
        <input type="checkbox" id="${id}" name="${name}" value="${item}">
        <label for="${id}">${item}</label>
      </div>
    `;
    });
}

// Inicializar filtros al cargar la página
async function initFilters() {
    const { categories, brands } = await loadCategoriesAndBrands();
    renderCheckboxList(categories, 'category-list', 'category');
    renderCheckboxList(brands, 'brand-list', 'brand');
}

initFilters();

// Acordeon
document.querySelectorAll('.accordion-trigger').forEach(btn => {
    btn.addEventListener('click', function() {
        const item = this.closest('.accordion-item');
        item.classList.toggle('open');
    });
});