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

async function productClicked(productId) {
    // Obtener todos los datos del producto de la api
    window.location.href = '/product?id=' + productId;
}
