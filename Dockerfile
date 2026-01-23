# syntax=docker/dockerfile:experimental

# Build stage: Install python dependencies
# ===
FROM ubuntu:noble AS python-dependencies
RUN apt update && apt install --no-install-recommends --yes python3 python3-pip python3-setuptools
COPY requirements.txt /tmp/requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip pip3 install --break-system-packages --user --requirement /tmp/requirements.txt


# Build stage: Install yarn dependencies
# ===
FROM node:25 AS yarn-dependencies
WORKDIR /srv
COPY . .
RUN --mount=type=cache,target=/usr/local/share/.cache/yarn yarn install


# Build stage:
# ===
FROM ubuntu:noble AS build-documentation
WORKDIR /srv
RUN apt-get update && apt-get install --no-install-recommends --yes git ca-certificates python3 python3-pip python3-setuptools
RUN pip3 install --break-system-packages ubuntudesign.documentation-builder gitdb2==3.0.1 MarkupSafe==2.0.1
ADD build-docs.sh build-docs.sh
ADD .git/index /dev/null
RUN ./build-docs.sh

# Build stage: Build CSS
# ===
FROM yarn-dependencies AS build-css
ADD static/sass static/sass
RUN yarn run build-sass

# Build stage: Run "yarn run build-js"
# ===
FROM yarn-dependencies AS build-js
RUN yarn run build-js

# Build the production image
# ===
FROM ubuntu:noble

# Set up environment
ENV LANG C.UTF-8
WORKDIR /srv

# Install python and import python dependencies
RUN apt-get update && apt-get install --no-install-recommends --yes python3-setuptools python3-lib2to3 python3-pkg-resources
COPY --from=python-dependencies /root/.local/lib/python3.8/site-packages /root/.local/lib/python3.8/site-packages
COPY --from=python-dependencies /root/.local/bin /root/.local/bin
ENV PATH="/root/.local/bin:${PATH}"

ADD . .
RUN rm -rf package.json yarn.lock .babelrc webpack.config.js .git
COPY --from=build-css /srv/static/css static/css
COPY --from=build-js /srv/static/js static/js
COPY --from=build-documentation /srv/templates templates
COPY --from=build-documentation /srv/static/media static/media

# Set build id (standardized)
ARG BUILD_ID
ENV TALISKER_REVISION_ID "${BUILD_ID}"

# Setup commands to run server
ENTRYPOINT ["./entrypoint"]
CMD ["0.0.0.0:80"]
