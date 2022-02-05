# syntax=docker/dockerfile:1

FROM python:3.8-alpine

WORKDIR /app

COPY . /app/
RUN pip install -r /app/requirements.txt

COPY . .

CMD [ "python", "-m" , "flask", "run", "--host=0.0.0.0"]