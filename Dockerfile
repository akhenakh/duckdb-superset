FROM apache/superset:4.1.1

USER root

RUN pip install duckdb==1.1.3
RUN pip install duckdb-engine==0.15.0

USER superset
