---
archived: ~
categories: ~
dependencies: '*.md.es '
keywords: RESTO,API
published: ~
status: borrador
title: API de Orion - Editor en línea
---

{# lede #}En este documento se tratan las API y la interfaz de usuario del **editor en línea**{# lede #}

[TOC]

----

## Editor de Orión (cms.sunstarsys.com).

### Acciones genéricas

#### redireccionamiento

Punto final de entrada para la interfaz de CMS de Orion.

Argumentos de cadena de consulta obligatorios:

- [`uri`](#).

Argumentos de cadena de consulta opcionales:

- [`actualizar`](#) - establecido en 0 para desactivar la actualización de la copia de trabajo
- [`acción`](#) - elección de la acción de redirección
- [`lang`](#) - idioma preferido para IU
- [`repositorios`](#) - nombre de repositorio de Subversion de destino
- [`nuevo`](#) - crear una nueva copia de trabajo
- [`expresión regular`](#).

#### conexión

Valida y almacena en caché las credenciales de subversión para el repositorio actual. Sólo responde al método POST.

### Acciones de copia de trabajo

#### Campos de respuesta JSON de copia de trabajo

- [`repositorios`](#)
- [`sitio web`](#)
- [`acción`](#)
- [`lang`](#)
- [`rutas de navegación`](#)
- [`modo`](#)
- [`is_dir`](#)
- [`is_root_dir`](#)
- [`dir`](#)
- [`ext`](#)
- [`attachments_dir`](#)
- [`is_attachment`](#)
- [`estado`](#)
- [`sucursal`](#)
- [`imagen`](#)
- [`cabeceras`](#)
- [`contenido`](#)
- [`http_status`](#)
- [`nav_options`](#)
- [`actions_lang`](#)
- [`observando`](#).

#### Lista de acciones de API

##### editar

###### Friends Completion

##### actualización

##### revertir

##### copia

##### movimiento

##### suprimir

##### agregar

###### Friends Completion

##### confirmación

##### diferencias

##### combinación

##### producción

##### promocionar

##### resolver

##### rollback

##### búsqueda

##### estático

##### cuenta

###### Credentials Changes

##### comentario

###### Friends Completion

##### observación

##### no coincidente

##### como

##### a diferencia

<!-- $Date: 2024-04-14 02:02:48 +0000 (Sun, 14 Apr 2024) $ $Author: joe $ $Revision: 22286 $ -->
