FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

RUN python manage.py migrate
RUN python manage.py collectstatic --noinput

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myshop.wsgi:application"]
