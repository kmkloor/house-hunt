checkFilter()

function toggleFilters() {
  $('#filters').toggleClass('hide')
  $('#filters').classList
  setCookie('filters', !$('#filters')[0].classList.value.includes("hide"))
}

function checkFilter(){
  if(getCookie('filters') && getCookie('filters') == 'true'){
  $('#filters').removeClass('hide');
  }
  setTimeout(function(){ checkFilter() }, 300);
}

function cookieDate(){
  var now = new Date();
  now.setHours(now.getHours() + 24)
  return new Date(now);
}

function setCookie(property, value){
  document.cookie = property+"="+value+"; expires="+cookieDate()+";path=/";
}

function getCookie(property){
  var name = property + "=";
  var decodedCookie = decodeURIComponent(document.cookie);
  var ca = decodedCookie.split(';');
  for(var i = 0; i <ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}