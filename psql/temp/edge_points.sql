SELECT	edge_id,
		point
FROM	(
		SELECT	geom.id AS edge_id,
				(ST_DumpPoints(ST_Segmentize(geom, 10))).geom AS point
		FROM	network.edges_geom AS geom
		) AS dp