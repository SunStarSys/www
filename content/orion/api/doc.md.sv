---
categories: ~
dependencies: '*.md.sv'
keywords: markdown,csv,yaml
status: verifierad=37873
title: Orion API - textdokumentformat
---

## Textdokumentformat (`markdown`, `YAML`, `CSV`)

{# lede #}Den här sidan dokumenterar huvudfälten och resulterande dataartefakter{# lede #} producerad av [Bygg API](build) vid bearbetning av sådana textfiler (som sidbilagor) via dess [`single_narrative`](https://www.sunstarsys.com/orion/api/build#-code-single_narrative-args-code-) vy.

[TOC]

### `Markdown`

#### Huvuden

##### `title`

Obligatorisk dokumenttitel

##### `status`

Obligatorisk dokumentstatus:

###### skiss

Standardtillstånd.

###### verifierad

Anger att innehållet har validerats av författaren.  Återgår till utkastläge om dokumentet senare ändras utan omvalidering.

###### arkiverad

Anger att dokumentet är slutfört och okunnigt för framtida arbete i `Orion CMS`. Visas inte i framtida kataloglistor utanför dess arkiverade plats.  Arkiverad plats spårar framtida ändringar av innehåll.

##### `acl`

Valfritt `SVN` säkerhetsbehörighetskontroller i det här dokumentet. Med autokomplettera stöd och gruppvalidering i `Orion CMS` redaktör.

##### `dependencies`

Valfri kommaavgränsad lista över `file globs` att dokumentets skapade utdata är beroende av.

##### `keywords`

Valfritt `SEO`-vänlig kommaavgränsad lista över sökbara taggar.

##### `categories`

Valfri kommaavgränsad lista över klassificeringskategorier som ska referera till detta permalänkade dokument.  Additiv till sin natur (om du tar bort kategorier tas inte dessa tidigare kategorier bort från listan).

#### Dataartefakter

Saknas

### `YAML`

#### Huvuden

##### `title`

Se avsnittet Markdown ovan.

##### `status`

Se avsnittet Markdown ovan.

##### `acl`

Se avsnittet Markdown ovan.

#### Dataartefakter

##### `content`

`YAML::XS::Load` tolkad datastruktur

### `CSV`

#### Huvuden

##### `title`

Se avsnittet Markdown ovan.

##### `status`

Se avsnittet Markdown ovan.

##### `acl`

Se avsnittet Markdown ovan.

##### `headers`

Anger att dokumentet har en `CSV` rubrikrad överst i innehållet.

##### `column_ids`

Valfri kommaavgränsad lista över kolumn-id:n för `PDL`

##### `datetime`

Valfritt [`strptime(3)`](https://www.man7.org/linux/man-pages/man3/strptime.3.html) format för `PDL` bearbetning

##### `type`

Valfritt deklarerat `PDL` kolumndatatyper

#### Dataartefakter

##### `content`

`arrayref` av endera `arrayrefs` (nej `csv` rubriker), eller `hashrefs` (`csv` rubriker)

##### `csv`

[`Text::CSV` ](https://metacpan.org/pod/Text::CSV) objekt som används för att producera ovan

##### `pdl`

Fullständig [`PDL`](https://metacpan.org/pod/PDL) objekt genererat av huvudkonfiguration

<!-- $Date$ $Author$ $Revision$ -->
