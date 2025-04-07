// app.js
const express = require('express');
const promClient = require('prom-client');
const app = express();
const port = process.env.PORT || 3000;

// Criação do registro de métricas
const register = new promClient.Registry();
promClient.collectDefaultMetrics({ register });

// Métricas personalizadas
const httpRequestCounter = new promClient.Counter({
  name: 'app_request_count',
  help: 'Application Request Count',
  labelNames: ['app_name', 'method', 'endpoint', 'http_status'],
  registers: [register]
});

const httpRequestDuration = new promClient.Histogram({
  name: 'app_request_latency_seconds',
  help: 'Application Request Latency',
  labelNames: ['app_name', 'method', 'endpoint'],
  registers: [register]
});

// Endpoint para métricas
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

// Middleware para medir tempo de resposta
app.use((req, res, next) => {
  const end = httpRequestDuration.startTimer();
  res.on('finish', () => {
    end({
      app_name: 'app2',
      method: req.method,
      endpoint: req.path
    });
    httpRequestCounter.inc({
      app_name: 'app2',
      method: req.method,
      endpoint: req.path,
      http_status: res.statusCode
    });
  });
  next();
});

// Rota de texto fixo
app.get('/texto', (req, res) => {
  res.json({ message: 'Olá do serviço Node.js (App 2)' });
});

// Rota de horário
app.get('/horario', (req, res) => {
  const now = new Date();
  res.json({
    horario: now.toISOString().replace('T', ' ').substr(0, 19),
    timezone: Intl.DateTimeFormat().resolvedOptions().timeZone
  });
});

app.listen(port, () => {
  console.log(`App 2 rodando na porta ${port}`);
});