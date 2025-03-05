FROM python:3.10-alpine as builder

RUN apk add --no-cache gcc musl-dev python3-dev

WORKDIR /app

COPY requirements.txt .

RUN python -m venv /venv && /venv/bin/pip install --no-cache-dir -r requirements.txt

FROM python:3.10-alpine

COPY --from=builder /venv /venv

COPY . /app

WORKDIR /app

ENV PATH="/venv/bin:$PATH"

CMD ["python", "main.py"]
