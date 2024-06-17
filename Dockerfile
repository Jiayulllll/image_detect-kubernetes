# syntax=docker/dockerfile:1
FROM python:3.8
WORKDIR /code
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apt update
RUN apt-get install -y python3-opencv
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
ADD yolo_tiny_configs /code/yolo_tiny_configs
ADD object_detection.py /code
ADD app.py /code
CMD ["flask", "run"]