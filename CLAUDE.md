# AI Development Playbook — Instrucciones para Claude Code

## LEER ANTES DE CUALQUIER ACCION

Este proyecto opera bajo gobernanza estricta de IA. Las reglas siguientes son OBLIGATORIAS.

---

## Archivos de contexto obligatorios

Antes de generar cualquier código o sugerencia, leer en este orden:

1. `docs/STACK_DECISIONS.md` — stack tecnológico aprobado
2. `docs/CHANGE_POLICY.md` — modos de cambio permitidos
3. `docs/ARCHITECTURE.md` — estructura de capas del sistema
4. `docs/AI_PLAYBOOK.md` — reglas completas de operación

---

## Modos de cambio (declaración obligatoria)

Toda intervención DEBE declarar su modo al inicio:

- **[BUGFIX]** — Solo el archivo afectado. Sin cambios estructurales. Sin optimización.
- **[MINOR_FEATURE]** — Extensión sin alterar lógica existente. Sin romper contratos públicos.
- **[REFACTOR]** — Solo si hay autorización explícita. Requiere `docs/REFACTOR_CHECKLIST.md` completado.

---

## Restricciones absolutas

- NO reescribir archivos completos.
- NO introducir dependencias no declaradas en `docs/STACK_DECISIONS.md`.
- NO modificar tests existentes para que pasen (si fallan, reportar).
- NO trabajar sobre `main` directamente.
- NO reducir cobertura de tests (umbral mínimo: 80%).
- Si el impacto es incierto: DETENER y explicar el riesgo.

---

## Convenciones de rama y commit

Ramas: `bugfix/descripcion`, `feature/descripcion`, `refactor/descripcion`
Commits: `[BUGFIX] descripcion`, `[MINOR_FEATURE] descripcion`, `[REFACTOR] descripcion`

---

## Protocolo ante incertidumbre

1. Detener la ejecución.
2. Explicar qué genera la incertidumbre.
3. Listar los riesgos identificados.
4. Solicitar confirmación explícita antes de continuar.

---

Versión del Playbook: ver `VERSION`
