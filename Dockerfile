FROM python:3
RUN curl -sSL https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kubectl > /usr/local/bin/kubectl
WORKDIR /app
COPY . /app
RUN pip install kubernetes
CMD [ "python","main.py" ] 