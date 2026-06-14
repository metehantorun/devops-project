# --- 1. Aşama: Build/Derleme Aşaması ---
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt


FROM python:3.11-slim AS runner

WORKDIR /app

RUN useradd -u 10001 appuser && chown -R appuser:appuser /app

COPY --from=builder /root/.local /home/appuser/.local
COPY app.py .

ENV PATH=/home/appuser/.local/bin:$PATH

USER appuser

EXPOSE 5000

CMD ["python", "app.py"]