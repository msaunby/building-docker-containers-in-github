from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route("/")
def home():
    return render_template('home.html')

if __name__ == "__main__":

    port = os.environ.get('PORT')
    app.run(host='0.0.0.0', port=port)