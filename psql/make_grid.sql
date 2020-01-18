DO
$$

DECLARE	
	dx NUMERIC(9,6) := 500.0;
	dy NUMERIC(9,6) := 500.0;
	max_x INTEGER := 10;
	max_y INTEGER := 10;
		 
BEGIN
 
 TRUNCATE TABLE network.nodes_geom RESTART IDENTITY;
 FOR i IN 0..max_x-1 LOOP
   FOR j IN 0..max_y-1 LOOP
   
     -- insert node at each x, y coordinate
     INSERT INTO network.nodes_geom(node_id, geom)
	 VALUES (format('%s-%s',i,j), ST_SetSRID(ST_Point(i * dx, j * dy), 3857));
     RAISE NOTICE '%-%', i, j;
	 
   END LOOP;
 END LOOP;
 
 TRUNCATE TABLE network.edges_geom RESTART IDENTITY;
 FOR i IN 0..max_x-2 LOOP
   FOR j IN 0..max_y-2 LOOP	 
	 
     INSERT INTO network.edges_geom(edge_id, geom)
	 VALUES	
	 	(format('%s-%s:%s-%s', i, j, i+1, j), ST_SetSRID(ST_MakeLine(ST_MakePoint(i * dx, j * dy), ST_MakePoint((i+1) * dx, j * dy)), 3857)),
	 	(format('%s-%s:%s-%s', i, j, i, j+1), ST_SetSRID(ST_MakeLine(ST_MakePoint(i * dx, j * dy), ST_MakePoint(i * dx, (j+1) * dy)), 3857));
     RAISE NOTICE '%-%:%-%', i, j, i+1, j;
	 RAISE NOTICE '%-%:%-%', i, j, i, j+1;
	 
     -- insert additional vertical edge in right-most column
     IF i = max_x-2 THEN
	 INSERT INTO network.edges_geom(edge_id, geom)
	 VALUES
	 	(format('%s-%s:%s-%s', i+1, j, i+1, j+1), ST_SetSRID(ST_MakeLine(ST_MakePoint((i+1) * dx, j * dy), ST_MakePoint((i+1) * dx, (j+1) * dy)), 3857));
	 RAISE NOTICE '%-%:%-%', i+1, j, i+1, j+1;
	 END IF;
	 
	 -- insert additional horizontal edge in top-most row
     IF j = max_y-2 THEN
	 INSERT INTO network.edges_geom(edge_id, geom)
	 VALUES
	 	(format('%s-%s:%s-%s', i, j+1, i+1, j+1), ST_SetSRID(ST_MakeLine(ST_MakePoint(i * dx, (j+1) * dy), ST_MakePoint((i+1) * dx, (j+1) * dy)), 3857));
	 RAISE NOTICE '%-%:%-%', i, j+1, i+1, j+1;
	 END IF;
	 
   END LOOP;
 END LOOP;
 
END
$$