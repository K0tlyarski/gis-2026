import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "lab1.geojson"
TARGET = ROOT / "lab3" / "lab1_prepared.geojson"


def close_ring(ring):
    if ring and ring[0] != ring[-1]:
        return ring + [ring[0]]
    return ring


def fix_geometry(geometry):
    if not geometry:
        return geometry

    geometry_type = geometry.get("type")
    coordinates = geometry.get("coordinates")

    if geometry_type == "Polygon":
        geometry["coordinates"] = [close_ring(ring) for ring in coordinates]
    elif geometry_type == "MultiPolygon":
        geometry["coordinates"] = [
            [close_ring(ring) for ring in polygon]
            for polygon in coordinates
        ]
    elif geometry_type == "GeometryCollection":
        geometry["geometries"] = [
            fix_geometry(item)
            for item in geometry.get("geometries", [])
        ]

    return geometry


def main():
    data = json.loads(SOURCE.read_text(encoding="utf-8"))

    for feature in data.get("features", []):
        feature["geometry"] = fix_geometry(feature.get("geometry"))

    TARGET.write_text(
        json.dumps(data, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    print(f"Prepared GeoJSON: {TARGET}")


if __name__ == "__main__":
    main()
