SELECT	ST_X(point.geom) AS x,
		ST_Y(point.geom) AS y,
		ST_Value(rast, 1, point.geom) AS elevation
FROM	network.nodes_geom AS point,
		georaster.mdrs_dem AS rast
WHERE	ST_Intersects(point.geom, rast)  -- point.geom as first arg to utilize spatial index