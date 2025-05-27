import { getCart } from "../cart/productRender.js";

document.addEventListener('DOMContentLoaded', () => {
    const cart = getCart();
    if (cart.length === 0) {
        document.getElementById('order-summary').innerHTML = '<p>Your cart is empty.</p>';
        return;
    }

    const orderSummary = document.getElementById('order-summary');

    let summarySet = new Set();
    let totalAmount = 0;
    cart.forEach(product => {
        const item = `<div class="summary-item"><span>${product.name} X${product.quantity}</span><span>${(product.price * product.quantity).toFixed(2)}€</span></div>`
        summarySet.add(item);

        totalAmount += product.price * product.quantity;
    })
    const cartResumeHTML = `
        <h2>Order Summary</h2>
        ${
            Array.from(summarySet).join('')
    }
        <div class="divisory-line"></div>
        <div class="summary-item"><span>Subtotal</span><span>${totalAmount}€</span></div>
        <div class="summary-item"><span>Shipping</span><span>5.99€</span></div>
        <div class="summary-item"><span>Tax</span><span>FREE</span></div>
        <div class="summary-item total"><span>Total</span><span>${(totalAmount + 5.99).toFixed(2)}</span></div>
        <button type="button" class="btn">Complete Order - ${(totalAmount + 5.99).toFixed(2)}€</button>
        <p class="terms">By completing your order, you agree to our Terms of Service and Privacy Policy.</p>
    `

    orderSummary.insertAdjacentHTML('afterbegin', cartResumeHTML);
})
