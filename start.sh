#!/bin/sh
set -e

echo "Detectando sistema operacional..."

OS="$(uname -s)"

case "$OS" in
  Linux*)
    PLATFORM="linux"
    ;;
  Darwin*)
    PLATFORM="mac"
    ;;
  MINGW*|MSYS*|CYGWIN*)
    PLATFORM="windows"
    ;;
  *)
    echo "Sistema operacional não suportado: $OS"
    exit 1
    ;;
esac

echo "Sistema detectado: $PLATFORM"

# Verificações básicas
command -v docker >/dev/null 2>&1 || {
  echo "Docker não encontrado"
  exit 1
}

command -v docker compose >/dev/null 2>&1 || {
  echo "Docker Compose não encontrado"
  exit 1
}

# Verifica .env
if [ -f .env ]; then
  echo ".env já existe. Usando configuração atual."
else
  echo ".env não encontrado, gerando SECRET_KEY_BASE..."

  SECRET_KEY_BASE=$(docker compose run --rm --entrypoint "" web bundle exec rails secret)

  if [ -z "$SECRET_KEY_BASE" ]; then
    echo "Falha ao gerar SECRET_KEY_BASE"
    exit 1
  fi

  echo "SECRET_KEY_BASE=${SECRET_KEY_BASE}" > .env
  echo ".env criado com sucesso"
fi

echo "Subindo aplicação com Docker..."
docker compose up --build