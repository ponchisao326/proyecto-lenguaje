// Objeto para crear variable de estado (derecha | izquierda)
export let estado = {
    lado: null // Puede ser 'derecha', 'izquierda' o null
};
document.addEventListener('mousemove', (e) => {
    const divDerecha = document.getElementById('divDerecha');
    const divIzquierda = document.getElementById('divIzquierda');

    // Verifica si el cursor está dentro del área de `divDerecha`
    if (e.clientX > divDerecha.offsetLeft && e.clientX < divDerecha.offsetLeft + divDerecha.offsetWidth &&
        e.clientY > divDerecha.offsetTop && e.clientY < divDerecha.offsetHeight) {
        divDerecha.classList.add('cursor-pointer');

        estado.lado = 'derecha';
    } else {
        divDerecha.classList.remove('cursor-pointer');
    }

    // Verifica si el cursor está dentro del área de `divIzquierda`
    if (e.clientX > divIzquierda.offsetLeft && e.clientX < divIzquierda.offsetLeft + divIzquierda.offsetWidth &&
        e.clientY > divIzquierda.offsetTop && e.clientY < divIzquierda.offsetHeight) {
        divIzquierda.classList.add('cursor-pointer');

        estado.lado = 'izquierda';
    } else {
        divIzquierda.classList.remove('cursor-pointer');
    }
});