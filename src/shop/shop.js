// shop.js (acordeón y ejemplo de renderizado de filtros)
document.querySelectorAll('.accordion-trigger').forEach(btn => {
    btn.addEventListener('click', function() {
        const item = this.closest('.accordion-item');
        item.classList.toggle('open');
    });
});

// Ejemplo de renderizado dinámico de categorías y marcas
const categories = ['DownPipes', 'Embragues', 'Frenos', 'Suspension', 'Escapes', 'Intercoolers', 'Radiadores'];
const brands = ['Audi', 'BMW', 'Ford', 'Mercedes', 'Mini', 'Nissan', 'Porsche', 'SEAT', 'Volvo'];

function renderCheckboxList(list, containerId, name) {
    const container = document.getElementById(containerId);
    container.innerHTML = '';
    list.forEach(item => {
        const id = `${name}-${item}`;
        container.innerHTML += `
      <div class="filter-checkbox">
        <input type="checkbox" id="${id}" name="${name}" value="${item}">
        <label for="${id}">${item}</label>
      </div>
    `;
    });
}
renderCheckboxList(categories, 'category-list', 'category');
renderCheckboxList(brands, 'brand-list', 'brand');