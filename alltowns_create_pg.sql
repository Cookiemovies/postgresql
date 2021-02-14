CREATE TABLE public.alltowns
(
    geonameid bigint NOT NULL,
    name character varying(200) COLLATE pg_catalog."default",
    asciiname character varying(200) COLLATE pg_catalog."default",
    alternatenames text COLLATE pg_catalog."default",
    latitude character varying(20) COLLATE pg_catalog."default",
    longitude character varying(20) COLLATE pg_catalog."default",
    feature_class character(1) COLLATE pg_catalog."default",
    feature_code character varying(10) COLLATE pg_catalog."default",
    country_code character varying(2) COLLATE pg_catalog."default",
    cc2 character varying(200) COLLATE pg_catalog."default",
    admin1_code character varying(20) COLLATE pg_catalog."default",
    admin2_code character varying(80) COLLATE pg_catalog."default",
    admin3_code character varying(20) COLLATE pg_catalog."default",
    admin4_code character varying(20) COLLATE pg_catalog."default",
    population bigint,
    elevation bigint,
    dem character varying(40) COLLATE pg_catalog."default",
    timezone character varying(40) COLLATE pg_catalog."default",
    modification_date character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT alltowns_pkey PRIMARY KEY (geonameid)
)

TABLESPACE pg_default;

ALTER TABLE public.alltowns
    OWNER to admin;
