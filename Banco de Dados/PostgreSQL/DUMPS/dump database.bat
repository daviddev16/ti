cd "C:\Program Files\PostgreSQL\9.6\bin"
@SET PGPASSWORD=#abc123#
@SET PGUSER=postgres
pg_dump.exe --host "source_host" --port "5432" --verbose --username "postgres" "DATABASE_NAME" | psql --host "destination_host" --port "5432" --username "postgres" "DATABASE_NAME"
PAUSE