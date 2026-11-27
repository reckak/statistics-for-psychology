// Lightbox captions with rendered mathematics.
// Quarto passes the figure caption to GLightbox only through the link's plain-text
// `title` attribute, so inline math appears there as TeX source (e.g. \mathrm{τ}_b).
// This script (1) replaces the caption shown in the lightbox with the figure's own
// rendered <figcaption> (MathML) and (2) turns the hover tooltip into readable text.
(function () {
  'use strict';

  function figcaptionOf(link) {
    var figure = link && link.closest('figure');
    return figure ? figure.querySelector('figcaption') : null;
  }

  // Readable text of a caption: MathML without its TeX annotation.
  function plainText(caption) {
    var clone = caption.cloneNode(true);
    clone.querySelectorAll('annotation, annotation-xml').forEach(function (el) { el.remove(); });
    return clone.textContent.replace(/\s+/g, ' ').trim();
  }

  function fixTooltips() {
    document.querySelectorAll('a.lightbox[title]').forEach(function (link) {
      var caption = figcaptionOf(link);
      if (caption && caption.querySelector('math')) link.setAttribute('title', plainText(caption));
    });
  }

  function hookLightbox() {
    var lightbox = window.lightboxQuarto;
    if (!lightbox || typeof lightbox.on !== 'function') return;
    lightbox.on('slide_after_load', function (data) {
      var caption = figcaptionOf(data && data.trigger);
      var title = data && data.slideNode && data.slideNode.querySelector('.gslide-title');
      if (caption && title && caption.querySelector('math')) title.innerHTML = caption.innerHTML.trim();
    });
  }

  fixTooltips();
  hookLightbox();
})();
