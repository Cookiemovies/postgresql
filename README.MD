# POSTGRESQL / PGADMIN4 in DOCKER

## Used Images
```
docker pull postgres
docker pull dpage/pgadmin4
```

## Use docker-compose to execute postgreSQL and PGAdmin4

```
docker-compose up -d
```

- Browse to localhost:8080
- Use the email and password from docker-compose.yaml
- Create a database, browse etc

## Restore a database (pg_restore)

Use this command from your machine or from inside Docker

```
"C:\Program Files\PostgreSQL\13\bin\pg_restore" -U postgres -d dvdrental dvdrental.tar
or
pg_restore" -U postgres -d dvdrental dvdrental.tar
```

## Execute commands with PSQL

Use this command from your machine or execute runpsql.bat

```
"C:\Program Files\PostgreSQL\13\bin\psql.exe" -h %server% -U %username% -d %database% -p %port%
or
psql.exe -h localhost -U admin -d dvdreantal -p 5432
```

## Backup the database 

First stop the containers and then run the backup

```
docker-compose stop
docker-compose rm
docker run --rm --volumes-from wordpress_db_1 -v C:\Users\marti\Projects\wordpress:/backup alpine sh -c "cd /var/lib/mysql && tar cvf /backup/wordpress_db.tar ."
docker run --rm --volumes-from wordpress_wordpress_1 -v C:\Users\marti\Projects\wordpress:/backup alpine sh -c "cd /var/www/html && tar cvf /backup/wordpress_wp.tar ."
```

## Restore the backup

```
docker run --rm -v wordpress_wordpress:/recover -v C:\Users\marti\Projects\wordpress:/backup alpine sh -c "cd /recover && tar xvf /backup/wordpress_db.tar"
docker run --rm -v wordpress_db:/recover -v C:\Users\marti\Projects\wordpress:/backup alpine sh -c "cd /recover && tar xvf /backup/wordpress_wp.tar"
```

## Check the volumes

```
docker run --rm -v wordpress_db:/var/lib/mysql alpine sh -c "cd /var/lib/mysql && ls"
docker run --rm -v wordpress_wordpress:/var/www/html alpine sh -c "cd /var/www/html && ls"
```
