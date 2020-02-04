-- Table: geovector.sample_points

-- DROP TABLE geovector.sample_points;

CREATE TABLE geovector.sample_points
(
    id integer NOT NULL DEFAULT nextval('geovector.sample_points_id_seq'::regclass),
    edge_id integer NOT NULL,
    geom geometry(Point,6341),
    CONSTRAINT sample_points_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE geovector.sample_points
    OWNER to postgres;

-- Index: sidx_sample_points_geom

-- DROP INDEX geovector.sidx_sample_points_geom;

CREATE INDEX sidx_sample_points_geom
    ON geovector.sample_points USING gist
    (geom)
    TABLESPACE pg_default;