# Лабораторная работа N2

Проект разворачивает PostGIS, GeoServer и веб-клиент OpenLayers для публикации слоя `samara_places`.

## Запуск

```bash
docker compose up -d
chmod +x publish-geoserver.sh
./publish-geoserver.sh
```

После публикации откройте:

- веб-приложение: <http://localhost:8090>
- GeoServer: <http://localhost:8080/geoserver>

Учетные данные GeoServer:

- логин: `admin`
- пароль: `geoserver`

## Что создано

- `docker-compose.yml` - сервисы PostGIS, GeoServer и nginx для веб-клиента.
- `init-db/01-init.sql` - включение PostGIS, таблица `samara_places`, тестовые точки Самары и spatial index.
- `publish-geoserver.sh` - создание workspace `lab2`, PostGIS store `postgis` и публикация слоя `samara_places`.
- `web/` - клиент OpenLayers с WMS-слоем и запросом атрибутов по клику.

## Проверка в GeoServer

1. Откройте `http://localhost:8080/geoserver`.
2. Войдите как `admin` / `geoserver`.
3. Проверьте `Data -> Workspaces -> lab2`.
4. Проверьте `Data -> Stores -> postgis`.
5. Проверьте `Data -> Layers -> lab2:samara_places`.
