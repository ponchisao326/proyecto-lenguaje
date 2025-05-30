const productsContainer = document.getElementById("products-container");

function getCart() {
    try {
        const cookiePair = document.cookie
            .split('; ')
            .find(row => row.startsWith('cart='));

        if (!cookiePair) return [];

        const cookieValue = cookiePair.split('=')[1];
        return JSON.parse(decodeURIComponent(cookieValue)) || [];
    } catch (error) {
        console.error('Error parsing cart cookie:', error);
        return [];
    }
}

function setCart(cart) {
    document.cookie = "cart=" + encodeURIComponent(JSON.stringify(cart)) + "; path=/;";
}

document.addEventListener("DOMContentLoaded", () => {
    if (window.location.pathname !== '/cart') {
        return; // No hacer nada si no estamos en la página del carrito
    }
    const cart = getCart();

    let totalSet = new Set();
    let productsHTML = '';
    cart.forEach(product => {
        let totalPrice = product.price * product.quantity;
        totalSet.add(totalPrice);

        const productHTML = `
               <div class="cart-product">
                   <div class="product-image-container">
                       <img src="${product.image}" alt="${product.name} image" class="product-image">
                   </div>
                   <div class="product-header">
                       <h2 class="product-title">${product.name}</h2>
                       <p class="product-price">${product.price} €</p>
                       <div class="product-quantity">
                           <button class="quantity-button">-</button>
                           <input type="number" value="${product.quantity}" class="quantity-input">
                           <button class="quantity-button">+</button>
                       </div>
                   </div>
                   <div class="product-details">
                       <div class="total-product">
                           <p class="product-total-price">${totalPrice} €</p>
                           <button class="remove-button"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2 w-4 h-4"><path d="M3 6h18"></path><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path><line x1="10" x2="10" y1="11" y2="17"></line><line x1="14" x2="14" y1="11" y2="17"></line></svg></button>
                       </div>
                   </div>
               </div>
           `;
        productsHTML += productHTML;
    });
    productsContainer.insertAdjacentHTML('afterbegin', productsHTML);


    let totalAmount = 0;
    // Calcular el total del carrito
    totalSet.forEach(precio => {
        totalAmount += precio;
    })
    const asideHTML = `
           <aside>
               <div class="cart-summary">
                   <h2>Resumen del Carrito</h2>
                   <p class="summary-item">Subtotal: <span class="summary-price">${totalAmount.toFixed(2)} €</span></p>
                   <p class="summary-item">Envío: <span class="summary-price">Calculado al pagar</span></p>
                   <p class="summary-item">Envío: <span class="summary-price">5.99€</span></p>
                   <div class="divisory-line"></div>
                   <p class="summary-item">Total: <span class="summary-price">${(totalAmount + 5.99).toFixed(2)}</span></p>
                   <button class="checkout-button" onclick="window.location.href = \`/checkout\`">Proceder al Pago</button>
               </div>
           </aside>
       `;

    productsContainer.insertAdjacentHTML('beforeend', asideHTML);
});

function updateCartDisplay() {
    if (window.location.pathname !== '/cart') {
        return; // No hacer nada si no estamos en la página del carrito
    }
    // Limpia y vuelve a renderizar los productos y el resumen
    productsContainer.innerHTML = '';
    const cart = getCart();
    let totalAmount = 0;
    let productsHTML = '';
    cart.forEach((product, idx) => {
        let totalPrice = product.price * product.quantity;
        totalAmount += totalPrice;
        productsHTML += `
            <div class="cart-product" data-index="${idx}">
                <div class="product-image-container">
                    <img src="${product.image}" alt="${product.name} image" class="product-image">
                </div>
                <div class="product-header">
                    <h2 class="product-title">${product.name}</h2>
                    <p class="product-price">${product.price} €</p>
                    <div class="product-quantity">
                        <button class="quantity-button minus">-</button>
                        <input type="number" value="${product.quantity}" min="1" class="quantity-input">
                        <button class="quantity-button plus">+</button>
                    </div>
                </div>
                <div class="product-details">
                    <div class="total-product">
                        <p class="product-total-price">${totalPrice} €</p>
                        <button class="remove-button"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2 w-4 h-4"><path d="M3 6h18"></path><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path><line x1="10" x2="10" y1="11" y2="17"></line><line x1="14" x2="14" y1="11" y2="17"></line></svg></button>
                    </div>
                </div>
            </div>
        `;
    });
    productsContainer.insertAdjacentHTML('afterbegin', productsHTML);

    const asideHTML = `
        <aside>
            <div class="cart-summary">
                <h2>Resumen del Carrito</h2>
                <p class="summary-item">Subtotal: <span class="summary-price">${totalAmount.toFixed(2)} €</span></p>
                <p class="summary-item">Envío: <span class="summary-price">5.99€</span></p>
                <div class="divisory-line"></div>
                <p class="summary-item">Total: <span class="summary-price">${(totalAmount + 5.99).toFixed(2)} €</span></p>
                <button class="checkout-button" onclick="window.location.href = '/checkout'">Proceder al Pago</button>
            </div>
        </aside>
    `;
    productsContainer.insertAdjacentHTML('beforeend', asideHTML);

    addQuantityListeners();
}

function addQuantityListeners() {
    document.querySelectorAll('.cart-product').forEach(productDiv => {
        const idx = parseInt(productDiv.dataset.index);
        const minusBtn = productDiv.querySelector('.minus');
        const plusBtn = productDiv.querySelector('.plus');
        const input = productDiv.querySelector('.quantity-input');
        const removeBtn = productDiv.querySelector('.remove-button');

        minusBtn.addEventListener('click', () => {
            let cart = getCart();
            if (cart[idx].quantity > 1) {
                cart[idx].quantity--;
                setCart(cart);
                updateCartDisplay();
            }
        });

        plusBtn.addEventListener('click', () => {
            let cart = getCart();
            cart[idx].quantity++;
            setCart(cart);
            updateCartDisplay();
        });

        input.addEventListener('change', () => {
            let cart = getCart();
            let val = parseInt(input.value);
            if (isNaN(val) || val < 1) val = 1;
            cart[idx].quantity = val;
            setCart(cart);
            updateCartDisplay();
        });

        removeBtn.addEventListener('click', () => {
            let cart = getCart();
            cart.splice(idx, 1);
            setCart(cart);
            updateCartDisplay();
        });
    });
}

document.addEventListener("DOMContentLoaded", updateCartDisplay);

// Vaciar el carrito
function clearCart() {
    document.cookie = "cart=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
    window.location.reload();
}

export { getCart, setCart, clearCart, updateCartDisplay };