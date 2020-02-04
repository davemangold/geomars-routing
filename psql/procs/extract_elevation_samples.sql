-- PROCEDURE: geovector.extract_elevation_samples()

-- DROP PROCEDURE geovector.extract_elevation_samples();

CREATE OR REPLACE PROCEDURE geovector.extract_elevation_samples(
	)
LANGUAGE 'plpgsql'

AS $BODY$

BEGIN 

TRUNCATE geovector.sample_values_elevation;

INSERT INTO geovector.sample_values_elevation (
		sample_point_id,
		elevation_value
)
SELECT	sample_point.id AS sample_point_id,
		ST_Value(rast, 1, sample_point.geom) AS elevation_value
FROM	geovector.sample_points AS sample_point,
		georaster.mdrs_dem AS rast
		-- point.geom as first arg to utilize spatial index
WHERE	ST_Intersects(sample_point.geom, rast);

END

$BODY$;
