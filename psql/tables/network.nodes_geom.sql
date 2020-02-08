-- Table: network.nodes_geom

-- DROP TABLE network.nodes_geom;

CREATE TABLE network.nodes_geom
(
    id integer NOT NULL DEFAULT nextval('network.nodes_geom_id_seq'::regclass),
    geom geometry(Point,6341),
    CONSTRAINT nodes_geom_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE network.nodes_geom
    OWNER to postgres;

-- Index: sidx_nodes_geom_geom

-- DROP INDEX network.sidx_nodes_geom_geom;

CREATE INDEX sidx_nodes_geom_geom
    ON network.nodes_geom USING gist
    (geom)
    TABLESPACE pg_default;