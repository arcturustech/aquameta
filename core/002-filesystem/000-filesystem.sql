begin;
create schema filesystem;

set search_path=filesystem;


-- http://dba.stackexchange.com/questions/1742/how-to-insert-file-data-into-a-postgresql-bytea-column
create or replace function bytea_import(p_path text, p_result out bytea) 
language plpgsql as $$
declare
  l_oid oid;
  r record;
begin
  p_result := '';
  select lo_import(p_path) into l_oid;
  for r in ( select data 
             from pg_largeobject 
             where loid = l_oid 
             order by pageno ) loop
    p_result = p_result || r.data;
  end loop;
  perform lo_unlink(l_oid);
end;$$;


--
--create extension fs_fdw;
--
--create server fs_srv foreign data wrapper fs_fdw options (debug 'true');
--
--create foreign table filesystem.'file' (
--	id text,
--	directory_id text,
--	permissions text,
--	links integer,
--	size integer,
--	owner text,
--	group text,
--	last_modification text,
--	name text,
--	content bytea
--) server fs_srv options (table_name 'file')
--
--create foreign table filesystem.'directory' (
--	id text,
--	parent_id text,
--	permissions text,
--	links integer,
--	size integer,
--	owner text,
--	group text,
--	last_modification text,
--	name text
--) server fs_srv options (table_name 'directory')
--

commit;
