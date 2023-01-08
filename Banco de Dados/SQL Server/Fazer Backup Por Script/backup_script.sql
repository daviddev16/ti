

DECLARE @backupDirectory  varchar(512) = '/home/david/sqlserver_backups';
DECLARE @dateTime         varchar(256) = CONVERT(VARCHAR(20),GETDATE(),112) + '_' + REPLACE(CONVERT(VARCHAR(20),GETDATE(),108),':','');
DECLARE @backupFilePath	  varchar(1024);
DECLARE @databaseName     varchar(64);

print('Iniciando backup dos banco de dados...')

DECLARE databases_cursor CURSOR READ_ONLY FOR
	(SELECT name FROM master.sys.databases
		WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb') -- banco de dados que você não quer fazer backup
			AND state = 0
			AND is_in_standby = 0);

OPEN databases_cursor
	FETCH NEXT FROM databases_cursor INTO @databaseName
WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @backupFilePath = @backupDirectory + '/' + @databaseName + '_' + @dateTime + '.BAK';
		print('Iniciando backup para banco de dados "' + @databaseName + '".')
		BACKUP DATABASE @databaseName TO DISK = @backupFilePath
		FETCH NEXT FROM databases_cursor INTO @databaseName
END

print('Backups concluídos!')

-- fechar cursor
CLOSE databases_cursor
DEALLOCATE databases_cursor