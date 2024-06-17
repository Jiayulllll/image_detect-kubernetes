import json

from flask import Flask, request
import object_detection

app = Flask(__name__)
# keep the json form
app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True


@app.route("/")
def hello_world():
    return "This is created by JIAYU LIU"


# create a new route(using api same with client) and handle base64 decoding
@app.route("/api/object_detection", methods=["POST"])
def initial_detect():
    # converts the JSON object request into Python data
    py_data = request.get_json()
    # returns to the json object
    json_object = json.loads(py_data)
    return get_response(json_object)


# create a function to get the response as json form
def get_response(image_dict):
    id = image_dict["id"]
    image = image_dict["image"]
    result = object_detection.detect_image(image)
    response = {
        "id": id,
        "objects": result
    }
    return response


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', threaded=True)
