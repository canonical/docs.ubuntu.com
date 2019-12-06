# syntax=docker/dockerfile:experimental

# Build stage: Install python dependencies
# ===
FROM ubuntu:bionic AS python-dependencies
RUN apt update && apt install --no-install-recommends --yes python3 python3-pip python3-setuptools
ADD requirements.txt /tmp/requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip pip3 install --user --requirement /tmp/requirements.txt

# # Build the production image
# # ===
FROM ubuntu:bionic

# Install python and import python dependencies
RUN apt-get update && apt-get install --no-install-recommends --yes python3 python3-lib2to3 python3-pkg-resources
COPY --from=python-dependencies /root/.local/lib/python3.6/site-packages /root/.local/lib/python3.6/site-packages
COPY --from=python-dependencies /root/.local/bin /root/.local/bin
ENV PATH="/root/.local/bin:${PATH}"

ADD . .

# Set build id (standardized)
ARG BUILD_ID
ENV TALISKER_REVISION_ID "${BUILD_ID}"

# Setup commands to run server
ENTRYPOINT ["./entrypoint"]
CMD ["0.0.0.0:80"]