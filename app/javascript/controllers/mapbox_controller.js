import { Controller } from "@hotwired/stimulus";
import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';


export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    this._addMarkersToMap();
    this._fitMapToMarkers();

     this.map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }));
  }
  _addMarkersToMap() {
  this.markersValue.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(this.map);
    });
  }
  _fitMapToMarkers() {
  const bounds = new mapboxgl.LngLatBounds();
  this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  this.map.fitBounds(bounds, { padding: 30, maxZoom: 15, duration: 0 });
  }
}
