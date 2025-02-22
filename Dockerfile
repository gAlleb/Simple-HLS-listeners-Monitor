FROM python:3.9-slim-buster
RUN mkdir /var/log/nginx
WORKDIR /app
COPY ./hls_listeners_api.py .
RUN pip install --no-cache requests aiohttp
CMD [ "python", "hls_listeners_api.py" ]