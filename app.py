
import os
import datetime as dt

from flask import Flask, render_template, make_response
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, Table, MetaData
import random


iot_waste_db_name = os.environ['iot_waste_db_name']
iot_waste_db_host = os.environ['iot_waste_db_host']
iot_waste_db_port = os.environ['iot_waste_db_port']
iot_waste_db_user_name = os.environ['iot_waste_db_user_name']
iot_waste_db_user_pass = os.environ['iot_waste_db_user_pass']

waste_db_connection_info = f"postgresql://{iot_waste_db_user_name}:{iot_waste_db_user_pass}"
waste_db_connection_info += f"@{iot_waste_db_host}:{iot_waste_db_port}/{iot_waste_db_name}"


app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False


WasteDbBase = automap_base()
waste_db_engine = create_engine(waste_db_connection_info)
WasteDbBase.prepare(waste_db_engine, reflect=True)



@app.route("/")
def index():

    session = Session(waste_db_engine)
    team_model = WasteDbBase.classes.team
    waste_model = WasteDbBase.classes.manufucturing_waste_name

    teams = session.query(team_model).order_by(team_model.id.asc())
    waste_names = session.query(waste_model).order_by(waste_model.id.asc())

    manufucturing_teams = [
        (team.id, str(team.team_name)) for team in teams]
    waste_names = [
        (waste.id, waste.waste_name) for waste in waste_names]

    session.close()

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

    team_id = 11
    waste_id = 22
    waste_weight = 33
    waste_weight_unit = 'kg'

    session = Session(waste_db_engine)
    history_model = WasteDbBase.classes.waste_history

    just_now = dt.datetime.now()

    session.add(history_model(
        team_id=team_id,
        waste_id=waste_id,
        waste_weight=waste_weight,
        waste_weight_unit = waste_weight_unit,
        last_update_timestamp = just_now,
        create_timestamp = just_now
    ))
    session.commit()

    return make_response('Success')
