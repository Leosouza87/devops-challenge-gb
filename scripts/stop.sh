#!/bin/bash

# Script para parar a infraestrutura

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Parando a infraestrutura DevOps Challenge ===${NC}"

# Ir para o diretório da infraestrutura
cd infrastructure || {
    echo -e "${RED}Diretório de infraestrutura não encontrado.${NC}"
    exit 1
}

# Parar os containers
echo -e "${YELLOW}Parando os containers...${NC}"
docker-compose down

echo -e "${GREEN}Infraestrutura parada com sucesso!${NC}"

exit 0