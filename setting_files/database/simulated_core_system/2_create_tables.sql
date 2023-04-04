---- ロール
-- ロールの作成
CREATE ROLE
  iot_user
  WITH LOGIN PASSWORD 'password';
-- 注意：パスワードは適宜変更すること


---- 事業所
-- テーブル作成
CREATE TABLE IF NOT EXISTS public.plant
  (
    id SERIAL NOT NULL PRIMARY KEY,
    plant_name VARCHAR(20),
    is_active BOOLEAN,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;
-- インデックス
CREATE INDEX IF NOT EXISTS
  plant_index
ON public.plant (id)
;
-- コメント
COMMENT ON TABLE public.plant IS '事業所テーブル'
;
-- 閲覧専用ユーザへの閲覧権限付与
GRANT SELECT
  ON public.plant
  TO iot_user
;

---- 部門
-- テーブル作成
CREATE TABLE IF NOT EXISTS branch
  (
    id SERIAL NOT NULL PRIMARY KEY,
    branch_name VARCHAR(20),
    plant_id INTEGER,
    is_active BOOLEAN,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;
-- リレーション
ALTER TABLE branch
ADD CONSTRAINT branch_fk_from_plant
  FOREIGN KEY ( plant_id ) REFERENCES plant ( id )
;
-- インデックス
CREATE INDEX IF NOT EXISTS
  branch_index
ON public.branch (id)
;
-- コメント
COMMENT ON TABLE public.plant IS
  '部門テーブル。事業所の子テーブル。'
;
-- 閲覧専用ユーザへの閲覧権限付与
GRANT SELECT
  ON public.branch
  TO iot_user
;

---- 部署
-- テーブル作成
CREATE TABLE IF NOT EXISTS department
  (
    id SERIAL NOT NULL PRIMARY KEY,
    department_name VARCHAR(20),
    branch_id INTEGER,
    is_active BOOLEAN,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;
-- リレーション
ALTER TABLE department
ADD CONSTRAINT department_fk_from_branch
  FOREIGN KEY ( branch_id ) REFERENCES branch ( id )
;
-- インデックス
CREATE INDEX IF NOT EXISTS
  department_index
ON public.department (id)
;
-- 閲覧専用ユーザへの閲覧権限付与
GRANT SELECT
  ON public.department
  TO iot_user
;
-- コメント
COMMENT ON TABLE public.department IS
  '部署テーブル。部門の子テーブル。'
;


---- 製造ライン
-- テーブル作成
CREATE TABLE IF NOT EXISTS processing_line
  (
    id SERIAL NOT NULL PRIMARY KEY,
    line_name VARCHAR(20),
    department_id INTEGER,
    is_active BOOLEAN,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;
-- リレーション
ALTER TABLE public.processing_line
ADD CONSTRAINT processing_line_fk_from_department
  FOREIGN KEY ( department_id ) REFERENCES department ( id )
;
-- インデックス
CREATE INDEX IF NOT EXISTS
  processing_line_index
ON public.processing_line (id)
;
-- 閲覧専用ユーザへの閲覧権限付与
GRANT SELECT
  ON public.processing_line
  TO iot_user
;
-- コメント
COMMENT ON TABLE public.processing_line IS
  '製造ラインテーブル。部署の子テーブル。'
;


---- チーム(or 班)
-- テーブル作成
CREATE TABLE IF NOT EXISTS public.team
  (
    id SERIAL NOT NULL PRIMARY KEY,
    team_name VARCHAR(20),
    line_id INTEGER,
    is_active BOOLEAN,
    last_update_timestamp TIMESTAMP,
    last_update_user_id INTEGER,
    create_timestamp TIMESTAMP
  )
;
-- リレーション
ALTER TABLE public.team
ADD CONSTRAINT team_fk_from_processing_line
  FOREIGN KEY ( line_id ) REFERENCES processing_line ( id )
;
-- インデックス
CREATE INDEX IF NOT EXISTS
  team_index
ON public.team (id)
;
-- 閲覧専用ユーザへの閲覧権限付与
GRANT SELECT
  ON public.team
  TO iot_user
;
-- コメント
COMMENT ON TABLE public.team IS
  '製造班テーブル。製造ラインの子テーブル。'
;

