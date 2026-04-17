---
archived: ~
categories: ~
dependencies: '*.md.es '
keywords: RESTO,API
published: ~
status: borrador
title: API de Orion - Buscar
---

{# lede #}En este documento se tratan las API de **búsqueda**{# lede #}

[TOC]

----

## Dynamic Search (/dynamic/search/...).

### Argumentos de cadena de consulta

#### idioma

- [`.en`](#)
- [`.es`](#)
- [`.fr`](#)
- [`.de`](#).

#### markdown_search

booleano (0 o 1).

#### expresión regular

##### modos especiales

###### all accounts

- [`amigos=`](#)
- [`reloj=`](#)
- [`notificar=$revisión`](#)
- [`igual=`](#) (WIP)
- [`diff=$revisión`](#)
- [`log=$revisión`](#)
- [`@$group=`](#)
- [`$user=`](#).

###### svnadmin group

- [`compilación=`](#)
- [`acl=`](#)
- [`deps=`](#)
- [`svnauthz=`](#).

##### modos de compatibilidad

- cadena entre comillas


Modo de PCRE #####

### iteración de filtro

- [`filtro`](#).

Filtro de PCRE iterado con estado en archivos coincidentes.

### Campos de respuesta JSON genéricos

- [`ruta`](#)
- [`título`](#)
- [`markdown_search`](#)
- [`coincidencias`](#)
- [`lang`](#)
- [`expresión regular`](#)
- [`rutas de navegación`](#)
- [`palabras clave`](#)
- [`amigos`](#)
- [`reloj`](#)
- [`gráfico`](#)
- [`duración`](#)
- [`registro`](#)
- [`blog`](#)
- [`diferencia`](#)
- [`meta`](#)
- [`registro`](#)
- [`Yaml`](#)
- [`repositorios`](#)
- [`sitio web`](#)
- [`hash`](#)
- [`filtro`](#)
- [`especiales`](#).

<!-- $Date$ $Author$ $Revision$ -->
