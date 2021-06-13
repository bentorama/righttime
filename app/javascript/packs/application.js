// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import 'jquery-bar-rating/dist/themes/css-stars';
// import{ initializeClock } from '../components/countdown';

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

import { initMapbox } from '../plugins/init_mapbox';
import { initStarRating } from '../plugins/init_star_rating';
// import { heartChanger } from 'favourites-heart.js';


document.addEventListener('turbolinks:load', () => {
  // initializeClock('clockdiv', 'December 31 2021 23:59:59 GMT+0200')
  initMapbox();
  initStarRating();
  // heartChanger();
  
  const currentLocation = document.getElementById("current-location");
  const hiddenSearch = document.getElementById("hidden");
  const search = document.getElementById("search");

  // current location pin 
  if (currentLocation) {
    currentLocation.addEventListener("click", (event) => {
      event.preventDefault();
      navigator.geolocation.getCurrentPosition((data) => {
      hiddenSearch.value = [data.coords.latitude, data.coords.longitude];
      document.getElementById("search-form").submit();
      });
    });
  };

  // heart toggle 
  const indexHeart = document.querySelectorAll("#index-heart"); // hearts array
  indexHeart.forEach(toggleFavourite);

  function toggleFavourite(heart) {
    heart.addEventListener("click", (event) => {
      console.log(indexHeart);
      event.preventDefault();
      // indexHeart.classList.remove("far.fa-heart");
      console.log(indexHeart.classList);
    });
  };

  // for (var i = 0; i < indexHeart.length; i++) {
  //   indexHeart[i].addEventListener("click", (event) => {
  //     console.log(indexHeart);
  //     event.preventDefault();
  //     // indexHeart.classList.remove("far.fa-heart");
  //     indexHeart.style.display = "none";
  //   });
  // };
});
