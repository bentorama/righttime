import { get } from 'jquery';
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker[0], marker[1] ]));
  map.fitBounds(bounds, { padding: 30, maxZoom: 15, duration: 0 });
};

const initDirections = () => {
  const mapElement = document.getElementById('map');
  const destination = JSON.parse(mapElement.dataset.destination);
  // console.log(destination);
  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    // getting the current location and build a map
    navigator.geolocation.getCurrentPosition((data) => {
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/bentorama/ckph9m798007s17qistei9iwy'
        // center: [data.coords.longitude, data.coords.latitude],
        // zoom: 13
      });
      // var canvas = map.getCanvasContainer();
      const start = [data.coords.longitude, data.coords.latitude];
      // console.log(start);
      const end = [destination.lng, destination.lat];
      const markers = [start, end];
      fitMapToMarkers(map, markers);
      // console.log(end);
      function getRoute(end) {
        // make a directions request using walking profile start point is current location
        var start = [data.coords.longitude, data.coords.latitude]
        var url = 'https://api.mapbox.com/directions/v5/mapbox/walking/' + start[0] + ',' + start[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
      
        // make an XHR request https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.onload = function() {
          var json = JSON.parse(req.response);
          var data = json.routes[0];
          var route = data.geometry.coordinates;
          var geojson = {
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'LineString',
              coordinates: route
            }
          };
          // if the route already exists on the map, reset it using setData
          if (map.getSource('route')) {
            map.getSource('route').setData(geojson);
          } else { // otherwise, make a new request
            map.addLayer({
              id: 'route',
              type: 'line',
              source: {
                type: 'geojson',
                data: {
                  type: 'Feature',
                  properties: {},
                  geometry: {
                    type: 'LineString',
                    coordinates: geojson
                  }
                }
              },
              layout: {
                'line-join': 'round',
                'line-cap': 'round'
              },
              paint: {
                'line-color': '#3887be',
                'line-width': 5,
                'line-opacity': 0.75
              }
            });
          }
          // add turn instructions here at the end
          var instructions = document.getElementById('instructions');
          var steps = data.legs[0].steps;
      
          var tripInstructions = [];
          for (var i = 0; i < steps.length; i++) {
            tripInstructions.push('<br><li>' + steps[i].maneuver.instruction) + '</li>';
            instructions.innerHTML = '<br><span class="duration">Trip duration: ' + Math.floor(data.duration / 60) + ' min 👟 </span>' + tripInstructions;
          }
        };
        req.send();
      }
      map.on('load', function() {
        getRoute(start);
        // Add starting point to the map
        map.addLayer({
          id: 'point',
          type: 'circle',
          source: {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [{
                type: 'Feature',
                properties: {},
                geometry: {
                  type: 'Point',
                  coordinates: start
                }
              }
              ]
            }
          },
          paint: {
            'circle-radius': 10,
            'circle-color': '#800080'
          }
        });
        // Add end point to the map
        map.addLayer({
          id: 'end',
          type: 'circle',
          source: {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [{
                type: 'Feature',
                properties: {},
                geometry: {
                  type: 'Point',
                  coordinates: end
                }
              }
              ]
            }
          },
          paint: {
            'circle-radius': 10,
            'circle-color': '#800080'
          }
        });
        getRoute(end);
        map.moveLayer('end')
      });
    });
  }
};
initDirections();