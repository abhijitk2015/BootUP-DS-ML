from flask import Flask,render_template,request
import joblib

app = Flask(__name__) # creating an app object
preprocessor = joblib.load("preprocessor.pkl")
model = joblib.load("bank_churn.pkl")


@app.route("/",methods=['GET','POST'])
def main():
    return render_template("index.html")

@app.route("/predict",methods=['GET','POST'])
def main2():
    data=dict(request.form)
    data2 = [int(data['cs']),data['geo'],data['gender'],int(data['age']),int(data['bal']),int(data['nop']),int(data['isam'])]
    data2 = preprocessor.transform([data2])
    output = model.predict(data2)
    data["Prediction"] = output[0]
    data["churn Probability"] = str(round(model.predict_proba(data2)[0][1]*100,3)) + " %"
    print(data)
    return render_template("output.html",output=data)

if __name__=='__main__':
    app.run(debug=True)