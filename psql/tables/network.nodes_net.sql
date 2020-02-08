-- Table: network.nodes_net

-- DROP TABLE network.nodes_net;

CREATE TABLE network.nodes_net
(
    id integer NOT NULL DEFAULT nextval('network.nodes_net_id_seq'::regclass),
    geom_id integer NOT NULL,
    CONSTRAINT nodes_net_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE network.nodes_net
    OWNER to postgres;