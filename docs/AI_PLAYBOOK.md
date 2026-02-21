# AI Development Playbook

## 1. Propósito

Este Playbook define las reglas obligatorias para el desarrollo asistido por Inteligencia Artificial dentro de este proyecto.

Su objetivo es:

- Minimizar regresiones.
- Evitar modificaciones no controladas.
- Preservar estabilidad funcional.
- Establecer gobernanza técnica.
- Garantizar trazabilidad de decisiones.

La IA no reemplaza la disciplina de ingeniería.
La IA opera dentro de reglas formales.

---

## 2. Principios Fundamentales

- Estabilidad sobre elegancia.
- Cambios mínimos y explícitos.
- Ninguna modificación sin delimitación de alcance.
- Tests como firewall obligatorio.
- Git como mecanismo estructural de control.
- Refactorización solo bajo autorización explícita.
- La IA nunca asume; si hay duda, debe detenerse.

---

## 3. Modos de Operación de la IA

Toda intervención debe declarar explícitamente el modo de cambio:

### 3.1 BUGFIX

- Solo se modifica el archivo donde se encuentra el error.
- No se permiten cambios estructurales.
- No se permite optimización.
- Debe explicarse el impacto.

### 3.2 MINOR_FEATURE

- Extensión del comportamiento.
- No se reescribe lógica existente.
- No se alteran contratos públicos.
- Deben proponerse tests nuevos.

### 3.3 REFACTOR

- Solo permitido si se declara explícitamente.
- Requiere completar `docs/REFACTOR_CHECKLIST.md` antes de iniciar.
- Requiere análisis de impacto previo.
- Debe justificarse técnicamente.
- Debe validarse cobertura antes y después con `scripts/validate-refactor.sh`.

---

## 4. Modo Mantenimiento Estricto

Cuando el proyecto está en soporte o mantenimiento, la IA debe:

- Modificar únicamente las líneas mínimas necesarias.
- No reescribir archivos completos.
- No cambiar formato ni estilo.
- Entregar modificaciones en formato diff.
- Explicar qué cambió.
- Explicar por qué cambió.
- Identificar qué podría romperse.
- Proponer escenarios de regresión.
- No se permiten mejoras estéticas.

---

## 5. Integración con STACK_DECISIONS.md

Antes de generar código, la IA debe:

1. Leer `docs/STACK_DECISIONS.md`.
2. Respetar el lenguaje y framework definidos.
3. Mantener patrones arquitectónicos establecidos.
4. No introducir tecnologías nuevas sin aprobación.

Ejemplos:

- Si el stack define MVC: no mezclar lógica de negocio en controladores.
- Si el stack define Clean Architecture: no romper separación de capas.
- Si el stack define React: no reescribir componentes completos sin necesidad.

---

## 6. Flujo Obligatorio de Cambios

Para cada modificación:

1. Crear rama específica (`bugfix/`, `feature/`, `refactor/`).
2. Declarar modo de cambio.
3. Ejecutar intervención de IA.
4. Revisar diff manualmente.
5. Ejecutar tests.
6. Validar funcionalmente.
7. Merge solo si CI pasa.
8. Nunca trabajar directamente sobre `main`.

---

## 7. Reglas de Seguridad

La IA debe detenerse si:

- El impacto afecta múltiples módulos.
- Se alteran contratos públicos.
- Cambian firmas de funciones.
- Se modifica estructura de base de datos.
- Existen dependencias indirectas no analizadas.

En estos casos debe:

- Explicar el riesgo.
- Solicitar confirmación antes de continuar.

---

## 8. Tests como Firewall

Este proyecto debe mantener:

- Tests unitarios.
- Tests de integración en rutas críticas.
- Validación automática en CI.
- Cobertura mínima obligatoria: **80% de líneas**.

Si la cobertura disminuye por debajo del 80%, el CI bloquea el merge.

Comandos de validación:

```bash
# Python
pytest --cov=src --cov-report=term-missing --cov-fail-under=80

# Node.js
npm test -- --coverage
```

---

## 9. Gobernanza y Versionado

El Playbook se versiona mediante el archivo `VERSION`.

Reglas:

- `MAJOR`: cambios estructurales en el framework.
- `MINOR`: mejoras en reglas o procesos.
- `PATCH`: ajustes menores.

Cada proyecto debe declarar explícitamente la versión del Playbook que utiliza.

---

## 10. Escalabilidad

Este Playbook puede evolucionar para incluir:

- Auditoría automática de diffs.
- Validación arquitectónica automática.
- Revisión de seguridad asistida por IA.
- Métricas de madurez AI.

La evolución debe ser controlada y versionada.

---

## 11. Principio Final

La IA acelera la ejecución.
La disciplina protege el sistema.

La estabilidad no es un efecto secundario.
Es una decisión de diseño.

---

## 12. Forzado Técnico — Archivos de Instrucciones por Agente

Este Playbook opera con múltiples agentes de IA a través de dos archivos de instrucciones:

| Archivo | Agente(s) | Mecanismo |
|---|---|---|
| `CLAUDE.md` | Claude Code | Leído automáticamente al iniciar cada sesión |
| `AGENTS.md` | Google Antigravity, Gemini CLI, Cursor, Windsurf, Kilo Code | Leído automáticamente (estándar agents.md) |

Ambos archivos contienen las mismas reglas operacionales y apuntan a `docs/AI_PLAYBOOK.md` como fuente de verdad.

Para OpenAI Codex CLI, pasar `AGENTS.md` como contexto explícito al iniciar.

`docs/AI_PLAYBOOK.md` es la fuente canónica. Los archivos de instrucciones son su proyección para cada agente.

---

## 13. Git Hooks — Validación Automática de Convenciones

Este proyecto incluye git hooks que validan automáticamente:

- **pre-commit:** El nombre de la rama sigue la convención (`bugfix/`, `feature/`, `refactor/`).
- **commit-msg:** El mensaje de commit sigue el formato (`[BUGFIX]`, `[MINOR_FEATURE]`, `[REFACTOR]`).

Instalación (obligatoria por desarrollador):

```bash
chmod +x scripts/install-hooks.sh
./scripts/install-hooks.sh
```

Los hooks residen en `.githooks/` (versionados en el repositorio) y se copian a `.git/hooks/` (activos localmente).

---

## 14. Checklist de REFACTOR

Toda operación en modo REFACTOR requiere completar `docs/REFACTOR_CHECKLIST.md` antes del merge.

El checklist incluye:

- Justificación técnica formal.
- Análisis de impacto por módulo.
- Métricas de cobertura antes y después.
- Plan de reversión.
- Aprobaciones de firmantes.
- Validación con `scripts/validate-refactor.sh`.

Un REFACTOR sin checklist completado no puede mergearse a `main`.
