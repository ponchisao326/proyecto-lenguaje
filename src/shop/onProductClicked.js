async function productClicked(productId) {
    // Obtener todos los datos del producto de la api
    window.location.href = '/product?id=' + productId;
}
