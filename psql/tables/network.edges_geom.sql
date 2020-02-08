-- Table: network.edges_geom

-- DROP TABLE network.edges_geom;

CREATE TABLE network.edges_geom
(
    id integer NOT NULL DEFAULT nextval('network.edges_geom_id_seq'::regclass),
    node_a integer NOT NULL,
    node_b integer NOT NULL,
    geom geometry(LineString,6341),
    CONSTRAINT edges_geom_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE network.edges_geom
    OWNER to postgres;

-- Index: sidx_edges_geom_geom

-- DROP INDEX network.sidx_edges_geom_geom;

CREATE INDEX sidx_edges_geom_geom
    ON network.edges_geom USING gist
    (geom)
    TABLESPACE pg_default;