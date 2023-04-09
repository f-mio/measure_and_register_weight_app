truncate table public.waste_history;

copy public.waste_history
(
  id,
  plant_id, branch_id, department_id, processing_line_id, team_id,
  major_waste_classification_id, middle_waste_classification_id, minor_waste_classification_id, waste_id,
  waste_weight, waste_weight_unit,
  date_layer_flg, department_layer_flg, waste_layer_flg,
  last_update_timestamp, last_update_user_id, create_timestamp
)
from '/any/path/to/measure_and_register_weight_app/setting_files/database/initial_data/waste_database/test_record_for_graph_20230409.csv'
with (
  FORMAT 'csv',
  DELIMITER ',',
  NULL '',
  HEADER true,
  ENCODING 'utf8'
)
;