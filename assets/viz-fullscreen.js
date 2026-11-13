/* Full-screen view of interactive visualizations (part "Interaktivní vizualizace").
   Adds a button to every .viz block; the whole block (controls, results, charts, tables)
   goes full screen and stays interactive. The class viz-is-fullscreen lets the OJS code
   raise its chart width cap; each visualization redraws through its own ResizeObserver.
   Browsers without element full screen (for example Safari on iPhone) get no button. */
(() => {
  'use strict';
  const request = el => (el.requestFullscreen || el.webkitRequestFullscreen).call(el);
  const exit = () => (document.exitFullscreen || document.webkitExitFullscreen).call(document);
  const current = () => document.fullscreenElement || document.webkitFullscreenElement || null;
  const enabled = document.fullscreenEnabled || document.webkitFullscreenEnabled;
  if (!enabled) return;

  const OPEN = 'Zobrazit na celou obrazovku', CLOSE = 'Zavřít celou obrazovku (Esc)';
  const icon = '<svg width="16" height="16" viewBox="0 0 16 16" aria-hidden="true" focusable="false"><path d="M1.5 6V1.5H6M10 1.5h4.5V6M14.5 10v4.5H10M6 14.5H1.5V10" fill="none" stroke="currentColor" stroke-width="1.6"/></svg>';

  function setup(viz) {
    if (viz.dataset.fullscreenReady) return;
    viz.dataset.fullscreenReady = 'true';
    const bar = document.createElement('div');
    bar.className = 'viz-fullscreen-bar';
    const button = document.createElement('button');
    button.type = 'button';
    button.className = 'viz-fullscreen';
    button.setAttribute('aria-pressed', 'false');
    button.innerHTML = `${icon}<span>${OPEN}</span>`;
    button.addEventListener('click', () => {
      if (current() === viz) { exit(); return; }
      // Set the class first: the chart redraw triggered by the resize must already see it.
      viz.classList.add('viz-is-fullscreen');
      const p = request(viz);
      if (p && p.catch) p.catch(() => viz.classList.remove('viz-is-fullscreen'));
    });
    bar.append(button);
    viz.prepend(bar);
  }

  document.addEventListener(document.onfullscreenchange !== undefined ? 'fullscreenchange' : 'webkitfullscreenchange', () => {
    const active = current();
    document.querySelectorAll('.viz[data-fullscreen-ready]').forEach(viz => {
      const on = viz === active;
      viz.classList.toggle('viz-is-fullscreen', on);
      const button = viz.querySelector(':scope > .viz-fullscreen-bar > .viz-fullscreen');
      if (!button) return;
      const was = button.getAttribute('aria-pressed') === 'true';
      button.setAttribute('aria-pressed', String(on));
      button.querySelector('span').textContent = on ? CLOSE : OPEN;
      if (was !== on) button.focus({preventScroll: !on});
      if (was && !on) viz.scrollIntoView({block: 'start'});
    });
  });

  // OJS renders the visualizations after this script runs; watch for them.
  const scan = () => document.querySelectorAll('.viz:not([data-fullscreen-ready])').forEach(setup);
  scan();
  new MutationObserver(scan).observe(document.body, {childList: true, subtree: true});
})();
