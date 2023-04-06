truncate waste_name cascade;
truncate waste_minor_classification cascade;
truncate waste_middle_classification cascade;
truncate waste_major_classification cascade;


COPY
  waste_major_classification
  (
    id, classification_name, is_active,
    last_update_timestamp, last_update_user_id, create_timestamp
  )
FROM
  '/any/path/to/major_waste_classification_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  waste_middle_classification
  (
    id, classification_name, major_classification_id, is_active,
    last_update_timestamp, last_update_user_id, create_timestamp
  )
FROM
  '/any/path/to/middle_waste_classification_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  waste_minor_classification
  (
    id, classification_name, middle_classification_id, is_active,
    last_update_timestamp, last_update_user_id, create_timestamp

  )
FROM
  '/any/path/to/minor_waste_classification_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  waste_name
  (
    id, waste_name, minor_classification_id, is_active,
    last_update_timestamp, last_update_user_id, create_timestamp
  )
FROM
  '/any/path/to/manufucturing_waste_name_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;
