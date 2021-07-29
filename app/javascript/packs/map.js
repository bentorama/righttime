import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

var allMarkers = [];
var currentMarkers = [];
var filter = 'All';
var currentElements = [];

const buildMap = (mapElement, center) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  if (center == null) {
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11'
    });
  } else {
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: center
    });
  }
};

const addMarkersToMap = (map, markers) => {
  currentMarkers = [];
  currentElements = [];
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.info_window);
    // Create a HTML element for your custom marker
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '25px';
    element.style.height = '25px';
    element.id = `id-${marker.id}`;
    currentElements.push(element);
    element.onclick = () => {
      const container = document.querySelector("#scrolling-container");
      const card = container.querySelector(`#${element.id}`);
      card.scrollIntoView({
        behavior: "smooth",
        inline: "center"
      });
    };

    // Pass the element as an argument to the new marker
    var oneMarker = new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .addTo(map);
    currentMarkers.push(oneMarker);
  });
  toggleCards();
};

const toggleCards = () => {
  const container = document.querySelector("#scrolling-container");
  var cards = container.querySelectorAll(".event-card");
  cards.forEach((card) => {
    card.style.display = 'none';
  });
  currentElements.forEach((element) => {
    cards.forEach((card) => {
      if (element.id === card.id) {
        card.style.display = 'flex';
      };
    });
  });
};

const removeMarkers = (map, markers, button) => {
  if (button !== filter) {
    currentMarkers.forEach((marker) => {
      marker.remove();
    });
    var filterMarkers = [];
    markers.forEach((marker) => {
      if (marker.category === button) {
        filterMarkers.push(marker);
      };
    });
    addMarkersToMap(map, filterMarkers);
    filter = button;
  } else {
    currentMarkers.forEach((marker) => {
      marker.remove();
    });
    addMarkersToMap(map, markers);
    filter = "All";
  }
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 1000 });
};



const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const hot = document.getElementById("hot")
  const food = document.getElementById("food")
  const drink = document.getElementById("drink")
  const music = document.getElementById("music")
  const show = document.getElementById("show")
  const buttons = [hot, food, drink, music, show];

  const toggleButtons = (event) => {
    if (event.currentTarget.classList.contains("filter-button-active")) {
      event.currentTarget.classList.remove("filter-button-active");
    } else {   
      buttons.forEach((button) => {
        // console.log(button);
        button.classList.remove("filter-button-active");
      });
      event.currentTarget.classList.add("filter-button-active");
    };
  };

  if (mapElement) {
    const center = JSON.parse(mapElement.dataset.center);
    const map = buildMap(mapElement, center);
    const markers = JSON.parse(mapElement.dataset.markers);
    filter = 'All';
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
    map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        trackUserLocation: true
      })
    );
    hot.addEventListener("click", (event) => {
      toggleButtons(event);
      var button = "Hot";
      removeMarkers(map, markers, button);
    });
    food.addEventListener("click", (event) => {
      toggleButtons(event);
      var button = "Food";
      removeMarkers(map, markers, button);
    });
    drink.addEventListener("click", (event) => {
      toggleButtons(event);
      var button = "Drink";
      removeMarkers(map, markers, button);
    });
    music.addEventListener("click", (event) => {
      toggleButtons(event);
      var button = "Music";
      removeMarkers(map, markers, button);
    });
    show.addEventListener("click", (event) => {
      toggleButtons(event);
      var button = "Show";
      removeMarkers(map, markers, button);
    });
  }
  
};
// initMapbox();
export { initMapbox };
// export { removeMarkers };