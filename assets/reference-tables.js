/* Progressive enhancement: all rows remain readable without JavaScript. */
(() => {
  'use strict';
  const normalize = text => text.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLocaleLowerCase('cs');
  document.querySelectorAll('.reference-table').forEach(region => {
    const table = region.querySelector('table');
    const rows = [...table.tBodies[0].rows];
    const texts = rows.map(row => normalize(row.textContent));
    const controls = document.createElement('div');
    controls.className = 'ref-controls';
    controls.innerHTML = `<label>Hledat v celé tabulce <input type="search" aria-controls="${table.id}"></label><label>Řádků na stránce <select aria-controls="${table.id}"><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="all">Všechny</option></select></label>`;
    const pagination = document.createElement('div');
    pagination.className = 'ref-pagination';
    pagination.innerHTML = '<button type="button">Předchozí</button><span class="ref-status" role="status" aria-live="polite"></span><button type="button">Další</button>';
    // Controls stay outside horizontal scrolling; only the table scrolls.
    const wrapper = document.createElement('div');
    wrapper.className = 'table-scroll';
    wrapper.tabIndex = 0;
    wrapper.setAttribute('role', 'region');
    wrapper.setAttribute('aria-label', table.caption?.textContent || 'Přehledová tabulka');
    region.insertBefore(controls, table);
    region.insertBefore(wrapper, table);
    wrapper.append(table);
    region.append(pagination);
    const search = controls.querySelector('input');
    const size = controls.querySelector('select');
    const [previous, next] = pagination.querySelectorAll('button');
    const status = pagination.querySelector('[role="status"]');
    let page = 0;
    const filtered = () => rows.filter((_, index) => texts[index].includes(normalize(search.value.trim())));
    const pageSize = () => size.value === 'all' ? Math.max(rows.length, 1) : Number(size.value);
    function render() {
      const matches = filtered();
      const count = pageSize();
      const pages = Math.max(1, Math.ceil(matches.length / count));
      page = Math.min(Math.max(page, 0), pages - 1);
      rows.forEach(row => { row.hidden = true; });
      matches.slice(page * count, (page + 1) * count).forEach(row => { row.hidden = false; });
      previous.disabled = page === 0;
      next.disabled = page === pages - 1;
      status.textContent = matches.length ? `Zobrazeno ${page * count + 1}–${Math.min((page + 1) * count, matches.length)} z ${matches.length} položek (celkem ${rows.length}). Stránka ${page + 1} z ${pages}.` : (rows.length ? 'Žádná odpovídající položka.' : 'Dosud nejsou zavedeny žádné položky.');
    }
    function revealHash() {
      let id;
      try { id = decodeURIComponent(location.hash.slice(1)); } catch { return; }
      const target = document.getElementById(id);
      const row = target?.closest('tr');
      if (!rows.includes(row)) return;
      search.value = '';
      page = Math.floor(rows.indexOf(row) / pageSize());
      render();
      rows.forEach(item => item.classList.remove('highlight'));
      row.classList.add('highlight');
      row.tabIndex = -1;
      requestAnimationFrame(() => { row.focus({ preventScroll: true }); row.scrollIntoView({ block: 'center' }); });
    }
    search.addEventListener('input', () => { page = 0; render(); });
    size.addEventListener('change', () => { page = 0; render(); });
    previous.addEventListener('click', () => { page--; render(); });
    next.addEventListener('click', () => { page++; render(); });
    window.addEventListener('hashchange', revealHash);
    // A repeated click on the current hash must also clear an active filter.
    document.addEventListener('click', event => {
      const link = event.target.closest('a[href]');
      if (!link) return;
      const url = new URL(link.href, location.href);
      if (url.pathname === location.pathname && url.hash === location.hash) revealHash();
    });
    render();
    revealHash();
  });
})();
