from flask import Flask, render_template, make_response
import os

app = Flask(__name__)
version = os.environ.get('VERSION', 'v-.-.-')

@app.route("/")
def home():
    response = make_response(render_template('home.html', version=version))
    return response
    # return render_template('home.html', version=version)


if __name__ == "__main__":
    port = os.environ.get('PORT')
    app.run(host='0.0.0.0', port=port, ssl_context='adhoc')