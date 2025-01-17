# DuckDB supports in SuperSet

## Run Superset
```sh
mkdir data
podman run --rm  -p 8088:8088 \
  -e "SUPERSET_SECRET_KEY=XXXXX" \
  --mount type=bind,source=/$(pwd)/data,target=/data \
  --name superset-duckdb \
  ghcr.io/akhenakh/duckdb-superset:latest

# Upgrade database to latest.
docker exec -it superset-duckdb superset db upgrade

# Setup roles.
docker exec -it superset-duckdb superset init
```

## Configure Superset for DuckDB

- Go to http://localhost:8088 → Settings → Database Connections.
- Click on Create a new database connection.
- In the dropdown menu, select DuckDB.
- Then click on  "Connect this database with SQLAlchemy URI string instead".
- Set the SQLALCHEMY URI to `duckdb:///:memory:` or use a real file path like `duckdb:///superset_home/mydb`.
- In the **Advanced** tab set **Engine Parameters** to `{"connect_args":{"config":{"threads":16}}}`

## Spatial Queries
    
If you want to do spatial queries, first go the SQL Lab and run the following statement: `INSTALL spatial;`

Go back to your existing DuckDB database connections, and edit it, in advanced tab set `{"connect_args":{"preload_extensions":["spatial"]}}` in  Engine Parameters.


## Build the image
```sh
podman build --no-cache -t ghcr.io/akhenakh/duckdb-superset:latest . 
```
