# DuckDB supports in SuperSet
```sh
podman build --no-cache -t superset-duckdb:4.1.1 . 
```

```sh
mkdir data
podman run --rm  -p 8088:8088 \
  -e "SUPERSET_SECRET_KEY=XXXXX" \
  --mount type=bind,source=/$(pwd)/data,target=/data \
  --name superset-duckdb \
  superset-duckdb:4.1.1

# Upgrade database to latest.
docker exec -it superset-duckdb superset db upgrade

# Setup roles.
docker exec -it superset-duckdb superset init
```
## Spatial Queries
    
If you want to do spatial queries, first go the SQL Lab and run the following statement: `INSTALL spatial;`

Go back to your existing DuckDB database connections, and edit it, in advanced tab set `{"connect_args":{"preload_extensions":["spatial"]}}` in  Engine Parameters.
