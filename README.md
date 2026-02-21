# AI Development Playbook Template

Repositorio base para desarrollo asistido por IA con control estricto de estabilidad.

## Objetivo

Proveer un framework reproducible que:

- Minimice regresiones.
- Controle el alcance de los cambios.
- Imponga disciplina de mantenimiento incremental.
- Integre validación automática vía CI/CD.
- Sea adaptable a cualquier stack tecnológico.

---

## Estructura del Proyecto
/docs

AI_PLAYBOOK.md
CHANGE_POLICY.md
STACK_DECISIONS.md
PRD.md
ARCHITECTURE.md

/scripts
bootstrap.sh

.github/workflows
ci.yml

---

## Flujo Obligatorio

1. Crear rama por cambio.
2. Declarar modo de cambio (BUGFIX / MINOR_FEATURE / REFACTOR).
3. Usar IA en modo mantenimiento estricto.
4. Revisar diff manualmente.
5. Ejecutar tests.
6. Merge solo si CI pasa.

---

## Inicialización

```bash
chmod +x scripts/bootstrap.sh
./scripts/bootstrap.sh

Versionado

Este proyecto utiliza versionado semántico definido en el archivo VERSION.

MAJOR.MINOR.PATCH

Principio

La IA acelera.
La disciplina protege.


---

# 📄 VERSION
1.0.0

---

# 📄 docs/AI_PLAYBOOK.md

```markdown
# AI Development Playbook

## 1. Principios Fundamentales

1. Estabilidad > Elegancia.
2. Cambios mínimos y explícitos.
3. Sin refactorización no autorizada.
4. Tests como firewall obligatorio.
5. Git como mecanismo de control.

---

## 2. Modo Mantenimiento Estricto

La IA debe:

- Modificar solo líneas necesarias.
- No reescribir archivos completos.
- Entregar cambios en formato diff.
- Explicar impacto.
- Proponer escenarios de regresión.

---

## 3. Stack-Agnostic

Antes de modificar código, la IA debe:

1. Leer STACK_DECISIONS.md.
2. Respetar patrones del stack.
3. No romper separación de capas.
4. Mantener contratos públicos.

---

## 4. Flujo de Cambio

1. Crear rama.
2. Declarar modo.
3. Generar diff.
4. Ejecutar tests.
5. Merge validado.

---

## 5. Regla de Escalamiento

Si hay incertidumbre:
- Detener ejecución.
- Explicar riesgos.
- Solicitar aclaración.
