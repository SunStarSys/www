---
categories: ~
dependencies: '*.md.sv'
keywords: markdown,csv,yaml
status: verifierad=38102
title: Orion API - textdokumentformat
---

## Textdokumentformat (`markdown`, `YAML`, `CSV`)

{# lede #}Den här sidan dokumenterar huvudfälten och resulterande dataartefakter{# lede #} producerad av [Bygg API](build) vid bearbetning av sådana textfiler (som sidbilagor) via dess [`single_narrative`](build#-code-single_narrative-args-code-) vy.

[TOC]

### `Markdown`

#### Huvuden

<div class="card border-primary mb-3">
  <div class="card-header">

##### `title`

</div>
  <div class="card-body">
    <div class="card-title">

Obligatorisk dokumenttitel.

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

Obligatorisk dokumentstatus i fritext.

</div>

<p class="card-text">

Tre sådana särskilda statusetiketter förklaras nedan:

###### skiss

Standardtillstånd.

-----

###### verifierad

Anger att innehållet har validerats av författaren.  Återgår till utkastläge om dokumentet senare ändras utan omvalidering.

-----

###### arkiverad

Anger att dokumentet är slutfört och okunnigt för framtida arbete i `Orion CMS`. Visas inte i framtida kataloglistor utanför dess arkiverade plats.  Arkiverad plats spårar framtida ändringar av innehåll.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `acl`

</div>
  <div class="card-body">
    <div class="card-title">

Valfritt `SVN` säkerhetsbehörighetskontroller i det här dokumentet. Med autokomplettera stöd och gruppvalidering i `Orion CMS` redaktör.

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

Valfri kommaavgränsad lista över `file globs` att dokumentets skapade utdata är beroende av.

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
Valfritt `SEO`-vänlig kommaavgränsad lista över sökbara taggar.

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

Valfri kommaavgränsad lista över klassificeringskategorier som ska referera till detta permalänkade dokument.

</div>
<p class="card-text">

Additiv till sin natur (om du tar bort kategorier tas inte dessa tidigare kategorier bort från listan).

</p>
</div>
</div>

#### Dataartefakter

Saknas

### `YAML`

#### Huvuden

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `title`

</div>
  <div class="card-body">
    <div class="card-title">

Se avsnittet Markdown ovan.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `status`

</div>
  <div class="card-body">
    <div class="card-title">

Se avsnittet Markdown ovan.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `acl`

</div>
  <div class="card-body">
    <div class="card-title">

Se avsnittet Markdown ovan.

</div>
</div>
</div>

#### Dataartefakter

<div class="card border-primary mb-3">
  <div class="card-header">

##### `content`

</div>
  <div class="card-body">
    <div class="card-title">

`YAML::XS::Load` tolkad datastruktur

</div>
</div>
</div>

### `CSV`

#### Huvuden

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `title`

</div>
  <div class="card-body">
    <div class="card-title">

Se avsnittet Markdown ovan.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `status`

</div>
  <div class="card-body">
    <div class="card-title">

Se avsnittet Markdown ovan.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `acl`

</div>
  <div class="card-body">
    <div class="card-title">

Se avsnittet Markdown ovan.

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `headers`

</div>
  <div class="card-body">
    <div class="card-title">

Valfritt; sant värde anger att dokumentet har en `CSV` rubrikrad överst i innehållet.

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `column_ids`

</div>
  <div class="card-body">
    <div class="card-title">

Valfri kommaavgränsad lista över kolumn-id:n för `PDL`

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `datetime`

</div>
  <div class="card-body">
    <div class="card-title">

Valfritt [`strptime(3)`](https://www.man7.org/linux/man-pages/man3/strptime.3.html) format för `PDL` bearbetning

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `type`

</div>
  <div class="card-body">
    <div class="card-title">

Valfritt deklarerat `PDL` kolumndatatyper

</div>
</div>
</div>

#### Dataartefakter

<div class="card border-primary mb-3">
  <div class="card-header">

##### `content`

</div>
  <div class="card-body">
    <div class="card-title">

`arrayref` av endera `arrayrefs` (nej `csv` rubriker), eller `hashrefs` (`csv` rubriker)

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `csv`

</div>
  <div class="card-body">
    <div class="card-title">

[`Text::CSV` ](https://metacpan.org/pod/Text::CSV) objekt som används för att producera ovan

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `pdl`

</div>
  <div class="card-body">
    <div class="card-title">

Fullständig [`PDL`](https://metacpan.org/pod/PDL) objekt genererat av huvudkonfiguration

</div>
</div>
</div>

<!-- $Date$ $Author$ $Revision$ -->
