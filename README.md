# DevOps Challenge globo

Este projeto implementa uma infraestrutura DevOps com duas aplicações em linguagens diferentes (Python e Node.js), camada de cache com NGINX, e observabilidade com Prometheus e Grafana.

## Estrutura do Projeto

```
/devops-challenge/
├── apps/
│   ├── app1-python/         # Aplicação Python com Flask
│   │   ├── app.py
│   │   ├── requirements.txt
│   │   └── Dockerfile
│   └── app2-node/           # Aplicação Node.js com Express
│       ├── app.js
│       ├── package.json
│       └── Dockerfile
├── infrastructure/
│   ├── docker-compose.yml   # Orquestração de contêineres
│   ├── nginx/               # Configuração do NGINX
│   │   └── nginx.conf
│   ├── nginx-exporter/      # Exporter do NGINX para Prometheus
│   │   └── Dockerfile
│   └── prometheus/          # Configuração do Prometheus
│       └── prometheus.yml
├── scripts/
│   ├── start.sh            # Script de inicialização
│   └── stop.sh             # Script de parada
├── docs/
│   └── diagrams/           # Diagramas da arquitetura
└── README.md
```

## Requisitos

- Docker
- Docker Compose

## Como Executar

### Iniciar a infraestrutura

```bash
chmod +x scripts/start.sh
./scripts/start.sh
```

### Parar a infraestrutura

```bash
chmod +x scripts/stop.sh
./scripts/stop.sh
```

## Endpoints das Aplicações

### App 1 (Python - Flask)

- **Texto Fixo**: `http://localhost:8080/texto` (Host: app1.local)
- **Horário**: `http://localhost:8080/horario` (Host: app1.local)
- **Métricas**: `http://localhost:8080/metrics` (Host: app1.local)

### App 2 (Node.js - Express)

- **Texto Fixo**: `http://localhost:8080/texto` (Host: app2.local)
- **Horário**: `http://localhost:8080/horario` (Host: app2.local)
- **Métricas**: `http://localhost:8080/metrics` (Host: app2.local)

## Acesso às Ferramentas

- **NGINX**: http://localhost:8080
- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3000 (usuário: admin, senha: admin)

## Cache

- A aplicação Python (App 1) tem cache de 10 segundos
- A aplicação Node.js (App 2) tem cache de 60 segundos

## Observabilidade

Este projeto implementa observabilidade através do Prometheus e Grafana:

1. **Métricas de aplicação**: Cada aplicação expõe métricas em `/metrics`
2. **Métricas do sistema**: Coletadas pelo Node Exporter
3. **Métricas do NGINX**: Coletadas pelo NGINX Exporter

## Detalhes da Implementação

### Aplicações

- **App 1**: Python com Flask, expondo métricas via Prometheus Client
- **App 2**: Node.js com Express, expondo métricas via prom-client

### Cache

O NGINX está configurado como proxy reverso e camada de cache:
- Cache para App 1: 10 segundos
- Cache para App 2: 1 minuto

### Observabilidade

- **Prometheus**: Coleta e armazena métricas
- **Node Exporter**: Coleta métricas do sistema host
- **NGINX Exporter**: Coleta métricas do NGINX
- **Grafana**: Visualização de dashboards