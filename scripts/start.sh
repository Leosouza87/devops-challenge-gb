#!/bin/bash

# Script para inicializar a infraestrutura

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Inicializando a infraestrutura DevOps Challenge ===${NC}"

# Verificar se o Docker está instalado
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker não está instalado. Por favor, instale o Docker primeiro.${NC}"
    exit 1
fi

# Verificar se o Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Docker Compose não está instalado. Por favor, instale o Docker Compose primeiro.${NC}"
    exit 1
fi

# Ir para o diretório da infraestrutura
cd infrastructure || {
    echo -e "${RED}Diretório de infraestrutura não encontrado.${NC}"
    exit 1
}

# Iniciar os containers
echo -e "${YELLOW}Iniciando os containers...${NC}"
docker-compose up -d

# Verificar se todos os serviços estão rodando
echo -e "${YELLOW}Verificando o status dos serviços...${NC}"
sleep 5
if docker-compose ps | grep -q "Exit"; then
    echo -e "${RED}Alguns serviços não iniciaram corretamente. Verificando logs...${NC}"
    docker-compose logs
    exit 1
else
    echo -e "${GREEN}Todos os serviços estão rodando!${NC}"
fi

# Exibir informações de acesso
echo -e "${GREEN}=== Infraestrutura inicializada com sucesso! ===${NC}"
echo -e "URLs de acesso:"
echo -e "- App 1 (Python): ${GREEN}http://localhost:8080${NC} (Servidor: app1.local)"
echo -e "- App 2 (Node.js): ${GREEN}http://localhost:8080${NC} (Servidor: app2.local)"
echo -e "- Prometheus: ${GREEN}http://localhost:9090${NC}"
echo -e "- Grafana: ${GREEN}http://localhost:3000${NC} (Usuário: admin, Senha: admin)"
echo
echo -e "Para testar as APIs:"
echo -e "- App 1 texto: ${YELLOW}curl -H 'Host: app1.local' http://localhost:8080/texto${NC}"
echo -e "- App 1 horário: ${YELLOW}curl -H 'Host: app1.local' http://localhost:8080/horario${NC}"
echo -e "- App 2 texto: ${YELLOW}curl -H 'Host: app2.local' http://localhost:8080/texto${NC}"
echo -e "- App 2 horário: ${YELLOW}curl -H 'Host: app2.local' http://localhost:8080/horario${NC}"
echo
echo -e "Para parar a infraestrutura: ${YELLOW}./stop.sh${NC}"

exit 0