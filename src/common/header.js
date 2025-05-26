// Header.js

// Ventana de búsqueda
function searchToggle() {
    // Crear un overlay de búsqueda si no existe
        let overlay = document.getElementById('search-overlay');
        if (!overlay) {
            overlay = document.createElement('div');
            overlay.id = 'search-overlay';
            overlay.style.position = 'fixed';
            overlay.style.top = 0;
            overlay.style.left = 0;
            overlay.style.width = '100vw';
            overlay.style.height = '100vh';
            overlay.style.background = 'rgba(0,0,0,0.7)';
            overlay.style.display = 'flex';
            overlay.style.justifyContent = 'center';
            overlay.style.alignItems = 'center';
            overlay.style.zIndex = 1000;

            // Contenedor del input
            const box = document.createElement('div');
            box.style.background = '#fff';
            box.style.padding = '2rem';
            box.style.borderRadius = '10px';
            box.style.boxShadow = '0 4px 32px rgba(0,0,0,0.2)';
            box.style.display = 'flex';
            box.style.flexDirection = 'column';
            box.style.alignItems = 'center';
            box.style.justifyContent = 'center';

            const box2 = document.createElement('div');
            box2.style.display = 'flex';
            box2.style.justifyContent = 'center';
            box2.style.gap = '2rem';

            const input = document.createElement('input');
            input.type = 'text';
            input.placeholder = 'Buscar...';
            input.style.fontSize = '1.5rem';
            input.style.padding = '0.5rem 1rem';
            input.style.width = '300px';
            input.style.border = '1px solid #ccc';
            input.style.borderRadius = '5px';

            // Botón para cerrar
            const closeBtn = document.createElement('button');
            closeBtn.textContent = 'Cerrar';
            closeBtn.style.marginTop = '1rem';
            closeBtn.style.padding = '0.5rem 1.5rem';
            closeBtn.style.fontSize = '1rem';
            closeBtn.style.background = '#35424a';
            closeBtn.style.color = '#fff';
            closeBtn.style.border = 'none';
            closeBtn.style.borderRadius = '5px';
            closeBtn.style.cursor = 'pointer';

            const searchBtn = document.createElement('button');
            searchBtn.textContent = 'Buscar';
            searchBtn.style.marginTop = '1rem';
            searchBtn.style.marginRight = '1rem';
            searchBtn.style.padding = '0.5rem 1.5rem';
            searchBtn.style.fontSize = '1rem';
            searchBtn.style.background = '#35424a';
            searchBtn.style.color = '#fff';
            searchBtn.style.border = 'none';
            searchBtn.style.borderRadius = '5px';
            searchBtn.style.cursor = 'pointer';

            closeBtn.onclick = () => {
                overlay.remove();
            };

            searchBtn.onclick = async () => {
                if (input.value.length < 1) {
                    alert('Es necesario escribir algo para buscar');
                    return;
                }

                window.location.href = `/search?query=${encodeURIComponent(input.value)}`;
                overlay.remove();
            };

            box.appendChild(input);
            box2.appendChild(searchBtn);
            box2.appendChild(closeBtn);
            overlay.appendChild(box);
            box.appendChild(box2);
            document.body.appendChild(overlay);

            // Cerrar con Escape
            overlay.tabIndex = -1;
            overlay.focus();
            overlay.addEventListener('keydown', (e) => {
                if (e.key === 'Escape') overlay.remove();
                if (e.key === 'Enter') {
                    if (input.value.length < 1) {
                        alert('Es necesario escribir algo para buscar');
                        return;
                    }
                    window.location.href = `/search?query=${encodeURIComponent(input.value)}`;
                    overlay.remove();
                }
            });
        }
}

// Carrito (TODO: Implementar)

// Hamburguesa en movil (TODO: Implementar)
