FROM python:3.11-alpine
WORKDIR /api/app
COPY ./requirements.txt /api/app/requirements.txt
# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN pip install --no-cache-dir --upgrade -r /api/app/requirements.txt
COPY . /api/app/
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80", "--reload"]
