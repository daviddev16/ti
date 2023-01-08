
@echo on
SET caminho_atual=%~dp0
SET backup_sql=%caminho_atual%backup_script.sql
cd "C:\Program Files (x86)\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn"
@echo Iniciando processo de backup
sqlcmd -S sqlserver.center.internal -U sa -P '<senha>' -i "%backup_sql%"
@echo Backup finalizado.
PAUSE