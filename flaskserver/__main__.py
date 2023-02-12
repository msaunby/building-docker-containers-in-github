from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route("/")
def home():
    return render_template('home.html', version=version)

if __name__ == "__main__":
    global version
    port = os.environ.get('PORT')
    version = os.environ.get('VERSION', 'v-.-.-')
    app.run(host='0.0.0.0', port=port)