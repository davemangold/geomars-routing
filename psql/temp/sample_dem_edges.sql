DO $$

DECLARE
	edge_length NUMERIC(9,6) := 50.0;
	sample_segments INTEGER := 1;
	sample_distance NUMERIC(9,6) := edge_length / sample_segments;
	
BEGIN 

SELECT	point.edge_id,
		ST_X(point.geom) AS x,
		ST_Y(point.geom) AS y,
		ST_Value(rast, 1, point.geom) AS elevation
FROM	(
		-- get the sample points for each edge
		SELECT	edge.id AS edge_id,
				(ST_DumpPoints(ST_Segmentize(edge.geom, sample_distance))).geom AS geom
				-- (ST_DumpPoints(ST_Segmentize(edge.geom, 50))).geom AS geom
		FROM	network.edges_geom AS edge
		) AS point,
		georaster.mdrs_dem AS rast
		-- point.geom as first arg to utilize spatial index
WHERE	ST_Intersects(point.geom, rast);

END $$;