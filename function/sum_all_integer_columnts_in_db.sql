CREATE OR REPLACE FUNCTION pg_catalog.summaOfIntegerTypeColumns()
RETURNS BIGINT AS $$

DECLARE
	table_name text;
	column_name text;
	val BIGINT := 0;
	total BIGINT := 0;

BEGIN
	FOR
		table_name,
		column_name
	IN SELECT T.tablename, C.column_name
	FROM pg_catalog.pg_tables T
		join information_schema.columns C
			on C.table_name = T.tablename and C.data_type='integer'
		WHERE
			schemaname != 'pg_catalog'
		AND 
			schemaname != 'information_schema'
		LOOP
			val := 0;
			EXECUTE 'SELECT sum(' || column_name || ') FROM ' || table_name into val;

			IF val IS NOT NULL then
			  total := val + total;
			end if;

		END LOOP;

	RETURN total;
END;

$$  LANGUAGE plpgsql;


SELECT pg_catalog.summaOfIntegerTypeColumns() AS total;