# Checklist de Validación REFACTOR

Este documento debe completarse y aprobarse ANTES de ejecutar cualquier refactorización.
Una refactorización sin este checklist completado NO está autorizada.

---

## 1. Identificación

| Campo | Valor |
|---|---|
| Fecha de solicitud | |
| Rama de trabajo | `refactor/` |
| Solicitante | |
| Módulo(s) afectado(s) | |
| Versión del Playbook | (ver `VERSION`) |

---

## 2. Justificación técnica (obligatorio)

Describe el problema técnico concreto que motiva la refactorización.
No se aceptan justificaciones estéticas o de preferencia.

```
[Completar aquí]
```

Tipo de problema:
- [ ] Deuda técnica medible (especificar métrica)
- [ ] Violación de separación de capas
- [ ] Rendimiento documentado (adjuntar benchmark)
- [ ] Seguridad (adjuntar CVE o análisis)
- [ ] Otro (justificar):

---

## 3. Análisis de impacto

### 3.1 Archivos modificados

| Archivo | Tipo de cambio | Contratos públicos afectados |
|---|---|---|
| | | |

### 3.2 Dependencias afectadas

| Módulo dependiente | Tipo de dependencia | Riesgo de rotura |
|---|---|---|
| | | |

### 3.3 Endpoints o interfaces públicas afectadas

- [ ] Ninguna
- [ ] Sí (listar):

---

## 4. Cobertura de tests

| Métrica | Antes del REFACTOR | Después del REFACTOR | Umbral mínimo |
|---|---|---|---|
| Cobertura líneas | % | % | 80% |
| Cobertura ramas | % | % | 70% |
| Tests pasando | / | / | 100% |

Comando de validación Python:
```bash
pytest --cov=src --cov-report=term-missing --cov-fail-under=80
```

Comando de validación Node:
```bash
npm test -- --coverage
```

La cobertura POST-REFACTOR debe ser >= cobertura PRE-REFACTOR.
Si disminuye, el REFACTOR está BLOQUEADO.

---

## 5. Plan de reversión

Describe cómo revertir si el REFACTOR genera regresiones en producción:

```
[Completar aquí]
```

- Rama de respaldo: `git tag pre-refactor/YYYY-MM-DD`
- Tiempo estimado de rollback:
- Responsable del rollback:

---

## 6. Aprobaciones requeridas

| Rol | Nombre | Aprobado | Fecha |
|---|---|---|---|
| Tech Lead / Desarrollador principal | | [ ] | |
| Revisor secundario (si existe) | | [ ] | |

**Regla:** Ambas aprobaciones son obligatorias antes de merge a `main`.

---

## 7. Validación automática

Ejecutar antes del merge:

```bash
chmod +x scripts/validate-refactor.sh
./scripts/validate-refactor.sh
```

El script valida cobertura >= 80% y falla el proceso si no se cumple.

---

## Estado del checklist

- [ ] Secciones 1-6 completadas
- [ ] `scripts/validate-refactor.sh` ejecutado con resultado PASS
- [ ] PR aprobado por todos los firmantes de sección 6
- [ ] Rama con prefijo `refactor/`
- [ ] Commit con prefijo `[REFACTOR]`
