DO
$$

DECLARE
	cent_x NUMERIC(14,6) := 518168.48;  -- grid center
	cent_y NUMERIC(14,6) := 4250932.29;
	dx NUMERIC(9,6) := 50.0;  -- grid spacing
	dy NUMERIC(9,6) := 50.0;
	dim_x INTEGER := 100;  -- grid dimensions
	dim_y INTEGER := 100;
	orig_x NUMERIC(14,6) := cent_x - (dim_x * dx) / 2.0;  -- grid origin
	orig_y NUMERIC(14,6) := cent_y - (dim_y * dy) / 2.0;
		 
BEGIN
 
 -- update nodes
 TRUNCATE TABLE network.nodes_geom RESTART IDENTITY;
 
 FOR i IN 0..dim_x-1 LOOP
   FOR j IN 0..dim_y-1 LOOP
   
     -- insert node at each x, y coordinate
     INSERT INTO network.nodes_geom(geom)
	 VALUES (ST_SetSRID(ST_Point(orig_x + i * dx, orig_y + j * dy), 6341));
	 
   END LOOP;
 END LOOP;
 
 -- update edges
 TRUNCATE TABLE network.edges_geom RESTART IDENTITY;
 
 FOR i IN 0..dim_x-2 LOOP
   FOR j IN 0..dim_y-2 LOOP	 
	 
	 -- insert horizontal and vertical edges for each node except right-most column and top-most row
     INSERT INTO network.edges_geom(node_a, node_b, geom)
	 VALUES
	 	(i * dim_y + j + 1, 
		 (i+1) * dim_y + j + 1, 
		 ST_SetSRID(ST_MakeLine(ST_MakePoint(orig_x + i * dx, orig_y + j * dy), ST_MakePoint(orig_x + (i+1) * dx, orig_y + j * dy)), 6341)),
	 	(i * dim_y + j + 1, 
		 i * dim_y + j + 2,
		 ST_SetSRID(ST_MakeLine(ST_MakePoint(orig_x + i * dx, orig_y + j * dy), ST_MakePoint(orig_x + i * dx, orig_y + (j+1) * dy)), 6341));
	 
     -- insert additional vertical edge in right-most column
     IF i = dim_x-2 THEN
	 INSERT INTO network.edges_geom(node_a, node_b, geom)
	 VALUES
	 	((i+1) * dim_y + j + 1,
		 (i+1) * dim_y + j + 2,
		 ST_SetSRID(ST_MakeLine(ST_MakePoint(orig_x + (i+1) * dx, orig_y + j * dy), ST_MakePoint(orig_x + (i+1) * dx, orig_y + (j+1) * dy)), 6341));
	 END IF;
	 
	 -- insert additional horizontal edge in top-most row
     IF j = dim_y-2 THEN
	 INSERT INTO network.edges_geom(node_a, node_b, geom)
	 VALUES
	 	(i * dim_y + j + 2,
		 (i+1) * dim_y + j + 2,
		 ST_SetSRID(ST_MakeLine(ST_MakePoint(orig_x + i * dx, orig_y + (j+1) * dy), ST_MakePoint(orig_x + (i+1) * dx, orig_y + (j+1) * dy)), 6341));
	 END IF;
	 
   END LOOP;
 END LOOP;
 
END
$$