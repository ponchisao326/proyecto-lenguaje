import { isDerecha } from "./globalVars.js";
import {main} from "./framesIzquierda.js";

// Parámetros de animación
const MIN_FRAME = 0;
const MAX_FRAME = 491;
const fps = 30;

// Elementos y estado
let animationInterval = null;
let currentFrame = MIN_FRAME;
let isPaused = false;

// Pre-carga de imágenes
const framesDerecha = [];
for (let i = MIN_FRAME; i <= MAX_FRAME; i++) {
    const img = new Image();
    img.src = `/detailing/${String(i).padStart(5, '0')}.webp`;
    framesDerecha.push(img);
}

function renderFrameDerecha() {
    if (isPaused || !isDerecha.value) return;

    currentFrame++;

    if (currentFrame > MAX_FRAME) {
        isPaused = true;
        setTimeout(() => {
            currentFrame = MIN_FRAME;
            isPaused = false;
        }, 500);
        return;
    }

    const img = framesDerecha[currentFrame];
    main.style.backgroundImage = `url(${img.src})`;
}

function startAnimationRight() {
    stopAnimationRight();
    animationInterval = setInterval(renderFrameDerecha, 1000 / fps);
}

function stopAnimationRight() {
    if (animationInterval) {
        clearInterval(animationInterval);
        animationInterval = null;
    }
}

export { framesDerecha, startAnimationRight, stopAnimationRight };