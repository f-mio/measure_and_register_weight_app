
CREATE TABLE IF NOT EXISTS waste_history
  (
    id SERIAL NOT NULL PRIMARY KEY,
    plant_id INTEGER,
    branch_id INTEGER,
    department_id INTEGER,
    processing_line_id INTEGER,
    team_id INTEGER,
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


-- ゴミ
CREATE TABLE IF NOT EXISTS waste_major_classification
  (
    id SERIAL NOT NULL PRIMARY KEY,
    classification_name VARCHAR(20),
    is_active BOOLEAN,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;


CREATE TABLE IF NOT EXISTS waste_middle_classification
  (
    id SERIAL NOT NULL PRIMARY KEY,
    classification_name VARCHAR(20),
    major_classification_id INTEGER,
    is_active BOOLEAN,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;
-- リレーション
ALTER TABLE waste_middle_classification
ADD CONSTRAINT middle_class_fk_from_major_class
  FOREIGN KEY ( major_classification_id ) REFERENCES waste_major_classification ( id )
;


CREATE TABLE IF NOT EXISTS waste_minor_classification
  (
    id SERIAL NOT NULL PRIMARY KEY,
    classification_name VARCHAR(20),
    middle_classification_id INTEGER,
    is_active BOOLEAN,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;
-- リレーション
ALTER TABLE waste_minor_classification
ADD CONSTRAINT minor_class_fk_from_middle_class
  FOREIGN KEY ( middle_classification_id ) REFERENCES waste_middle_classification ( id )
;


CREATE TABLE IF NOT EXISTS waste_name
  (
    id SERIAL NOT NULL PRIMARY KEY,
    waste_name VARCHAR(20),
    minor_classification_id INTEGER,
    is_active BOOLEAN,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;
-- リレーション
ALTER TABLE waste_name
ADD CONSTRAINT waste_name_fk_from_minor_class
  FOREIGN KEY ( minor_classification_id ) REFERENCES waste_minor_classification ( id )
;



