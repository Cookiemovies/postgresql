# POSTGRESQL / PGADMIN4 in DOCKER WITH BACKUP/RESTORE

I´ve created a composition of POSTGRESQL and PGADMIN4 to handle POSTGRES databases in container.
I´ve also added several examples to use in other projects.

## Used Images
```
docker pull postgres
docker pull dpage/pgadmin4
docker pull alpine
```

Alpine image is only used for checking, whether the backup is in place.  

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

## Example Databases

dvdrental - A ready to go database, which can be used out of the box. Taken from the Postgres tutorial:  
https://www.postgresqltutorial.com/postgresql-sample-database/  

cities - Datebase taken and downloaded from geonames.org which has all cities >15000 included from all over the world.  

When you restore the database in the TAR files and execute the docker-compose file, you´re ready to go.

## How to import the cities.txt exported from geonaames.org

First you must create the table in PostgreSQL. Open PgAdmin4, choose the database and open the query editor. Run theses lines then:  

```
CREATE TABLE alltowns (
    geonameid BIGINT,
    name VARCHAR(200),
    asciiname VARCHAR(200),
    alternatenames TEXT,
    latitude VARCHAR(20),
    longitude VARCHAR(20),
    feature_class CHAR(1),
    feature_code VARCHAR(10),
    country_code VARCHAR(2),
    cc2 VARCHAR(200),
    admin1_code VARCHAR(20),
    admin2_code VARCHAR(80),
    admin3_code VARCHAR(20),
    admin4_code VARCHAR(20),
    population BIGINT,
    elevation BIGINT,
    dem VARCHAR(40),
    timezone VARCHAR(40),
    modification_date VARCHAR(20),
    PRIMARY KEY (geonameid)
);
```

This copy command in PostgreSQL imports the file cities.txt into PostgreSQL  

```
\COPY alltowns(geonameid, name, asciiname, alternatenames, latitude, longitude, feature_class, feature_code, country_code, cc2, admin1_code, admin2_code, admin3_code, admin4_code, population, elevation, dem, timezone, modification_date) FROM 'allCountries.txt' DELIMITER E'\t' CSV HEADER encoding 'UTF8';
```

This is the explanation for the table cells:

```
geonameid         : integer id of record in geonames database
name              : name of geographical point (utf8) varchar(200)
asciiname         : name of geographical point in plain ascii characters, varchar(200)
alternatenames    : alternatenames, comma separated, ascii names automatically transliterated, convenience attribute from alternatename table, varchar(10000)
latitude          : latitude in decimal degrees (wgs84)
longitude         : longitude in decimal degrees (wgs84)
feature class     : see http://www.geonames.org/export/codes.html, char(1)
feature code      : see http://www.geonames.org/export/codes.html, varchar(10)
country code      : ISO-3166 2-letter country code, 2 characters
cc2               : alternate country codes, comma separated, ISO-3166 2-letter country code, 200 characters
admin1 code       : fipscode (subject to change to iso code), see exceptions below, see file admin1Codes.txt for display names of this code; varchar(20)
admin2 code       : code for the second administrative division, a county in the US, see file admin2Codes.txt; varchar(80) 
admin3 code       : code for third level administrative division, varchar(20)
admin4 code       : code for fourth level administrative division, varchar(20)
population        : bigint (8 byte int) 
elevation         : in meters, integer
dem               : digital elevation model, srtm3 or gtopo30, average elevation of 3''x3'' (ca 90mx90m) or 30''x30'' (ca 900mx900m) area in meters, integer. srtm processed by cgiar/ciat.
timezone          : the iana timezone id (see file timeZone.txt) varchar(40)
modification date : date of last modification in yyyy-MM-dd format
```

## Node API Application to retrieve data from PostgreSQL

TBD
