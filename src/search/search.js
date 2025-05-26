const searchInput = document.getElementById('search-input');

// Obtener todos los productos
async function getProducts() {
    const response = await fetch(`/api/products`);
    if (!response.ok) {
        throw new Error('Error al obtener el producto: ' + response.status);
    }
    const products = await response.json();

    const [firstProduct, ...restProducts] = products;

    return products;
}

async function showProducts(searchTerm) {
    const resultItem = document.getElementById('results-list');

    const products = await getProducts();

    const foundProducts = products.filter(product =>
        product.name.toLowerCase().includes(searchTerm.toLowerCase())
    );

    if (foundProducts.length > 0) {
        let resultHTML = '';
        foundProducts.forEach(product => {
            resultHTML += `
        <li class="result-item">
            <a href="/product?id=${product.id}" class="result-title">${product.name}</a>
            <div class="result-url">${window.location.origin}/product?id=${product.id}</div>
            <p class="result-description">${product.description}</p>
        </li>`;
        });
        resultItem.innerHTML = resultHTML;
    } else {
        resultItem.innerHTML = '<li class="result-item">No se encontraron productos.</li>';
    }
}

document.addEventListener('DOMContentLoaded', async () => {
    // 1) Get the “id” query-param
    const urlParams = new URLSearchParams(window.location.search);
    const searchParam = urlParams.get('query');
    if (!searchParam) {
        console.warn('No product search provided in URL');
        return;
    }

    await showProducts(searchParam);
});

searchInput.addEventListener('input', async () => {
    const searchTerm = searchInput.value.trim();
    if (searchTerm.length > 0) {
        await showProducts(searchTerm);
    } else {
        document.getElementById('results-list').innerHTML = '';
    }
})
