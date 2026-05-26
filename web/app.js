const workspace = 'lab2';
const layerName = 'samara_places';
const wmsUrl = `/geoserver/${workspace}/wms`;
const fullLayerName = `${workspace}:${layerName}`;

const statusEl = document.getElementById('status');
const popupEl = document.getElementById('popup');

const osm = new ol.layer.Tile({
  source: new ol.source.OSM()
});

const places = new ol.layer.Image({
  source: new ol.source.ImageWMS({
    url: wmsUrl,
    params: {
      LAYERS: fullLayerName,
      TILED: true
    },
    ratio: 1,
    serverType: 'geoserver'
  })
});

places.getSource().on('imageloadend', () => {
  statusEl.textContent = 'Слой загружен';
});

places.getSource().on('imageloaderror', () => {
  statusEl.textContent = 'Слой недоступен';
});

const map = new ol.Map({
  target: 'map',
  layers: [osm, places],
  view: new ol.View({
    center: ol.proj.fromLonLat([50.14, 53.21]),
    zoom: 12
  })
});

map.on('singleclick', async (event) => {
  const view = map.getView();
  const url = places.getSource().getFeatureInfoUrl(
    event.coordinate,
    view.getResolution(),
    view.getProjection(),
    {
      INFO_FORMAT: 'application/json',
      FEATURE_COUNT: 5
    }
  );

  if (!url) {
    return;
  }

  try {
    const response = await fetch(url);
    const data = await response.json();
    const feature = data.features && data.features[0];

    if (!feature) {
      popupEl.style.display = 'none';
      return;
    }

    const props = feature.properties;
    popupEl.innerHTML = `
      <strong>${escapeHtml(props.name || 'Объект')}</strong>
      <span>${escapeHtml(props.category || '')}</span>
      <p>${escapeHtml(props.description || '')}</p>
    `;
    popupEl.style.display = 'block';
  } catch (error) {
    popupEl.innerHTML = '<strong>Не удалось получить атрибуты</strong>';
    popupEl.style.display = 'block';
  }
});

function escapeHtml(value) {
  return String(value)
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');
}
