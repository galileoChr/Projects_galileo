//carousel.js

function carousel() {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var labels = document.getElementsByClassName("myLabels");
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
    labels[i].style.display = "none";
  }
  index++;
  if (index > slides.length) { index = 1 }
  slides[index - 1].style.display = "block";
  labels[index - 1].style.display = "block";
  setTimeout(carousel, 3000);
}
var index = 0;
