// FAQ acordeón simple
document.querySelectorAll('.faq-question').forEach(q => {
    q.addEventListener('click', function() {
        const item = this.parentElement;
        item.classList.toggle('active');
    });
});