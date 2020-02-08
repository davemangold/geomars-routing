-- Table: network.edges_net

-- DROP TABLE network.edges_net;

CREATE TABLE network.edges_net
(
    id integer NOT NULL DEFAULT nextval('network.edges_net_id_seq'::regclass),
    geom_id integer NOT NULL,
    from_node integer NOT NULL,
    to_node integer NOT NULL,
    CONSTRAINT edges_net_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE network.edges_net
    OWNER to postgres;