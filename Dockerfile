# pull official base image
FROM python:3.8.3-alpine

# set work directory
WORKDIR /usr/app/

# set environment variables
## Prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE 1 
## Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# install dependencies
ARG APP_ENVIROMENT="production"
RUN pip install --upgrade pip
COPY requirements/base.txt requirements/${APP_ENVIROMENT}.txt ./
RUN pip install -r ${APP_ENVIROMENT}.txt

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["/usr/app/entrypoint.sh"]

# Finish
RUN echo "Builded on" $APP_ENVIROMENT "environment"