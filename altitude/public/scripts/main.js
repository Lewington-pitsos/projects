document.addEventListener('DOMContentLoaded', function() {
  var route = window.location.href.split('/')
  var currentPageNavigators = document.querySelectorAll(`a[href="/${route[route.length - 1]}"]`)
  setToActive(currentPageNavigators);
})

function setToActive(navs) {
  var currents = document.querySelectorAll('.active');
  currents.forEach(function(current) {
    current.classList.remove('active');
  })
  navs.forEach(function(nav) {
    nav.classList.add('active');
  })
}

function expand() {

}
