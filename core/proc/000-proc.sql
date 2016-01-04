create schema proc;
set search_path=proc;

create or replace function proc.exec(path text, cmd_args text[] default '{}') returns integer as $$
from subprocess import call
return call([path] + cmd_args)
$$ language plpythonu;

