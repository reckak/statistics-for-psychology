/* Sidebar: the part "Interaktivní vizualizace" starts collapsed.
   Quarto offers only a global collapse level, which would also fold the chapters. This script
   folds one part by its title unless the current page belongs to it; the arrow still opens it
   (Bootstrap collapse). Without JavaScript the part stays open. Loaded without defer from
   assets/after-body.html, so the sidebar is folded before the first paint. */
(() => {
  'use strict';
  const TITLE = 'Interaktivní vizualizace';
  const sidebar = document.getElementById('quarto-sidebar');
  if (!sidebar) return;
  for (const section of sidebar.querySelectorAll('li.sidebar-item-section')) {
    const header = section.querySelector(':scope > .sidebar-item-container');
    const list = section.querySelector(':scope > ul.collapse');
    if (!header || !list) continue;
    const text = header.querySelector('.menu-text');
    if (!text || text.textContent.trim() !== TITLE) continue;
    // Keep the part open on its own pages.
    if (list.querySelector('.sidebar-link.active, .sidebar-item.active')) return;
    list.classList.remove('show');
    header.querySelectorAll('[data-bs-toggle="collapse"]').forEach(toggle => {
      toggle.classList.add('collapsed');
      toggle.setAttribute('aria-expanded', 'false');
    });
    return;
  }
})();
