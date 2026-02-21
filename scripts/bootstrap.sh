#!/bin/bash

# bootstrap.sh — AI Development Playbook
# Inicializa la estructura del proyecto y completa los documentos de gobernanza.
# Versión: 1.1.0

set -e

echo "==========================================="
echo "  AI Development Playbook Bootstrap v1.1.0"
echo "==========================================="
echo ""

mkdir -p src tests docs

# ----------------------------------------
# 1. BACKEND
# ----------------------------------------
echo "Seleccione el backend del proyecto:"
echo "  1) Node.js + Express"
echo "  2) Django (Python)"
echo "  3) FastAPI (Python)"
echo "  4) Solo API — sin framework definido aún"
echo ""
read -p "Opción [1-4]: " backend_choice

case "$backend_choice" in
    1)
        BACKEND_NAME="Node.js + Express"
        BACKEND_LANG="JavaScript"
        BACKEND_TEST="Jest"
        npm init -y
        npm install express
        mkdir -p src/controllers src/services src/routes
        ;;
    2)
        BACKEND_NAME="Django"
        BACKEND_LANG="Python"
        BACKEND_TEST="pytest"
        python3 -m venv venv
        source venv/bin/activate
        pip install django pytest pytest-cov
        django-admin startproject app .
        ;;
    3)
        BACKEND_NAME="FastAPI + Uvicorn"
        BACKEND_LANG="Python"
        BACKEND_TEST="pytest"
        python3 -m venv venv
        source venv/bin/activate
        pip install fastapi uvicorn pytest pytest-cov httpx
        ;;
    4)
        BACKEND_NAME="Sin definir"
        BACKEND_LANG="Sin definir"
        BACKEND_TEST="Sin definir"
        ;;
    *)
        echo "[ERROR] Opción inválida. Ejecutar de nuevo."
        exit 1
        ;;
esac

echo ""

# ----------------------------------------
# 2. FRONTEND
# ----------------------------------------
echo "Seleccione el frontend del proyecto:"
echo "  1) React + Vite"
echo "  2) Vue 3 + Vite"
echo "  3) Sin frontend — proyecto API-only"
echo ""
read -p "Opción [1-3]: " frontend_choice

case "$frontend_choice" in
    1)
        FRONTEND_NAME="React + Vite"
        FRONTEND_TEST="Vitest"
        if command -v npm &> /dev/null; then
            npm create vite@latest frontend -- --template react
            echo "[OK] Frontend React + Vite creado en ./frontend/"
        else
            echo "[WARN] npm no disponible. Crear manualmente: npm create vite@latest frontend -- --template react"
        fi
        ;;
    2)
        FRONTEND_NAME="Vue 3 + Vite"
        FRONTEND_TEST="Vitest"
        if command -v npm &> /dev/null; then
            npm create vite@latest frontend -- --template vue
            echo "[OK] Frontend Vue 3 + Vite creado en ./frontend/"
        else
            echo "[WARN] npm no disponible. Crear manualmente: npm create vite@latest frontend -- --template vue"
        fi
        ;;
    3)
        FRONTEND_NAME="Sin frontend — API-only"
        FRONTEND_TEST="N/A"
        ;;
    *)
        echo "[ERROR] Opción inválida. Ejecutar de nuevo."
        exit 1
        ;;
esac

echo ""

# ----------------------------------------
# 3. BASE DE DATOS
# ----------------------------------------
echo "Seleccione la base de datos:"
echo "  1) PostgreSQL"
echo "  2) MySQL"
echo "  3) SQLite"
echo "  4) MongoDB"
echo "  5) Sin base de datos definida aún"
echo ""
read -p "Opción [1-5]: " db_choice

