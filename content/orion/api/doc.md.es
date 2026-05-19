---
categories: ~
dependencies: '*.md.es'
keywords: rebaja,csv,yaml
status: verificado=38102
title: API de Orion - Formato de documento de texto
---

## Formato de documento de texto (`markdown`, `YAML`, `CSV`)

{# lede #}Esta página documenta los campos Cabecera y los artefactos de datos resultantes{# lede #} producido por el [API de creación](build) al procesar dichos archivos de texto (como anexos de página) a través de su [`single_narrative`](build#-code-single_narrative-args-code-) vista.

[TOC]

### `Markdown`

#### Cabeceras

<div class="card border-primary mb-3">
  <div class="card-header">

##### `title`

</div>
  <div class="card-body">
    <div class="card-title">

Título obligatorio del documento.

</div>

<p class="card-text">

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `status`

</div>
  <div class="card-body">
    <div class="card-title">

Estado de documento de texto libre obligatorio.

</div>

<p class="card-text">

A continuación se explican tres de estas etiquetas de estado especiales:

###### borrador

Estado por defecto.

-----

###### verificado

Indica que el contenido ha sido validado por el autor.  Se realizará un rollback al estado borrador si el documento se modifica posteriormente sin revalidación.

-----

###### archivado

Indica que el documento está finalizado e ignorable para trabajos futuros en la `Orion CMS`. No aparecerá en futuras listas de directorios fuera de su ubicación archivada.  La ubicación archivada realizará un seguimiento de futuras modificaciones de contenido.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `acl`

</div>
  <div class="card-body">
    <div class="card-title">

Opcional `SVN` controles de autorización de seguridad en este documento. Con compatibilidad de autocompletado y validación de grupo en la `Orion CMS` editor.

</div>
<p class="card-text"></p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `dependencies`

</div>
  <div class="card-body">
    <div class="card-title">

Lista separada por comas opcional de `file globs` que se basa en la salida creada de este documento.

</div>
<p class="card-text"></p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `keywords`

</div>
  <div class="card-body">
    <div class="card-title">
Opcional `SEO`-lista fácil de separar por comas de etiquetas aptas para búsqueda.

</div>
<p class="card-text"></p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `categories`

</div>
  <div class="card-body">
    <div class="card-title">

Lista opcional separada por comas de categorías de clasificación que deben hacer referencia a este documento con enlace permanente.

</div>
<p class="card-text">

Aditivo por naturaleza (eliminar categorías no hará que esas ex-categorías eliminen este documento).

</p>
</div>
</div>

#### Artefactos de datos

n/d

### `YAML`

#### Cabeceras

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `title`

</div>
  <div class="card-body">
    <div class="card-title">

Consulte la sección de rebajas anterior.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `status`

</div>
  <div class="card-body">
    <div class="card-title">

Consulte la sección de rebajas anterior.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `acl`

</div>
  <div class="card-body">
    <div class="card-title">

Consulte la sección de rebajas anterior.

</div>
</div>
</div>

#### Artefactos de datos

<div class="card border-primary mb-3">
  <div class="card-header">

##### `content`

</div>
  <div class="card-body">
    <div class="card-title">

`YAML::XS::Load` estructura de datos analizada

</div>
</div>
</div>

### `CSV`

#### Cabeceras

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `title`

</div>
  <div class="card-body">
    <div class="card-title">

Consulte la sección de rebajas anterior.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `status`

</div>
  <div class="card-body">
    <div class="card-title">

Consulte la sección de rebajas anterior.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `acl`

</div>
  <div class="card-body">
    <div class="card-title">

Consulte la sección de rebajas anterior.

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `headers`

</div>
  <div class="card-body">
    <div class="card-title">

Opcional; el valor verdadero indica que este documento tiene un `CSV` línea de cabecera en la parte superior de su contenido.

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `column_ids`

</div>
  <div class="card-body">
    <div class="card-title">

Lista separada por comas opcional de ID de columna para `PDL`

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `datetime`

</div>
  <div class="card-body">
    <div class="card-title">

Opcional [`strptime(3)`](https://www.man7.org/linux/man-pages/man3/strptime.3.html) formato para `PDL` proceso

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `type`

</div>
  <div class="card-body">
    <div class="card-title">

Opcional declarado `PDL` tipos de dato de columna

</div>
</div>
</div>

#### Artefactos de datos

<div class="card border-primary mb-3">
  <div class="card-header">

##### `content`

</div>
  <div class="card-body">
    <div class="card-title">

`arrayref` de cualquiera de `arrayrefs` (no `csv` encabezados), o `hashrefs` (`csv` encabezados)

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `csv`

</div>
  <div class="card-body">
    <div class="card-title">

[`Text::CSV` ](https://metacpan.org/pod/Text::CSV) objeto utilizado para producir

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `pdl`

</div>
  <div class="card-body">
    <div class="card-title">

Completo [`PDL`](https://metacpan.org/pod/PDL) objeto generado por la configuración de cabecera

</div>
</div>
</div>

<!-- $Date$ $Author$ $Revision$ -->
