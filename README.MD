# POSTGRESQL / PGADMIN4 in DOCKER WITH BACKUP/RESTORE

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
docker run --rm --volumes-from postgresql_db_1 -v C:\Users\marti\Projects\postgresql:/backup alpine sh -c "cd /var/lib/postgresql/data && tar cvf /backup/postgresql_db_data.tar ."
docker run --rm --volumes-from postgresql_pgadmin_1 -v C:\Users\marti\Projects\postgresql:/backup alpine sh -c "cd /var/lib/pgadmin && tar cvf /backup/postgresql_pgadmin-data.tar ."
```

When you want to delete everything then  

```
docker-compose rm
docker volume rm postgresql_db-data
docker volume rm postgresql_pgadmin-data
```

## Restore the backup

```
docker run --rm -v postgresql_db-data:/recover -v C:\Users\marti\Projects\postgresql:/backup alpine sh -c "cd /recover && tar xvf /backup/postgresql_db_data.tar"
docker run --rm -v postgresql_pgadmin-data:/recover -v C:\Users\marti\Projects\postgresql:/backup alpine sh -c "cd /recover && tar xvf /backup/postgresql_pgadmin-data.tar"
```

## Check the volumes

```
docker run --rm -v postgresql_db-data:/var/lib/postgresql/data alpine sh -c "cd /var/lib/postgresql/data && ls"
docker run --rm -v postgresql_pgadmin-data:/var/lib/pgadmin alpine sh -c "cd /var/lib/pgadmin && ls"
```