case "$db_choice" in
    1) DB_NAME="PostgreSQL"; DB_ORM="SQLAlchemy (Python) / Sequelize (Node)" ;;
    2) DB_NAME="MySQL"; DB_ORM="SQLAlchemy (Python) / Sequelize (Node)" ;;
    3) DB_NAME="SQLite"; DB_ORM="SQLAlchemy (Python) / better-sqlite3 (Node)" ;;
    4) DB_NAME="MongoDB"; DB_ORM="MongoEngine (Python) / Mongoose (Node)" ;;
    5) DB_NAME="Sin definir"; DB_ORM="Sin definir" ;;
    *) echo "[ERROR] Opción inválida."; exit 1 ;;
esac

echo ""

# ----------------------------------------
# 4. PATRON ARQUITECTONICO
# ----------------------------------------
echo "Seleccione el patrón arquitectónico:"
echo "  1) MVC (Model-View-Controller)"
echo "  2) Clean Architecture"
echo "  3) Hexagonal (Ports & Adapters)"
echo ""
read -p "Opción [1-3]: " arch_choice

case "$arch_choice" in
    1)
        ARCH_PATTERN="MVC (Model-View-Controller)"
        ARCH_DESC="Separación en Models, Views/Controllers. La lógica de negocio vive en Models o Services. Los controladores orquestan, no procesan."
        ARCH_LAYERS="Presentación (Routes/Controllers) → Negocio (Services/Models) → Datos (Repositories/ORM)"
        ;;
    2)
        ARCH_PATTERN="Clean Architecture"
        ARCH_DESC="Capas concéntricas: Entities → Use Cases → Interface Adapters → Frameworks. Las dependencias apuntan hacia adentro. El dominio no conoce la infraestructura."
        ARCH_LAYERS="Entities (dominio puro) → Use Cases → Interface Adapters → Frameworks & Drivers"
        ;;
    3)
        ARCH_PATTERN="Hexagonal (Ports & Adapters)"
        ARCH_DESC="El núcleo de la aplicación se comunica con el exterior únicamente a través de puertos (interfaces). Los adaptadores implementan los puertos para cada tecnología concreta."
        ARCH_LAYERS="Core (dominio + puertos) → Adaptadores primarios (API, CLI) → Adaptadores secundarios (BD, servicios externos)"
        ;;
    *) echo "[ERROR] Opción inválida."; exit 1 ;;
esac

echo ""

# ----------------------------------------
# 5. COMPLETAR STACK_DECISIONS.md
# ----------------------------------------
PLAYBOOK_VERSION=$(cat VERSION 2>/dev/null || echo "1.1.0")

cat > docs/STACK_DECISIONS.md << EOF
# Stack Decisions

> Generado por bootstrap.sh — $(date '+%Y-%m-%d')
> Este archivo es la fuente de verdad del stack tecnológico del proyecto.
> La IA debe leerlo antes de generar cualquier código.

---

## Backend

- **Framework:** ${BACKEND_NAME}
- **Lenguaje:** ${BACKEND_LANG}
- **Testing:** ${BACKEND_TEST}

## Frontend

- **Framework:** ${FRONTEND_NAME}
- **Testing:** ${FRONTEND_TEST}

## Base de Datos

- **Motor:** ${DB_NAME}
- **ORM/ODM:** ${DB_ORM}

## Patrón Arquitectónico

- **Patrón:** ${ARCH_PATTERN}
- **Descripción:** ${ARCH_DESC}
- **Capas:** ${ARCH_LAYERS}

## Convenciones de Código

