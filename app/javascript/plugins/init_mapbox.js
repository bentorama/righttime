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
      center: center,
      zoom: 15
    });
  }
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  console.log(mapElement.dataset.center)
  if (mapElement) {
    const center = JSON.parse(mapElement.dataset.center);
    console.log(center);
    const map = buildMap(mapElement, center);
    const markers = JSON.parse(mapElement.dataset.markers);
    console.log(markers);
    addMarkersToMap(map, markers);
    if (center == null) {
      fitMapToMarkers(map, markers);
    }
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

export { initMapbox };