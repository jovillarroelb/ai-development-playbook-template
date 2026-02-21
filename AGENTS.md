# AI Agent Instructions — AI Development Playbook

> Archivo compatible con el estándar **AGENTS.md** (agents.md).
> Leído automáticamente por: **Google Antigravity**, Google Gemini CLI, Cursor, Windsurf, Kilo Code, y otros agentes compatibles.
> Para Claude Code: ver `CLAUDE.md`.
> Para OpenAI Codex CLI: pasar este archivo como contexto inicial.

---

## Contexto del Proyecto

Stack tecnológico completo: `docs/STACK_DECISIONS.md`
Arquitectura del sistema: `docs/ARCHITECTURE.md`
Requisitos del producto: `docs/PRD.md`

**Leer esos archivos antes de generar cualquier código.**

---

## Comandos de Build y Test

### Backend Python (Django / FastAPI)
```bash
# Instalar dependencias
pip install -r requirements.txt

# Ejecutar tests con cobertura (umbral mínimo: 80%)
pytest --cov=src --cov-report=term-missing --cov-fail-under=80
```

### Backend Node.js (Express)
```bash
# Instalar dependencias
npm install

# Ejecutar tests con cobertura (umbral mínimo: 80%)
npm test -- --coverage
```

### Frontend (React / Vue con Vite)
```bash
cd frontend
npm install
npm run test -- --coverage
```

---

## Archivos de Contexto Obligatorios

Antes de generar cualquier código o sugerencia, leer en este orden:

1. `docs/STACK_DECISIONS.md` — stack tecnológico aprobado
2. `docs/CHANGE_POLICY.md` — modos de cambio permitidos
3. `docs/ARCHITECTURE.md` — estructura de capas del sistema
4. `docs/AI_PLAYBOOK.md` — reglas completas de operación

---

## Modos de Cambio (declaración obligatoria)

Toda intervención DEBE declarar su modo al inicio de la respuesta:

- **[BUGFIX]** — Solo el archivo afectado. Sin cambios estructurales. Sin optimización.
- **[MINOR_FEATURE]** — Extensión sin alterar lógica existente. Sin romper contratos públicos.
- **[REFACTOR]** — Solo con autorización explícita. Requiere `docs/REFACTOR_CHECKLIST.md` completado y aprobado antes de iniciar.

---

## Restricciones Absolutas

- NO reescribir archivos completos.
- NO introducir dependencias no declaradas en `docs/STACK_DECISIONS.md`.
- NO modificar tests existentes para que pasen (si fallan, reportar el fallo).
- NO trabajar sobre la rama `main` directamente.
- NO reducir cobertura de tests por debajo del 80%.
- NO cambiar firmas de funciones públicas sin declarar modo REFACTOR.
- Si el impacto es incierto: DETENER y explicar el riesgo antes de continuar.

---

## Convenciones de Rama y Commit

```
Ramas:   bugfix/descripcion  |  feature/descripcion  |  refactor/descripcion
Commits: [BUGFIX] desc       |  [MINOR_FEATURE] desc  |  [REFACTOR] desc
```

Los git hooks en `.githooks/` validan estas convenciones automáticamente.
Instalar con: `./scripts/install-hooks.sh`

---

## Arquitectura del Sistema

Patrón y capas: ver `docs/ARCHITECTURE.md`

Reglas de dependencia obligatorias:
- Las capas externas dependen de las internas. Nunca al revés.
- No saltar capas (un controlador no accede directamente a la base de datos).
- No romper la separación de responsabilidades definida en `docs/ARCHITECTURE.md`.

---

## Protocolo ante Incertidumbre

Si hay ambigüedad en el alcance, el impacto afecta múltiples módulos, o los contratos públicos podrían verse afectados:

1. Detener la ejecución.
2. Explicar qué genera la incertidumbre.
3. Listar los riesgos identificados.
4. Solicitar confirmación explícita antes de continuar.

---

Reglas completas: `docs/AI_PLAYBOOK.md`
Versión del Playbook: ver `VERSION`
