// get cursor position
let cursorPosition;
document.addEventListener('mousemove', (e) => {
    const divDerecha = document.getElementById('divDerecha');
    const divIzquierda = document.getElementById('divIzquierda');
    const box = document.querySelector('.box');

    // Verifica si el cursor está sobre la caja `.box`
    if (box && box.contains(e.target)) {
        divDerecha.classList.remove('cursor-pointer');
        divIzquierda.classList.remove('cursor-pointer');
        return;
    }

    // Verifica si el cursor está dentro del área de `divDerecha`
    if (e.clientX > divDerecha.offsetLeft && e.clientX < divDerecha.offsetLeft + divDerecha.offsetWidth &&
        e.clientY > divDerecha.offsetTop && e.clientY < divDerecha.offsetHeight) {
        divDerecha.classList.add('cursor-pointer');
        console.log('Cursor dentro de divDerecha');
    } else {
        divDerecha.classList.remove('cursor-pointer');
    }

    // Verifica si el cursor está dentro del área de `divIzquierda`
    if (e.clientX > divIzquierda.offsetLeft && e.clientX < divIzquierda.offsetLeft + divIzquierda.offsetWidth &&
        e.clientY > divIzquierda.offsetTop && e.clientY < divIzquierda.offsetHeight) {
        divIzquierda.classList.add('cursor-pointer');
        console.log('Cursor dentro de divIzquierda');
    } else {
        divIzquierda.classList.remove('cursor-pointer');
    }
});