
CREATE TABLE IF NOT EXISTS waste_history
  (
    id SERIAL NOT NULL PRIMARY KEY,
    plant_id INTEGER,
    branch_id INTEGER,
    department_id INTEGER,
    processing_line_id INTEGER,
    team_id INTEGER,
    valid_asin_ratio FLOAT,
    major_waste_classification_id INTEGER,
    middle_waste_classification_id INTEGER,
    minor_waste_classification_id INTEGER,
    waste_id INTEGER,
    waste_weight FLOAT,
    waste_weight_unit VARCHAR(5),
    date_layer_flg INTEGER,
    department_layer_flg INTEGER,
    waste_layer_flg INTEGER,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  );


-- 事業所
CREATE TABLE IF NOT EXISTS plant
  (
    id SERIAL NOT NULL PRIMARY KEY,
    plant_name VARCHAR(20),
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;

CREATE TABLE IF NOT EXISTS branch
  (
    id SERIAL NOT NULL PRIMARY KEY,
    branch_name VARCHAR(20),
    plant_id INTEGER,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;

CREATE TABLE IF NOT EXISTS department
  (
    id SERIAL NOT NULL PRIMARY KEY,
    department_name VARCHAR(20),
    branch_id INTEGER,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;

CREATE TABLE IF NOT EXISTS processing_line
  (
    id SERIAL NOT NULL PRIMARY KEY,
    line_name VARCHAR(20),
    department_id INTEGER,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;

CREATE TABLE IF NOT EXISTS team
  (
    id SERIAL NOT NULL PRIMARY KEY,
    team_name VARCHAR(20),
    line_id INTEGER,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;


-- ゴミ
CREATE TABLE IF NOT EXISTS major_waste_classification
  (
    id SERIAL NOT NULL PRIMARY KEY,
    classification_name VARCHAR(20),
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;


CREATE TABLE IF NOT EXISTS middle_waste_classification
  (
    id SERIAL NOT NULL PRIMARY KEY,
    classification_name VARCHAR(20),
    major_waste_classification_id INTEGER,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;


CREATE TABLE IF NOT EXISTS minor_waste_classification
  (
    id SERIAL NOT NULL PRIMARY KEY,
    classification_name VARCHAR(20),
    middle_waste_classification_id INTEGER,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;


CREATE TABLE IF NOT EXISTS manufucturing_waste_name
  (
    id SERIAL NOT NULL PRIMARY KEY,
    waste_name VARCHAR(20),
    minor_waste_classification_id INTEGER,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;



