Filesystem Foreign Data Wrapper
===============================

filesystem.file schema
----------------------

```
| id                        | directory_id    | permissions | links | size | owner | group | last mod   | name      | content |
-------------------------------------------------------------------------------------------------------------------------------
| /var/www/public/index.php | /var/www/public | drwxr-xr-x  | 1     | 3    | mic   | staff | Dec 1 2015 | index.php | ...     |
```

- ls
```
select * from filesystem.file where path = ‘/var/www/public’;
```

- touch
```
insert into filesystem.file (path, name) values (‘/var/www/public’, ‘index.php’);
```

- chmod
```
update filesystem.file set permissions = ‘755’ where id=’/var/www/public/index.php’;
```

- chown/chgrp
```
update filesystem.file 
set owner=‘www-data’, group=’www-data’ 
where id=’/var/www/public/index.php’;
```

- less
```
select content from filesystem.file where path = ‘/var/www/public/index.php’;
```

filesystem.dir schema
---------------------

```
| id              | parent_id | permissions | links | size | owner | group | last mod   | name   |
--------------------------------------------------------------------------------------------------
| /var/www/public | /var/www  | drwxr-xr-x  | 1     | 3    | mic   | staff | Dec 1 2015 | public |
```

- ls
```
select * from filesystem.directory where path = ‘/var/www’;
```

- mkdir
```
insert into filesystem.directory (path, name) values (‘/var/www’, ‘public’);
```

- chmod
```
update filesystem.directory set permissions = ‘755’ where id=’/var/www/public’;
```

- chown/chgrp
```
update filesystem.directory 
set owner=‘www-data’, group=’www-data’ 
where id=’/var/www/public’;
```

general
-------

- ls -al
```
select permissions, links, owner, group, size, last_mod, name
from filesystem.directory 
where parent_id=’/var/www/public’
    union
select permissions, links, owner, group, size, last_mod, name
from filesystem.file 
where directory_id=’/var/www/public’;
```
