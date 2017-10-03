# Build final image
FROM ubuntu:xenial

# Import code, install code dependencies
WORKDIR /srv
ADD . /srv

# System dependencies
RUN apt-get update && apt-get install --yes python3-pip

# Python dependencies
ENV LANG C.UTF-8
RUN pip3 install --upgrade pip && pip3 install gunicorn -r requirements.txt

# Set git commit ID
ARG COMMIT_ID=""

# Setup commands to run server
EXPOSE 80
ENTRYPOINT ["gunicorn", "webapp.wsgi", "-b"]
CMD ["0.0.0.0:80"]
