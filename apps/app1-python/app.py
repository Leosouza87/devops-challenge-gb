# app.py
from flask import Flask, jsonify
import time
import datetime
import prometheus_client
from prometheus_client import Counter, Histogram
import os

app = Flask(__name__)

# Métricas para observabilidade
REQUEST_COUNT = Counter(
    'app_request_count', 
    'Application Request Count',
    ['app_name', 'method', 'endpoint', 'http_status']
)
REQUEST_LATENCY = Histogram(
    'app_request_latency_seconds', 
    'Application Request Latency',
    ['app_name', 'method', 'endpoint']
)

@app.route('/metrics')
def metrics():
    return prometheus_client.generate_latest()

@app.route('/texto')
def texto():
    start_time = time.time()
    
    # Lógica da rota
    response = {"message": "Olá do serviço Python (App 1)"}
    
    # Registrar métricas
    REQUEST_COUNT.labels('app1', 'GET', '/texto', 200).inc()
    REQUEST_LATENCY.labels('app1', 'GET', '/texto').observe(time.time() - start_time)
    
    return jsonify(response)

@app.route('/horario')
def horario():
    start_time = time.time()
    
    # Lógica da rota
    now = datetime.datetime.now()
    response = {
        "horario": now.strftime("%Y-%m-%d %H:%M:%S"),
        "timezone": str(datetime.datetime.now().astimezone().tzinfo)
    }
    
    # Registrar métricas
    REQUEST_COUNT.labels('app1', 'GET', '/horario', 200).inc()
    REQUEST_LATENCY.labels('app1', 'GET', '/horario').observe(time.time() - start_time)
    
    return jsonify(response)

if __name__ == '__main__':
    # Expor métricas via porta 8000 no endpoint /metrics
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 5000)))