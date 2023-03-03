# app.py
from flask import Flask, redirect, url_for, render_template, request, flash
from flask_mail import Message, Mail
from modal.pubchem import get_response

app = Flask(__name__)
app.secret_key = "82fd8571df566392826556f5787e1efb"

app.config.update(dict(
    MAIL_SERVER = 'smtp.googlemail.com',
    MAIL_PORT = 465,
    MAIL_USE_TLS = False,
    MAIL_USE_SSL = True,
    MAIL_USERNAME = 'tcbg.mdu@gmail.com',
#    MAIL_PASSWORD = 'tcbg209#'
    MAIL_PASSWORD = 'qjmvysjyieyooubo'
))
mail = Mail(app)

@app.route("/", methods=['GET', 'POST'])
def home():
    response = {}
    search = ''
    if request.method == 'POST':
        search = request.values.get('search')
        response = get_response(search)
        print (response)
        return render_template('home_result.html', response=response, message = response.get('message'), search=search)
    
    else:
        return render_template('home.html')

@app.route('/about')
def about():
    return render_template('about_us.html')
    
@app.route('/feedback')
def feedback():
    return render_template('feedback.html')

@app.route("/submit", methods=["POST"])
def process_email():
    if (not request.form.get("name") or not request.form.get("email") or not request.form.get("feedback")):
        return render_template("feedback_error.html")
    
    with mail.connect():
        name= request.form.get("name")
        email= request.form.get("email")
        country= request.form.get("country")
        feedback= request.form.get("feedback")
        msg = Message('Feedback form from {}'.format(name), sender='tcbg.mdu@gmail.com', recipients=['ajitkumar.cbinfo@mdurohtak.ac.in'])
        msg.body = 'Feedback:{} \n Name: {} \n Country: {} \n Email: {}'.format(feedback,name,country,email)
        mail.send(msg)

    return render_template("feedback_success.html")

if __name__ == "__main__":
    app.debug = True
    app.run(host="localhost", port=5050)