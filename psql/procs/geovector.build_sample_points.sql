-- PROCEDURE: geovector.build_sample_points()

-- DROP PROCEDURE geovector.build_sample_points();

CREATE OR REPLACE PROCEDURE geovector.build_sample_points(
	)
LANGUAGE 'plpgsql'

AS $BODY$

DECLARE
	edge_length NUMERIC(9,6) := 50.0;
	sample_segments INTEGER := 50;
	sample_distance NUMERIC(9,6) := edge_length / sample_segments;
	
BEGIN 

TRUNCATE geovector.sample_points;

INSERT INTO geovector.sample_points (edge_id, geom)
-- get the sample points for each edge
SELECT	edge.id AS edge_id,
		(ST_DumpPoints(ST_Segmentize(edge.geom, sample_distance))).geom AS geom
FROM	network.edges_geom AS edge;

END

$BODY$;
