SELECT		pt.edge_id,
			pt.id AS sample_id,
			ST_X(pt.geom),
			ST_Y(pt.geom),
			elev.elevation_value,
			pt.geom
FROM		geovector.sample_points pt,
			geovector.sample_values_elevation elev
WHERE		pt.id = elev.sample_point_id
ORDER BY	edge_id,
			pt.id