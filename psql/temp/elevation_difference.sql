SELECT		this_sample.edge_id,
			this_sample.point_id,
			this_sample.sample_x AS this_x,
			this_sample.sample_y AS this_y,
			this_sample.sample_value AS this_value,
			next_sample.sample_x AS next_x,
			next_sample.sample_y AS next_y,
			next_sample.sample_value AS next_value,
			next_sample.sample_x - this_sample.sample_x AS delta_x,
			next_sample.sample_y - this_sample.sample_y AS delta_y,
			next_sample.sample_value - this_sample.sample_value AS delta_value
FROM		geovector.sample_elevation_data AS this_sample
			INNER JOIN 
			geovector.sample_elevation_data AS next_sample
			ON	this_sample.edge_id = next_sample.edge_id
				AND this_sample.point_id + 1 = next_sample.point_id
ORDER BY	this_sample.point_id