- Commits: \`[BUGFIX]\`, \`[MINOR_FEATURE]\`, \`[REFACTOR]\`
- Ramas: \`bugfix/\`, \`feature/\`, \`refactor/\`
- Cobertura mínima de tests: **80%**
- Revisión de diff obligatoria antes de merge

## Reglas para la IA

- No introducir tecnologías no listadas en este archivo.
- No cambiar el patrón arquitectónico sin actualizar este documento.
- No alterar contratos públicos sin declaración de modo REFACTOR.

---

*Playbook versión: ${PLAYBOOK_VERSION}*
EOF

echo "[OK] docs/STACK_DECISIONS.md completado."

# ----------------------------------------
# 6. COMPLETAR ARCHITECTURE.md
# ----------------------------------------
cat > docs/ARCHITECTURE.md << EOF
# Arquitectura del Sistema

> Generado por bootstrap.sh — $(date '+%Y-%m-%d')
> Completar las secciones marcadas con [COMPLETAR].

---

## 1. Descripción General

Sistema basado en **${ARCH_PATTERN}** con backend en **${BACKEND_NAME}** y base de datos **${DB_NAME}**.

**Propósito del sistema:**
[COMPLETAR — una o dos frases sobre qué hace el sistema]

---

## 2. Patrón Arquitectónico: ${ARCH_PATTERN}

${ARCH_DESC}

### Capas del sistema

\`\`\`
${ARCH_LAYERS}
\`\`\`

### Reglas de dependencia

- Las capas externas dependen de las internas. Nunca al revés.
- No saltar capas: un controlador no accede directamente a la base de datos.
- [COMPLETAR — reglas específicas del proyecto]

---

## 3. Separación de Capas

| Capa | Responsabilidad | Tecnología |
|---|---|---|
| [COMPLETAR] | [COMPLETAR] | ${BACKEND_NAME} |
| [COMPLETAR] | Persistencia | ${DB_NAME} |
| [COMPLETAR] | Presentación | ${FRONTEND_NAME} |

---

## 4. Flujo de Datos Principal

\`\`\`
[COMPLETAR — diagrama ASCII del flujo principal]
Ejemplo: Cliente → API (${BACKEND_NAME}) → Service → Repository → ${DB_NAME}
\`\`\`

---

## 5. Decisiones Técnicas Clave

| Decisión | Alternativa considerada | Razón de la elección |
|---|---|---|
| ${BACKEND_NAME} como backend | [COMPLETAR] | [COMPLETAR] |
| ${DB_NAME} como base de datos | [COMPLETAR] | [COMPLETAR] |
| ${ARCH_PATTERN} como patrón | [COMPLETAR] | [COMPLETAR] |

---

## 6. Restricciones Técnicas

- [COMPLETAR — limitaciones conocidas]
- [COMPLETAR — integraciones externas requeridas]
- [COMPLETAR — requisitos de rendimiento]

---

## 7. Diagrama de Componentes

\`\`\`
[COMPLETAR — diagrama ASCII o enlace a diagrama externo]
\`\`\`

---

*Este documento debe actualizarse ante cualquier cambio estructural.*
*Playbook versión: ${PLAYBOOK_VERSION}*
EOF

echo "[OK] docs/ARCHITECTURE.md completado."

# ----------------------------------------
# 7. COMPLETAR PRD.md
# ----------------------------------------
cat > docs/PRD.md << EOF
# Product Requirements Document (PRD)

> Generado por bootstrap.sh — $(date '+%Y-%m-%d')
> Completar las secciones marcadas con [COMPLETAR].

---

## 1. Objetivo del Proyecto

[COMPLETAR — ¿Qué problema resuelve este sistema? ¿Para quién?]

**Ejemplo:** "Plataforma de gestión de inventario para PYMES que permite rastrear stock en tiempo real."

---

## 2. Problema a Resolver

**Problema principal:**
[COMPLETAR]

**Indicadores de éxito (métricas):**
- [COMPLETAR — métrica 1]: [valor objetivo]
- [COMPLETAR — métrica 2]: [valor objetivo]

---

## 3. Usuarios objetivo

| Tipo de usuario | Necesidad principal | Frecuencia de uso |
|---|---|---|
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

---

## 4. Funcionalidades Principales

### MVP (obligatorias para v1.0)
- [ ] [COMPLETAR — funcionalidad 1]
- [ ] [COMPLETAR — funcionalidad 2]
- [ ] [COMPLETAR — funcionalidad 3]

### Post-MVP (futuras versiones)
- [ ] [COMPLETAR — funcionalidad futura 1]

---

## 5. Restricciones Técnicas

| Restricción | Detalle |
|---|---|
| Backend | ${BACKEND_NAME} |
| Frontend | ${FRONTEND_NAME} |
| Base de datos | ${DB_NAME} |
| Cobertura mínima de tests | 80% |
| [COMPLETAR] | [COMPLETAR] |

---

## 6. Riesgos

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| [COMPLETAR] | Alta/Media/Baja | Alto/Medio/Bajo | [COMPLETAR] |

---

## 7. Criterios de Aceptación

Para que una funcionalidad se considere completa:
- [ ] Tests unitarios escritos y pasando.
- [ ] Cobertura >= 80%.
- [ ] PR aprobado por al menos un revisor.
- [ ] CI/CD pasando en verde.
- [ ] Documentación actualizada.

---

*Este documento define el alcance funcional del proyecto.*
*Cambios de alcance deben actualizarse aquí antes de implementarse.*
*Playbook versión: ${PLAYBOOK_VERSION}*
EOF

echo "[OK] docs/PRD.md completado."

# ----------------------------------------
# 8. COMPLETAR AGENTS.md
# ----------------------------------------

# Construir bloque de comandos de test según stack
BUILD_COMMANDS_PYTHON=""
BUILD_COMMANDS_NODE=""
BUILD_COMMANDS_FRONTEND=""

if [ "$BACKEND_LANG" = "Python" ]; then
    BUILD_COMMANDS_PYTHON=$(cat << 'INNER'
### Backend Python
```bash
pip install -r requirements.txt
pytest --cov=src --cov-report=term-missing --cov-fail-under=80
```
INNER
)
fi

if [ "$BACKEND_LANG" = "JavaScript" ]; then
    BUILD_COMMANDS_NODE=$(cat << 'INNER'
### Backend Node.js
```bash
npm install
npm test -- --coverage
```
INNER
)
fi

if [ "$FRONTEND_NAME" != "Sin frontend — API-only" ]; then
    BUILD_COMMANDS_FRONTEND=$(cat << 'INNER'
### Frontend
```bash
cd frontend && npm install && npm run test -- --coverage
```
INNER
)
fi

cat > AGENTS.md << EOF
# AI Agent Instructions — AI Development Playbook

> Archivo compatible con el estándar **AGENTS.md** (agents.md).
> Leído automáticamente por: **Google Antigravity**, Google Gemini CLI, Cursor, Windsurf, Kilo Code, y otros agentes compatibles.
> Para Claude Code: ver \`CLAUDE.md\`.
> Para OpenAI Codex CLI: pasar este archivo como contexto inicial.

---

## Contexto del Proyecto

> Generado por bootstrap.sh — $(date '+%Y-%m-%d')

**Stack:** ${BACKEND_NAME} + ${FRONTEND_NAME} + ${DB_NAME}
**Arquitectura:** ${ARCH_PATTERN}

Stack tecnológico completo: \`docs/STACK_DECISIONS.md\`
Arquitectura del sistema: \`docs/ARCHITECTURE.md\`
Requisitos del producto: \`docs/PRD.md\`

**Leer esos archivos antes de generar cualquier código.**

---

## Comandos de Build y Test

${BUILD_COMMANDS_PYTHON}
${BUILD_COMMANDS_NODE}
${BUILD_COMMANDS_FRONTEND}

---

## Archivos de Contexto Obligatorios

Antes de generar cualquier código o sugerencia, leer en este orden:

1. \`docs/STACK_DECISIONS.md\` — stack tecnológico aprobado
2. \`docs/CHANGE_POLICY.md\` — modos de cambio permitidos
3. \`docs/ARCHITECTURE.md\` — estructura de capas del sistema
4. \`docs/AI_PLAYBOOK.md\` — reglas completas de operación

---

## Modos de Cambio (declaración obligatoria)

Toda intervención DEBE declarar su modo al inicio de la respuesta:

- **[BUGFIX]** — Solo el archivo afectado. Sin cambios estructurales. Sin optimización.
- **[MINOR_FEATURE]** — Extensión sin alterar lógica existente. Sin romper contratos públicos.
- **[REFACTOR]** — Solo con autorización explícita. Requiere \`docs/REFACTOR_CHECKLIST.md\` completado y aprobado antes de iniciar.

---

## Restricciones Absolutas

- NO reescribir archivos completos.
- NO introducir dependencias no declaradas en \`docs/STACK_DECISIONS.md\`.
- NO modificar tests existentes para que pasen (si fallan, reportar el fallo).
- NO trabajar sobre la rama \`main\` directamente.
- NO reducir cobertura de tests por debajo del 80%.
- NO cambiar firmas de funciones públicas sin declarar modo REFACTOR.
- Si el impacto es incierto: DETENER y explicar el riesgo antes de continuar.

---

## Convenciones de Rama y Commit

\`\`\`
Ramas:   bugfix/descripcion  |  feature/descripcion  |  refactor/descripcion
Commits: [BUGFIX] desc       |  [MINOR_FEATURE] desc  |  [REFACTOR] desc
\`\`\`

Los git hooks en \`.githooks/\` validan estas convenciones automáticamente.
Instalar con: \`./scripts/install-hooks.sh\`

---

## Arquitectura del Sistema

**Patrón:** ${ARCH_PATTERN}
**Capas:** ${ARCH_LAYERS}

Reglas de dependencia:
- Las capas externas dependen de las internas. Nunca al revés.
- No saltar capas directamente.
- Ver \`docs/ARCHITECTURE.md\` para reglas completas.

---

## Protocolo ante Incertidumbre

1. Detener la ejecución.
2. Explicar qué genera la incertidumbre.
3. Listar los riesgos identificados.
4. Solicitar confirmación explícita antes de continuar.

---

Reglas completas: \`docs/AI_PLAYBOOK.md\`
Playbook versión: ${PLAYBOOK_VERSION}
EOF

echo "[OK] AGENTS.md completado."

# ----------------------------------------
# 9. INSTALAR GIT HOOKS (opcional)
# ----------------------------------------
echo ""
read -p "¿Instalar git hooks del Playbook? (pre-commit, commit-msg) [s/N]: " install_hooks

if [ "$install_hooks" = "s" ] || [ "$install_hooks" = "S" ]; then
    if [ -f "scripts/install-hooks.sh" ]; then
        chmod +x scripts/install-hooks.sh
        ./scripts/install-hooks.sh
    else
        echo "[WARN] scripts/install-hooks.sh no encontrado. Instalar manualmente."
    fi
fi

# ----------------------------------------
# FIN
# ----------------------------------------
echo ""
echo "==========================================="
echo "  Bootstrap finalizado correctamente"
echo "==========================================="
echo ""
echo "Stack configurado:"
echo "  Backend:       ${BACKEND_NAME}"
echo "  Frontend:      ${FRONTEND_NAME}"
echo "  Base de datos: ${DB_NAME}"
echo "  Arquitectura:  ${ARCH_PATTERN}"
echo ""
echo "Documentos completados:"
echo "  - AGENTS.md              (Antigravity, Gemini, Cursor, Windsurf)"
echo "  - docs/STACK_DECISIONS.md"
echo "  - docs/ARCHITECTURE.md"
echo "  - docs/PRD.md"
echo ""
echo "Nota: CLAUDE.md ya está configurado para Claude Code."
echo ""
echo "Próximos pasos:"
echo "  1. Revisar y completar secciones [COMPLETAR] en docs/"
echo "  2. Leer: docs/AI_PLAYBOOK.md"
echo "  3. Si no instalaste hooks: ./scripts/install-hooks.sh"
echo ""
