
COPY
  plant
  (
	id, plant_name, is_active,
	last_update_timestamp, last_update_user_id, create_timestamp
  )
FROM
  '/any/path/to/plant_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  branch
  (
	id, branch_name, plant_id, is_active,
	last_update_timestamp, last_update_user_id, create_timestamp
  )
FROM
  '/any/path/to/branch_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  department
  (
	id, department_name, branch_id, is_active,
	last_update_timestamp, last_update_user_id, create_timestamp
  )
FROM
  '/any/path/to/department_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  processing_line
  (
    id, line_name, department_id, is_active,
	last_update_timestamp, last_update_user_id, create_timestamp
  )
FROM
  '/any/path/to/processing_line_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  team
  (
	id, team_name, line_id, is_active,
	last_update_timestamp, last_update_user_id, create_timestamp
  )
FROM
  '/any/path/to/team_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8');
