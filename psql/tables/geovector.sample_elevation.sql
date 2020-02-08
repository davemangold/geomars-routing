-- Table: geovector.sample_elevation

-- DROP TABLE geovector.sample_elevation;

CREATE TABLE geovector.sample_elevation
(
    id integer NOT NULL DEFAULT nextval('geovector.elevation_values_id_seq'::regclass),
    point_id integer NOT NULL,
    sample_value double precision,
    CONSTRAINT elevation_values_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE geovector.sample_elevation
    OWNER to postgres;