FROM eu.gcr.io/vnet-core/circleci/python-base:latest as base_image

RUN pip3 install --upgrade --no-cache-dir pip setuptools



FROM base_image as intermediate
WORKDIR /pip-packages/
ADD ./requirements.txt .
RUN ls -la
RUN pip3 download --extra-index-url=${PIP_EXTRA_INDEX_URL} -r ./requirements.txt && \
    rm ./requirements.txt



FROM base_image
WORKDIR /pip-packages/
COPY --from=intermediate /pip-packages/ /pip-packages/
RUN pip3 install --no-index --find-links=/pip-packages/ /pip-packages/*
