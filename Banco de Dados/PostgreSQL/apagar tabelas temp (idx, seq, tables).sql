DO
$$
DECLARE
	rec_pg_class RECORD;
	rec_pg_type RECORD;
	prever boolean = true; -- VISUALIZAR TABELAS A SEREM DELETADAS (CASO FOR APAGAR AS TABELAS, COLOCAR 'false')
BEGIN
	RAISE notice '!!Limpando tabelas temp do sistema!!';
	FOR rec_pg_class IN 
	SELECT ('DELETE FROM pg_class WHERE relname=' || quote_literal(PC.relname)) as query, relname FROM
		pg_class AS PC,
		pg_namespace AS PN
	WHERE
		(PN.oid = PC.relnamespace AND PN.nspname = 'temp')
	AND 
		(PC.relkind = 'r' OR PC.relkind = 'i' OR PC.relkind='S')
	AND PC.relname NOT LIKE 'pg_%'
	AND PC.relname NOT LIKE 'sql_%'
	LOOP
		IF NOT prever THEN
			RAISE notice 'Apagando "%" da pg_class...', rec_pg_class.relname;
			EXECUTE rec_pg_class.query;
		ELSE
			RAISE notice '[Seguro] Para apagar \"%\".', rec_pg_class.relname;
		END IF;
	END LOOP;
	FOR rec_pg_type IN 
	SELECT ('DELETE FROM pg_type WHERE typname=' || quote_literal(PT.typname)) as query, typname FROM
	pg_type AS PT,
	pg_namespace AS PN
	WHERE
	(PN.oid = PT.typnamespace AND PN.nspname = 'temp')
	AND PT.typname NOT LIKE 'pg_%' 
	AND PT.typname NOT LIKE 'sql_%'
	AND PT.typname LIKE '%_seq'

	LOOP
		IF NOT prever THEN
			RAISE notice 'Apagando "%" da pg_type...', rec_pg_type.typname;
			EXECUTE rec_pg_type.query;
		ELSE
			RAISE notice '[Seguro] Para apagar \"%\".', rec_pg_type.typname;
		END IF;
	END LOOP;
END;
$$