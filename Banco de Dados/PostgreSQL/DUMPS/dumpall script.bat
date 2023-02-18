cd "C:\Program Files\PostgreSQL\9.6\bin"
@SET PGPASSWORD=#abc123#
@SET PGUSER=postgres
pg_dumpall.exe --host "source_host" --port "5432" --username "postgres" --verbose | psql --host "destination_host" --port "5432" --username "postgres"
PAUSE