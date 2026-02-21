# Change Policy

> Referencia rápida de modos de cambio. Ver `docs/AI_PLAYBOOK.md` para reglas completas.

---

## Modos de Cambio

### BUGFIX

- Solo modificar el archivo donde reside el error.
- No se permiten cambios estructurales.
- No se permite optimización de código no relacionado.
- Explicar el impacto del cambio.
- Formato de rama: `bugfix/descripcion`
- Formato de commit: `[BUGFIX] descripcion`

### MINOR_FEATURE

- Extensión del comportamiento sin alterar lógica existente.
- No modificar contratos públicos (firmas de funciones, endpoints).
- Proponer tests para la nueva funcionalidad.
- Formato de rama: `feature/descripcion`
- Formato de commit: `[MINOR_FEATURE] descripcion`

### REFACTOR

- Solo permitido con declaración explícita y autorización del equipo.
- **Requiere completar `docs/REFACTOR_CHECKLIST.md` antes de iniciar.**
- Requiere validación con `scripts/validate-refactor.sh` antes del merge.
- Cobertura post-REFACTOR debe ser >= cobertura pre-REFACTOR.
- Cobertura nunca puede caer por debajo del 80%.
- Formato de rama: `refactor/descripcion`
- Formato de commit: `[REFACTOR] descripcion`

---

## Reglas Generales

- Cambios mínimos y explícitos.
- Preservar comportamiento existente.
- Incluir sugerencias de tests en toda intervención.
- Prohibido optimizar sin autorización.
- Nunca trabajar directamente sobre `main`.
- CI debe pasar en verde antes de merge.

---

## Validación Automática

| Mecanismo | Qué valida |
|---|---|
| `CLAUDE.md` | Contexto y restricciones para Claude Code |
| `.githooks/pre-commit` | Nombre de rama (`bugfix/`, `feature/`, `refactor/`) |
| `.githooks/commit-msg` | Formato de mensaje de commit |
| CI Python | Cobertura >= 80% (`--cov-fail-under=80`) |
| CI Node | Cobertura >= 80% (coverageThreshold en jest) |
| CI Frontend | Tests de React/Vue con cobertura |
| `scripts/validate-refactor.sh` | Cobertura antes de autorizar REFACTOR |
