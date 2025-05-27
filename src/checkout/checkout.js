import { getCart, clearCart } from "../cart/productRender.js";
import { clerk } from "../clerk.js";

function loadContent() {
    const cart = getCart();
    if (cart.length === 0) {
        document.getElementById('order-summary').innerHTML = '<p>Your cart is empty.</p>';
        return;
    }

    renderCartSummary(cart);
    setupCheckoutButton(cart);
}

function renderCartSummary(cart) {
    const orderSummary = document.getElementById('order-summary');

    // Limpiar contenido existente
    orderSummary.innerHTML = '';

    let summaryHTML = '';
    let totalAmount = 0;

    cart.forEach(product => {
        summaryHTML += `
            <div class="summary-item">
                <span>${product.name} X${product.quantity}</span>
                <span>${(product.price * product.quantity).toFixed(2)}€</span>
            </div>
        `;
        totalAmount += product.price * product.quantity;
    });

    const cartResumeHTML = `
        <h2>Order Summary</h2>
        ${summaryHTML}
        <div class="divisory-line"></div>
        <div class="summary-item"><span>Subtotal</span><span>${totalAmount.toFixed(2)} €</span></div>
        <div class="summary-item"><span>Shipping</span><span>5.99 €</span></div>
        <div class="summary-item"><span>Tax</span><span>FREE</span></div>
        <div class="summary-item total"><span>Total</span><span>${(totalAmount + 5.99).toFixed(2)} €</span></div>
        <button type="button" class="btn" id="complete-order">Complete Order - ${(totalAmount + 5.99).toFixed(2)} €</button>
        <p class="terms">By completing your order, you agree to our Terms of Service and Privacy Policy.</p>
    `;

    orderSummary.innerHTML = cartResumeHTML;
}

function setupCheckoutButton(cart) {
    const checkoutButton = document.getElementById('complete-order');
    const username = clerk.user ? clerk.user.firstName : 'Guest';

    checkoutButton.addEventListener('click', async () => {

        if (!username) {
            showErrorMessage('Por favor ingresa tu nombre de usuario');
            return;
        }

        checkoutButton.disabled = true;
        checkoutButton.textContent = 'Processing...';

        try {
            const response = await fetch('/api/orders', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    username: username,
                    items: cart
                })
            });

            const result = await response.json();

            if (result.success) {
                clearCart();
                showSuccessMessage(result.orderId);
            } else {
                showErrorMessage(result.error);
            }
        } catch (error) {
            showErrorMessage('Error connecting to server: ' + error.message);
        } finally {
            checkoutButton.disabled = false;
            checkoutButton.textContent = `Complete Order - ${cartTotal(cart)}€`;
        }
    });
}


function cartTotal(cart) {
    return cart.reduce((sum, item) => sum + (item.price * item.quantity), 0) + 5.99;
}

function showSuccessMessage(orderId) {
    const successHTML = `
            🎉 Order Completed!
            Your order ID: ${orderId}
            You will receive a confirmation email shortly.
    `;
    alert(successHTML);
}

function showErrorMessage(message) {
    const errorHTML = `
        <div class="error-message">
            <h2>⚠️ Error Processing Order</h2>
            <p>${message}</p>
            <p>Please try again or contact support.</p>
        </div>
    `;
    document.getElementById('after').insertAdjacentHTML('afterend', errorHTML);
}

loadContent();