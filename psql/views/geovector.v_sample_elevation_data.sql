-- View: geovector.v_sample_elevation_data

-- DROP VIEW geovector.v_sample_elevation_data;

CREATE OR REPLACE VIEW geovector.v_sample_elevation_data
 AS
 SELECT point.id AS point_id,
    point.edge_id,
    st_x(point.geom) AS sample_x,
    st_y(point.geom) AS sample_y,
    sample.sample_value,
    point.geom
   FROM geovector.sample_points point,
    geovector.sample_elevation sample
  WHERE point.id = sample.point_id
  ORDER BY point.id;

ALTER TABLE geovector.v_sample_elevation_data
    OWNER TO postgres;

