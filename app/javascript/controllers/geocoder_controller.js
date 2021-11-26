import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static values = { apiKey: String, markers: Array}

  static targets = ["address"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    });

     this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    this.geocoder.addTo(this.element);
    this.geocoder.on("result", event => this._setInputValue(event));
    this.geocoder.on("clear", () => this._clearInputValue());
    this._addMarkersToMap();
    this._addMarkersToMap();
    this._fitMapToMarkers();
  }

  _fitMapToMarkers() {
  const bounds = new mapboxgl.LngLatBounds();
  this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  this.map.fitBounds(bounds, { padding: 20, maxZoom: 15, duration: 0 });
  }

  _setInputValue(event) {
    this.addressTarget.value = event.result["place_name"];
  }

  _clearInputValue() {
    this.addressTarget.value = "";
  }

  _addMarkersToMap() {
  this.markersValue.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(this.map);
  });
}
