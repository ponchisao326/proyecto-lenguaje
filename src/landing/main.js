import {main, startAnimation, stopAnimation} from "./framesIzquierda.js";
import { startAnimationRight, stopAnimationRight } from "./framesDerecha.js";
import { isDerecha } from "./globalVars.js";

// Configuración inicial
let estado = { lado: null };
const divDerecha = document.getElementById('divDerecha');
const divIzquierda = document.getElementById('divIzquierda');
const performance = document.getElementById('performance');
const detailing = document.getElementById('detailing');

document.addEventListener('mousemove', (e) => {
    const rect = main.getBoundingClientRect();
    const dentroDeMain =
        e.clientX >= rect.left &&
        e.clientX <= rect.right &&
        e.clientY >= rect.top &&
        e.clientY <= rect.bottom;

    if (!dentroDeMain) {
        return;
    }

    // Detectar lado derecho
    if (e.clientX > window.innerWidth / 2) {
        if (estado.lado !== 'derecha') {
            performance.classList.remove('box-selected');
            detailing.classList.add('box-selected');
            stopAnimation();
            isDerecha.value = true;
            estado.lado = 'derecha';
            startAnimationRight();
        }
        divDerecha.classList.add('cursor-pointer');
        divIzquierda.classList.remove('cursor-pointer');
    }
    // Detectar lado izquierdo
    else {
        if (estado.lado !== 'izquierda') {
            performance.classList.add('box-selected');
            detailing.classList.remove('box-selected');
            stopAnimationRight();
            isDerecha.value = false;
            estado.lado = 'izquierda';
            startAnimation();
        }
        divIzquierda.classList.add('cursor-pointer');
        divDerecha.classList.remove('cursor-pointer');
    }
});

// Iniciar animación inicial
startAnimation();

// onClick para los divs
divDerecha.addEventListener('click', () => {
    window.location.href = '/detailing';
});

divIzquierda.addEventListener('click', () => {
    window.location.href = '/performance';
});
