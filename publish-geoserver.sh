#!/usr/bin/env bash
set -euo pipefail

GEOSERVER_URL="${GEOSERVER_URL:-http://localhost:8080/geoserver}"
GEOSERVER_USER="${GEOSERVER_USER:-admin}"
GEOSERVER_PASSWORD="${GEOSERVER_PASSWORD:-geoserver}"
WORKSPACE="${WORKSPACE:-lab2}"
STORE="${STORE:-postgis}"
LAYER="${LAYER:-samara_places}"

auth=(-u "${GEOSERVER_USER}:${GEOSERVER_PASSWORD}")

echo "Waiting for GeoServer at ${GEOSERVER_URL}..."
until curl -fsS "${auth[@]}" "${GEOSERVER_URL}/rest/about/version.json" >/dev/null; do
  sleep 5
done

echo "Creating workspace ${WORKSPACE}..."
if curl -fsS "${auth[@]}" \
  "${GEOSERVER_URL}/rest/workspaces/${WORKSPACE}.json" >/dev/null 2>&1; then
  echo "Workspace ${WORKSPACE} already exists."
else
  curl -fsS "${auth[@]}" -XPOST \
    -H "Content-Type: application/json" \
    -d "{\"workspace\":{\"name\":\"${WORKSPACE}\"}}" \
    "${GEOSERVER_URL}/rest/workspaces" >/dev/null
fi

echo "Creating PostGIS store ${STORE}..."
store_payload="{
    \"dataStore\": {
      \"name\": \"${STORE}\",
      \"connectionParameters\": {
        \"entry\": [
          {\"@key\":\"host\", \"$\":\"postgis\"},
          {\"@key\":\"port\", \"$\":\"5432\"},
          {\"@key\":\"database\", \"$\":\"gis\"},
          {\"@key\":\"schema\", \"$\":\"public\"},
          {\"@key\":\"user\", \"$\":\"gisuser\"},
          {\"@key\":\"passwd\", \"$\":\"gispass\"},
          {\"@key\":\"dbtype\", \"$\":\"postgis\"}
        ]
      }
    }
  }"

if curl -fsS "${auth[@]}" \
  "${GEOSERVER_URL}/rest/workspaces/${WORKSPACE}/datastores/${STORE}.json" >/dev/null 2>&1; then
  curl -fsS "${auth[@]}" -XPUT \
    -H "Content-Type: application/json" \
    -d "${store_payload}" \
    "${GEOSERVER_URL}/rest/workspaces/${WORKSPACE}/datastores/${STORE}" >/dev/null
else
  curl -fsS "${auth[@]}" -XPOST \
    -H "Content-Type: application/json" \
    -d "${store_payload}" \
    "${GEOSERVER_URL}/rest/workspaces/${WORKSPACE}/datastores" >/dev/null
fi

echo "Publishing layer ${LAYER}..."
if curl -fsS "${auth[@]}" \
  "${GEOSERVER_URL}/rest/workspaces/${WORKSPACE}/datastores/${STORE}/featuretypes/${LAYER}.json" >/dev/null 2>&1; then
  echo "Layer ${LAYER} already exists."
else
  curl -fsS "${auth[@]}" -XPOST \
    -H "Content-Type: application/json" \
    -d "{
      \"featureType\": {
        \"name\": \"${LAYER}\",
        \"nativeName\": \"${LAYER}\",
        \"title\": \"Samara places\",
        \"srs\": \"EPSG:4326\"
      }
    }" \
    "${GEOSERVER_URL}/rest/workspaces/${WORKSPACE}/datastores/${STORE}/featuretypes" >/dev/null
fi

echo "Reloading GeoServer catalog..."
curl -fsS "${auth[@]}" -XPOST "${GEOSERVER_URL}/rest/reload" >/dev/null

echo "Done."
echo "GeoServer: ${GEOSERVER_URL}"
echo "Web app: http://localhost:8090"
