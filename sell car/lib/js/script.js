let slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("slide");
  if (n > slides.length) {
    slideIndex = 1
  }
  if (n < 1) {
    slideIndex = slides.length
  }
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  slides[slideIndex - 1].style.display = "block";
  slideIndex++;
  setTimeout(showSlides, 5000); // Change image every 5 seconds
}





jQuery(document).ready(function(){  
  jQuery('.closepopup').on('click', function () {
    jQuery('#popup-container').fadeOut();
    jQuery('#modalOverly').fadeOut();
  });

  var visits = jQuery.cookie('visits') || 0;
  visits++;
  jQuery.cookie('visits', visits, { expires: 1, path: '/' });
  console.debug(jQuery.cookie('visits')); 
  if ( jQuery.cookie('visits') > 1 ) {
    jQuery('#modalOverly').hide();
    jQuery('#popup-container').hide();
  } else {
    var pageHeight = jQuery(document).height();
    jQuery('<div id="modalOverly"></div>').insertBefore('body');
    jQuery('#modalOverly').css("height", pageHeight);
    jQuery('#popup-container').show();
  }
  if (jQuery.cookie('noShowWelcome')) { jQuery('#popup-container').hide(); jQuery('#active-popup').hide(); }
}); 

jQuery(document).mouseup(function(e){
  var container = jQuery('#popup-container');
  if( !container.is(e.target)&& container.has(e.target).length === 0)
  {
    container.fadeOut();
    jQuery('#modalOverly').fadeIn(200);
    jQuery('#modalOverly').hide();
  }
});


function ajouterAuPanier(idVoiture) {
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
      if (xhr.readyState === 4 && xhr.status === 200) {
          alert(xhr.responseText);
      }
  };
  xhr.open("POST", "ajouter_au_panier.php", true);
  xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhr.send("idVoiture=" + idVoiture);
}
