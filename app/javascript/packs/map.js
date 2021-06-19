import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const buildMap = (mapElement, center) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  if (center == null) {
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/bentorama/ckph9m798007s17qistei9iwy'
    });
  } else {
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/bentorama/ckph9m798007s17qistei9iwy',
      center: center
    });
  }
};

const addMarkersToMap = (map, markers) => {
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
    element.onclick = () => {
      const container = document.querySelector("#scrolling-container");
      const card = container.querySelector(`#${element.id}`);
      card.scrollIntoView({
        behavior: "smooth",
        inline: "center"
      });
    };


    // Pass the element as an argument to the new marker
    new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      // .setPopup(popup)
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 1000 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  // console.log(mapElement.dataset.center)
  if (mapElement) {
    const center = JSON.parse(mapElement.dataset.center);
    const map = buildMap(mapElement, center);
    const markers = JSON.parse(mapElement.dataset.markers);
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
  }
};
// initMapbox();
export { initMapbox };
