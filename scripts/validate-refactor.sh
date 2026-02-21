#!/bin/bash

# validate-refactor.sh
# Valida que la cobertura de tests cumpla el umbral mínimo antes de un REFACTOR.
# Uso: ./scripts/validate-refactor.sh

set -e

THRESHOLD=80
PASS=true

echo "=== Validación REFACTOR ==="
echo "Umbral mínimo de cobertura: ${THRESHOLD}%"
echo ""

# --- Python ---
if [ -f "requirements.txt" ]; then
    echo "[Python] Ejecutando pytest con cobertura..."
    if ! pytest --cov=src --cov-fail-under="${THRESHOLD}" --cov-report=term-missing -q; then
        echo "[FALLO] Cobertura Python por debajo del ${THRESHOLD}%."
        PASS=false
    else
        echo "[OK] Cobertura Python >= ${THRESHOLD}%."
    fi
fi

# --- Node ---
if [ -f "package.json" ]; then
    echo "[Node] Ejecutando tests con cobertura..."
    if ! npm test -- --coverage --coverageThreshold='{"global":{"lines":80}}' --passWithNoTests; then
        echo "[FALLO] Cobertura Node por debajo del ${THRESHOLD}%."
        PASS=false
    else
        echo "[OK] Cobertura Node >= ${THRESHOLD}%."
    fi
fi

echo ""
if [ "$PASS" = true ]; then
    echo "=== RESULTADO: PASS — REFACTOR autorizado para merge ==="
    exit 0
else
    echo "=== RESULTADO: FALLO — REFACTOR BLOQUEADO ==="
    echo "Aumentar cobertura antes de continuar."
    exit 1
fi
