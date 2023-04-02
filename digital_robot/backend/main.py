#Importação das bibliotecas e classes necessárias
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
import models
import sqlite3
import os.path

#Instancia o banco de dados 
base_dir = os.path.dirname(os.path.abspath("sqlite:///bianca.db"))
#Intancia o flask na variável app
app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///bianca.db"
CORS(app)
db = SQLAlchemy()
#Iniciamos o banco de dados
db.init_app(app)
#Corrigimos o erro de CORS 
cors = CORS(app, resources={"/create": {"origins": "http://localhost:port:3000"}})
app.debug = True
db.path = os.path.join(base_dir, "bianca.db")

def getData():
    #Conectamos ao banco de dados
    data = sqlite3.connect("C:\\users\\inteli\\documentos\\robo_digital\\digital_robot\\backend\\instance\\bianca.db")
    cursor = data.cursor()
    #Seleciona as colunas referentes as posições e os ângulos
    cursor.execute('SELECT x,y,z,rX,rY,rZ FROM position ORDER BY id DESC LIMIT 1')
    rows = cursor.fetchall()
    data.close()

    positions = []
    for row in rows:
        cod = {}
        cod['x'] = row[0]
        cod['y'] = row[1]
        cod['z'] = row[2]
        cod['rX'] = row[3]
        cod['rY'] = row[4]
        cod['rZ'] = row[5]
        positions.append(cod)

    return positions
#Cria a requisição POST para salvar as informações no banco de dados
@app.route('/create', methods = ['POST'])
def create():
    position = models.Position(x=request.form['x'], y=request.form['y'], z=request.form['z'], rX=request.form['rX'],rY=request.form['rY'],rZ=request.form['rZ'])
    db.session.add(position)
    db.session.commit()
    x = request.form['x']
    y = request.form['y']
    z = request.form['z']
    string = f"Sua posição atual é X = {x} Y = {y} Z = {z}"
    return string
   
#Cria a requisição GET para salvar as informações no banco de dados
@app.route('/position', methods = ['GET'])
def position():
    positions = getData()
    return jsonify(positions)

if __name__ == "__main__":
    app.run()

