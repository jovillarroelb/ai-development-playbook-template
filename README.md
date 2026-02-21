# AI Development Playbook Template
### Plantilla de Gobernanza para Desarrollo Asistido por IA

> Framework reproducible para desarrollo con IA disciplinado, trazable y estable.

---

## Objetivo

Proveer un framework técnico que:

- Minimice regresiones mediante reglas formales aplicadas técnicamente.
- Controle el alcance de los cambios con modos de operación declarados.
- Imponga disciplina de mantenimiento incremental.
- Integre validación automática vía CI/CD con umbrales de cobertura.
- Sea adaptable a cualquier stack tecnológico.

**La IA acelera la ejecución. La disciplina protege el sistema.**

---

## Estructura del Proyecto

```
.
├── CLAUDE.md                          ← Instrucciones para Claude Code
├── AGENTS.md                          ← Instrucciones para Antigravity, Gemini, Cursor, Windsurf
├── VERSION                            ← Versión del Playbook
├── README.md                          ← Este archivo
├── .githooks/
│   ├── pre-commit                     ← Valida nombre de rama
│   └── commit-msg                     ← Valida formato de commit
├── .github/workflows/
│   └── ci.yml                         ← CI con umbrales de cobertura (80%)
├── docs/
│   ├── AI_PLAYBOOK.md                 ← Reglas completas de operación (fuente de verdad)
│   ├── CHANGE_POLICY.md               ← Modos de cambio (BUGFIX/MINOR_FEATURE/REFACTOR)
│   ├── STACK_DECISIONS.md             ← Stack tecnológico aprobado
│   ├── ARCHITECTURE.md                ← Arquitectura del sistema
│   ├── PRD.md                         ← Requisitos del producto
│   └── REFACTOR_CHECKLIST.md          ← Checklist obligatorio para REFACTOR
└── scripts/
    ├── bootstrap.sh                   ← Inicialización interactiva del proyecto
    ├── install-hooks.sh               ← Instalador de git hooks
    └── validate-refactor.sh           ← Validador de cobertura pre-REFACTOR
```

---

## Inicio Rápido

### 1. Clonar y bootstrapear

```bash
git clone <url-del-repositorio>
cd <nombre-del-proyecto>
chmod +x scripts/bootstrap.sh
./scripts/bootstrap.sh
```

El script interactivo configurará:

- **Backend:** Node.js+Express / Django / FastAPI / Sin definir
- **Frontend:** React+Vite / Vue3+Vite / API-only
- **Base de datos:** PostgreSQL / MySQL / SQLite / MongoDB
- **Patrón arquitectónico:** MVC / Clean Architecture / Hexagonal

Y completará automáticamente: `docs/STACK_DECISIONS.md`, `docs/ARCHITECTURE.md`, `docs/PRD.md`.

### 2. Instalar git hooks

```bash
chmod +x scripts/install-hooks.sh
./scripts/install-hooks.sh
```

Los hooks validan automáticamente nombres de rama y formato de commits en cada `git commit`.

### 3. Revisar los documentos de gobernanza

```bash
cat docs/STACK_DECISIONS.md
cat docs/AI_PLAYBOOK.md
```

---

## Flujo Obligatorio de Cambios

1. Crear rama con prefijo correcto: `git checkout -b bugfix/nombre`
2. Declarar modo al inicio de la sesión con IA: `[BUGFIX]`, `[MINOR_FEATURE]`, o `[REFACTOR]`
3. Ejecutar intervención de IA (el agente leerá `CLAUDE.md` o `AGENTS.md` automáticamente según el LLM).
4. Revisar el diff manualmente.
5. Ejecutar tests localmente.
6. Commit con formato correcto: `git commit -m "[BUGFIX] descripcion"`
7. Merge solo si CI pasa en verde.

**Nunca trabajar directamente sobre `main`.**

---

## Convenciones

| Elemento | Formato |
|---|---|
| Ramas | `bugfix/descripcion`, `feature/descripcion`, `refactor/descripcion` |
| Commits | `[BUGFIX] desc`, `[MINOR_FEATURE] desc`, `[REFACTOR] desc` |
| Cobertura mínima | 80% de líneas |
| Merge a main | Solo con CI en verde |

---

## Agentes de IA Soportados

Este framework es compatible con múltiples LLMs como agentes de coding:

| Agente | Archivo de instrucciones | Estado |
|---|---|---|
| **Claude Code** | `CLAUDE.md` | Soportado — preferido |
| **Google Antigravity** | `AGENTS.md` | Soportado |
| **Google Gemini CLI** | `AGENTS.md` | Soportado |
| **Cursor** | `AGENTS.md` | Soportado |
| **Windsurf** | `AGENTS.md` | Soportado |
| **OpenAI Codex CLI** | `AGENTS.md` + contexto manual | Soportado parcialmente |
| Otros (Kilo Code, etc.) | `AGENTS.md` | Compatible |

**Jerarquía de archivos de instrucciones:**

```
docs/AI_PLAYBOOK.md   ← Fuente de verdad (reglas canónicas)
       ↓
CLAUDE.md             ← Claude Code lo lee automáticamente al inicio
AGENTS.md             ← Antigravity, Gemini, Cursor, Windsurf lo leen automáticamente
```

No eliminar ni vaciar ninguno de los dos archivos de instrucciones.

---

## OpenAI Codex CLI — Configuración Manual

Codex CLI no lee archivos de instrucciones automáticamente desde el proyecto. Pasar el contexto explícitamente:

```bash
cat AGENTS.md | codex -
# o
codex --context AGENTS.md "descripcion de la tarea"
```

---

## Modo REFACTOR

Las refactorizaciones requieren un proceso formal antes del merge:

1. Completar `docs/REFACTOR_CHECKLIST.md`
2. Ejecutar `./scripts/validate-refactor.sh` (valida cobertura >= 80%)
3. Obtener aprobaciones según sección 6 del checklist

---

## CI/CD

El pipeline (`.github/workflows/ci.yml`) ejecuta 3 jobs independientes:

| Job | Trigger | Umbral |
|---|---|---|
| `python-tests` | `requirements.txt` presente | 80% cobertura |
| `node-tests` | `package.json` presente | 80% cobertura |
| `frontend-tests` | `frontend/package.json` presente | cobertura activa |

---

## Versionado

Versionado semántico definido en `VERSION`:

- `MAJOR`: Cambios estructurales en el framework de gobernanza.
- `MINOR`: Nuevas reglas, procesos o herramientas.
- `PATCH`: Ajustes menores y correcciones.

Versión actual: `1.2.0`
