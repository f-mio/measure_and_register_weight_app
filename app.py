from flask import Flask, render_template, make_response
import random

app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False


manufucturing_teams = [
    [1,"Aライン"], [2,"Bライン"],
    [3, "Cライン"]]
waste_names = [
    [1,"貝"], [2,"抜け殻"],
    [3, "すき焼き"]]

@app.route("/")
def index():
    return render_template(
        'index/index.html',
        manufucturing_teams = manufucturing_teams,
        waste_names = waste_names
    )

@app.route("/api/weight", methods=['GET'])
def weight_api():

    weight = random.randrange(1980, 2020) / 100

    return make_response(str(weight))