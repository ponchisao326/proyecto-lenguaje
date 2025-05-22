// Duplicar dinámicamente las imágenes al cargar para evitar errores de sincronía en el loop
window.addEventListener('DOMContentLoaded', () => {
    const slider = document.querySelector('.slider');
    const slides = Array.from(slider.children);
    slides.forEach(slide => {
        const clone = slide.cloneNode(true);
        slider.appendChild(clone);
    });
});