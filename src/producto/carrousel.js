function initCarousel() {
    const track      = document.getElementById('carousel-track');
    if (!track) return;
    const slides     = Array.from(track.children);
    const prevBtn    = document.querySelector('.carousel-btn.prev');
    const nextBtn    = document.querySelector('.carousel-btn.next');
    const thumbnails = document.querySelectorAll('.thumbnail');
    let currentIndex = 0;

    const updateCarousel = index => {
        const slideWidth = slides[0].getBoundingClientRect().width;
        track.style.transform = `translateX(-${slideWidth * index}px)`;
        thumbnails.forEach(thumb =>
            thumb.classList.toggle('active', +thumb.dataset.index === index)
        );
    };

    // Posición inicial
    updateCarousel(0);

    // Botones Anterior / Siguiente
    prevBtn.addEventListener('click', () => {
        currentIndex = (currentIndex - 1 + slides.length) % slides.length;
        updateCarousel(currentIndex);
    });
    nextBtn.addEventListener('click', () => {
        currentIndex = (currentIndex + 1) % slides.length;
        updateCarousel(currentIndex);
    });

    // Click en miniaturas
    thumbnails.forEach(thumb => {
        thumb.addEventListener('click', () => {
            currentIndex = +thumb.dataset.index;
            updateCarousel(currentIndex);
        });
    });
}

// Llama a initCarousel() cuando tu código de renderizado haya insertado ya el HTML
// Por ejemplo, tras hacer container.innerHTML = tuMarkup;
initCarousel();
