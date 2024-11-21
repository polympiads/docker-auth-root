FROM python:3.13-slim

WORKDIR /app/libs

RUN apt update
RUN apt install -y git

# Install djangorestapi-statelessauth
RUN git clone https://github.com/polympiads/djangorestapi-statelessauth.git
# TODO when dev is merged, remove this line
RUN cd djangorestapi-statelessauth && git checkout dev
RUN pip install -r djangorestapi-statelessauth/requirements.txt

ENV PYTHONPATH=/app/libs/djangorestapi-statelessauth

WORKDIR /app/libs/djangorestapi-statelessauth
RUN bash test.sh

WORKDIR /app
COPY . .

EXPOSE 8501
CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8501" ]
