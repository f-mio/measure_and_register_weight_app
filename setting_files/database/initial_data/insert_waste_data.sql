
COPY
  major_waste_classification
  (
  )
FROM
  '/Users/mio/Python/projects/measure_and_register_weight_app/setting_files/database/initial_data/major_waste_classification_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  middle_waste_classification
  (
  )
FROM
  '/Users/mio/Python/projects/measure_and_register_weight_app/setting_files/database/initial_data/middle_waste_classification_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  minor_waste_classification
  (
  )
FROM
  '/Users/mio/Python/projects/measure_and_register_weight_app/setting_files/database/initial_data/minor_waste_classification_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;

COPY
  manufucturing_waste_name
  (
  )
FROM
  '/Users/mio/Python/projects/measure_and_register_weight_app/setting_files/database/initial_data/manufucturing_waste_name_table_data.csv'
WITH (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8')
;
