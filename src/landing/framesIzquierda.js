import { isDerecha } from "./globalVars.js";

// Parámetros de animación
const MIN_FRAME = 0;
const MAX_FRAME = 118;
const fps = 60;

// Elementos y estado
export const main = document.getElementById("main");
let animationInterval = null;
let currentFrame = MIN_FRAME;
let direction = 1;
let isPaused = false;

// Pre-carga de imágenes
const framesIzquierda = [];
for (let i = MIN_FRAME; i <= MAX_FRAME; i++) {
    const img = new Image();
    img.src = `/performance/${String(i).padStart(5, '0')}.webp`;
    framesIzquierda.push(img);
}

function renderFrameIzquierda() {
    if (isPaused || isDerecha.value) return;

    currentFrame += direction;

    if (currentFrame > MAX_FRAME || currentFrame < MIN_FRAME) {
        isPaused = true;
        setTimeout(() => {
            direction *= -1;
            currentFrame = Math.min(MAX_FRAME, Math.max(MIN_FRAME, currentFrame));
            isPaused = false;
        }, 500);
        return;
    }

    const img = framesIzquierda[currentFrame - MIN_FRAME];
    main.style.backgroundImage = `url(${img.src})`;
}

function startAnimation() {
    stopAnimation();
    animationInterval = setInterval(renderFrameIzquierda, 1000 / fps);
}

function stopAnimation() {
    if (animationInterval) {
        clearInterval(animationInterval);
        animationInterval = null;
    }
}

export { framesIzquierda, startAnimation, stopAnimation };