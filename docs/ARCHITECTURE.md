# Arquitectura del Sistema

> Completar ejecutando `./scripts/bootstrap.sh`, o manualmente siguiendo esta plantilla.
> Las secciones marcadas con [COMPLETAR] son obligatorias antes de comenzar desarrollo.

---

## EJEMPLO DE REFERENCIA (MVC con Node.js + PostgreSQL)

El siguiente es un ejemplo completo. Reemplazar con la arquitectura real del proyecto.

**Descripción general:**
Sistema de gestión de tareas para equipos distribuidos. Backend REST API con Node.js + Express. Base de datos PostgreSQL. Frontend React (consumidor de la API).

**Patrón: MVC (Model-View-Controller)**
Separación en Models (lógica de dominio + acceso a datos), Controllers (orquestación de requests), Services (lógica de negocio compleja).

**Capas:**
```
Cliente (React) → HTTP → Router (Express) → Controller → Service → Model → PostgreSQL
```

**Reglas de dependencia del ejemplo:**
- Los Controllers no acceden directamente a la base de datos.
- Los Models no conocen el framework web.
- Los Services contienen la lógica de negocio reutilizable.

---

## 1. Descripción General

[COMPLETAR — descripción de alto nivel del sistema en 2-3 oraciones]

---

## 2. Patrón Arquitectónico

**Patrón:** [COMPLETAR]

**Descripción:** [COMPLETAR]

**Capas:**
```
[COMPLETAR — diagrama ASCII de capas]
```

**Reglas de dependencia:**
- [COMPLETAR — quién depende de quién]
- [COMPLETAR — qué capas NO pueden comunicarse directamente]

---

## 3. Separación de Capas

| Capa | Responsabilidad | Tecnología |
|---|---|---|
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | Persistencia | [COMPLETAR] |
| [COMPLETAR] | Presentación | [COMPLETAR] |

---

## 4. Flujo de Datos Principal

```
[COMPLETAR — flujo del request desde el cliente hasta la base de datos y de vuelta]
```

---

## 5. Decisiones Técnicas Clave

| Decisión | Alternativa considerada | Razón |
|---|---|---|
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |
| [COMPLETAR] | [COMPLETAR] | [COMPLETAR] |

---

## 6. Restricciones Técnicas

- [COMPLETAR — limitaciones conocidas]
- [COMPLETAR — integraciones externas requeridas]
- [COMPLETAR — requisitos de rendimiento o disponibilidad]

---

## 7. Diagrama de Componentes

```
[COMPLETAR — diagrama ASCII o enlace a diagrama externo (Miro, Lucidchart, etc.)]
```

---

*Este documento debe actualizarse ante cualquier cambio estructural.*
*Ver `docs/STACK_DECISIONS.md` para decisiones de stack.*
*Playbook versión: ver `VERSION`*
