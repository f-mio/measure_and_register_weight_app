
import os
import datetime as dt

from flask import Flask, render_template, make_response, request
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, Table, MetaData
from sqlalchemy import select
import random


waste_db_connection_info = os.environ['iot_prj_khepri_db_connection_url']
core_db_connection_info = os.environ['iot_core_db_connection_url']


app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False


WasteDbBase = automap_base()
waste_db_engine = create_engine(waste_db_connection_info)
WasteDbBase.prepare(waste_db_engine, reflect=True)

CoreDbBase = automap_base()
core_db_engine = create_engine(core_db_connection_info)
CoreDbBase.prepare(core_db_engine, reflect=True)



@app.route("/")
def index():

    waste_session = Session(waste_db_engine)
    waste_model = WasteDbBase.classes.waste_name
    waste_names = waste_session.query(waste_model).order_by(waste_model.id.asc())

    coredb_session = Session(core_db_engine)
    team_model = CoreDbBase.classes.team
    teams = coredb_session.query(team_model).order_by(team_model.id.asc())

    manufucturing_teams = [
        (team.id, str(team.team_name)) for team in teams]
    waste_names = [
        (waste.id, waste.waste_name) for waste in waste_names]

    waste_session.close()
    coredb_session.close()

    return render_template(
        'index/index.html',
        manufucturing_teams = manufucturing_teams,
        waste_names = waste_names
    )

@app.route("/api/weight/", methods=['GET'])
def weight_api():

    weight = random.randrange(1980, 2020) / 100

    return make_response(str(weight))


@app.route("/api/register_waste_weight/", methods=['POST'])
def register_waste_weight_to_database():

    request_data = request.json

    team_id = request_data['teamId']
    waste_id = request_data['wasteId']
    waste_weight = request_data['wasteWeightValue']
    waste_weight_unit = request_data['wasteWeightUnit']

    # セッション開始
    waste_session = Session(waste_db_engine)
    coredb_session = Session(core_db_engine)


    # ゴミ分類用データ取得
    WasteName = WasteDbBase.classes.waste_name
    query = select(WasteName.minor_classification_id).where(WasteName.id == waste_id)
    minor_id = waste_session.execute(query).all()[0].minor_classification_id

    MinorClass = WasteDbBase.classes.waste_minor_classification
    query = select(MinorClass.middle_classification_id).where(MinorClass.id == minor_id)
    middle_id = waste_session.execute(query).all()[0].middle_classification_id

    MiddleClass = WasteDbBase.classes.waste_middle_classification
    query = select(MiddleClass.major_classification_id).where(MiddleClass.id == middle_id)
    major_id = waste_session.execute(query).all()[0].major_classification_id

    # 部署情報用データ取得
    Team = CoreDbBase.classes.team
    query = select(Team.line_id).where(Team.id == team_id)
    line_id = coredb_session.execute(query).all()[0].line_id

    Line = CoreDbBase.classes.processing_line
    query = select(Line.department_id).where(Line.id == line_id)
    department_id = coredb_session.execute(query).all()[0].department_id

    Depart = CoreDbBase.classes.department
    query = select(Depart.branch_id).where(Depart.id == department_id)
    branch_id = coredb_session.execute(query).all()[0].branch_id

    Branch = CoreDbBase.classes.branch
    query = select(Branch.plant_id).where(Branch.id == branch_id)
    plant_id = coredb_session.execute(query).all()[0].plant_id

    current_time = dt.datetime.now()


    History = WasteDbBase.classes.waste_history
    waste_session.add(History(
        plant_id = plant_id,
        branch_id = branch_id,
        department_id = department_id,
        processing_line_id = line_id,
        team_id = team_id,
        major_waste_classification_id = major_id,
        middle_waste_classification_id = middle_id,
        minor_waste_classification_id = minor_id,
        waste_id = waste_id,
        waste_weight = waste_weight,
        waste_weight_unit = waste_weight_unit,
        last_update_timestamp = current_time,
        create_timestamp = current_time
    ))
    waste_session.commit()

    waste_session.close()
    coredb_session.close()


    return make_response('Success')
