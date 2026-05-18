---
categories: ~
dependencies: '*.md.es'
keywords: rebaja,csv,yaml
status: verificado=37873
title: API de Orion - Formato de documento de texto
---

## Formato de documento de texto (`markdown`, `YAML`, `CSV`)

{# lede #}Esta página documenta los campos Cabecera y los artefactos de datos resultantes{# lede #} producido por el [API de creación](build) al procesar dichos archivos de texto (como anexos de página) a través de su [`single_narrative`](https://www.sunstarsys.com/orion/api/build#-code-single_narrative-args-code-) vista.

[TOC]

### `Markdown`

#### Cabeceras

##### `title`

Título de documento obligatorio

##### `status`

Estado de documento obligatorio:

###### borrador

Estado por defecto.

###### verificado

Indica que el contenido ha sido validado por el autor.  Se realizará un rollback al estado borrador si el documento se modifica posteriormente sin revalidación.

###### archivado

Indica que el documento está finalizado e ignorable para trabajos futuros en la `Orion CMS`. No aparecerá en futuras listas de directorios fuera de su ubicación archivada.  La ubicación archivada realizará un seguimiento de futuras modificaciones de contenido.

##### `acl`

Opcional `SVN` controles de autorización de seguridad en este documento. Con compatibilidad de autocompletado y validación de grupo en la `Orion CMS` editor.

##### `dependencies`

Lista separada por comas opcional de `file globs` que se basa en la salida creada de este documento.

##### `keywords`

Opcional `SEO`-lista fácil de separar por comas de etiquetas aptas para búsqueda.

##### `categories`

Lista opcional separada por comas de categorías de clasificación que deben hacer referencia a este documento con enlace permanente.  Aditivo por naturaleza (eliminar categorías no hará que esas ex-categorías eliminen este documento).

#### Artefactos de datos

n/d

### `YAML`

#### Cabeceras

##### `title`

Consulte la sección de rebajas anterior.

##### `status`

Consulte la sección de rebajas anterior.

##### `acl`

Consulte la sección de rebajas anterior.

#### Artefactos de datos

##### `content`

`YAML::XS::Load` estructura de datos analizada

### `CSV`

#### Cabeceras

##### `title`

Consulte la sección de rebajas anterior.

##### `status`

Consulte la sección de rebajas anterior.

##### `acl`

Consulte la sección de rebajas anterior.

##### `headers`

Indica que este documento tiene un `CSV` línea de cabecera en la parte superior de su contenido.

##### `column_ids`

Lista separada por comas opcional de ID de columna para `PDL`

##### `datetime`

Opcional [`strptime(3)`](https://www.man7.org/linux/man-pages/man3/strptime.3.html) formato para `PDL` proceso

##### `type`

Opcional declarado `PDL` tipos de dato de columna

#### Artefactos de datos

##### `content`

`arrayref` de cualquiera de `arrayrefs` (no `csv` encabezados), o `hashrefs` (`csv` encabezados)

##### `csv`

[`Text::CSV` ](https://metacpan.org/pod/Text::CSV) objeto utilizado para producir

##### `pdl`

Completo [`PDL`](https://metacpan.org/pod/PDL) objeto generado por la configuración de cabecera

<!-- $Date$ $Author$ $Revision$ -->
