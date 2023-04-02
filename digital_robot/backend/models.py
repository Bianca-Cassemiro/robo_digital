from main import app, db


#Cria o modelo de tabela para o banco de dados
class Position(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    x = db.Column(db.Float, nullable = True, unique = False)
    y = db.Column(db.Float) 
    z = db.Column(db.Float) 
    rX = db.Column(db.Float) 
    rY = db.Column(db.Float) 
    rZ = db.Column(db.Float) 

with app.app_context():
    db.drop_all()
    db.create_all()    

def __init__(self, x,y,z):
        self.x = x
        self.y = y
        self.z = z
