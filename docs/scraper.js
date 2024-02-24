javascript: (function () {
  var a = document.title;
  var header = document.querySelector("header");
  header.remove();
  var footer = document.querySelector("footer");
  footer.remove();
  return a;
})();
