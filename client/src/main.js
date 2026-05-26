import './style.css';
import 'ol/ol.css';
import Map from 'ol/Map';
import View from 'ol/View';
import TileLayer from 'ol/layer/Tile';
import OSM from 'ol/source/OSM';
import VectorLayer from 'ol/layer/Vector';
import VectorSource from 'ol/source/Vector';
import GeoJSON from 'ol/format/GeoJSON';
import { fromLonLat } from 'ol/proj';
import { stylefunction } from 'ol-mapbox-style';

const overtureSource = new VectorSource({
  url: '/overture.geojson',
  format: new GeoJSON({
    dataProjection: 'EPSG:4326',
    featureProjection: 'EPSG:3857',
  }),
});

const overtureLayer = new VectorLayer({
  source: overtureSource,
});

const mapboxStyle = {
  version: 8,
  sources: {
    overture: {
      type: 'geojson',
      data: '/overture.geojson',
    },
  },
  layers: [
    {
      id: 'source-type-fill',
      type: 'fill',
      source: 'overture',
      paint: {
        'fill-color': [
          'match',
          ['get', 'source_type'],
          'my',
          '#2e7d32',
          'osm',
          '#1565c0',
          'ml',
          '#ef6c00',
          '#757575',
        ],
        'fill-opacity': 0.62,
      },
    },
    {
      id: 'source-type-outline',
      type: 'line',
      source: 'overture',
      paint: {
        'line-color': [
          'match',
          ['get', 'source_type'],
          'my',
          '#1b5e20',
          'osm',
          '#0d47a1',
          'ml',
          '#bf360c',
          '#424242',
        ],
        'line-width': 1.5,
      },
    },
  ],
};

stylefunction(overtureLayer, mapboxStyle, 'overture');

const map = new Map({
  target: 'map',
  layers: [
    new TileLayer({
      source: new OSM(),
    }),
    overtureLayer,
  ],
  view: new View({
    center: fromLonLat([50.3064, 53.263]),
    zoom: 16,
  }),
});

overtureSource.once('featuresloadend', () => {
  const extent = overtureSource.getExtent();
  map.getView().fit(extent, {
    padding: [48, 48, 48, 48],
    maxZoom: 18,
    duration: 250,
  });
});

window.map = map;
