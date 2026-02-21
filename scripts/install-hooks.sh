#!/bin/bash

# install-hooks.sh
# Instala los git hooks del AI Development Playbook en el repositorio local.
# Debe ejecutarse una vez por desarrollador al clonar el repositorio.

set -e

HOOKS_SOURCE=".githooks"
HOOKS_TARGET=".git/hooks"

echo "=== Instalando AI Development Playbook Git Hooks ==="
echo ""

# Verificar que existe el directorio de hooks fuente
if [ ! -d "$HOOKS_SOURCE" ]; then
    echo "[ERROR] Directorio '$HOOKS_SOURCE' no encontrado."
    echo "Ejecutar desde la raíz del repositorio."
    exit 1
fi

# Copiar e instalar cada hook
for hook_file in "$HOOKS_SOURCE"/*; do
    hook_name=$(basename "$hook_file")
    target_path="$HOOKS_TARGET/$hook_name"

    # Respaldar hook existente si hay uno
    if [ -f "$target_path" ]; then
        echo "[INFO] Respaldando hook existente: $hook_name -> $hook_name.bak"
        cp "$target_path" "${target_path}.bak"
    fi

    cp "$hook_file" "$target_path"
    chmod +x "$target_path"
    echo "[OK] Hook instalado: $hook_name"
done

echo ""
echo "=== Hooks instalados correctamente ==="
echo ""
echo "Hooks activos:"
for hook_file in "$HOOKS_SOURCE"/*; do
    echo "  - $(basename "$hook_file")"
done
echo ""
echo "Para desinstalar: rm .git/hooks/pre-commit .git/hooks/commit-msg"
