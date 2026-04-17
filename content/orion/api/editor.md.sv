---
archived: ~
categories: ~
dependencies: '*.md.sv '
keywords: REST, API
published: ~
status: skiss
title: Orion API - Online Editor
---

{# lede #}Det här dokumentet omfattar API:erna och användargränssnittet **Online Editor**{# lede #}

[TOC]

----

## Orionredigerare (cms.sunstarsys.com).

### Allmänna åtgärder

#### omdirigering

Slutpunkt för ingående trafik för Orions CMS-gränssnitt.

Obligatoriska frågesträngsargument:

- [`URI`](#).

Valfria frågesträngsargument:

- [`uppdatera`](#) - ställ in på 0 för att inaktivera uppdateringen av arbetskopian
- [`åtgärd`](#) - val av omdirigeringsåtgärd
- [`språk`](#) - Önskat språk för UI
- [`rep`](#) - mål, namn på Subversion-datalager
- [`ny`](#) - skapa en ny arbetskopia
- [`reguljärt uttryck`](#).

#### inloggning

Validerar och cachelagrar inloggningsuppgifter för underversion för det aktuella datalagret. Svarar endast på POST-metoden.

### Åtgärder för arbetskopia

#### JSON-svarsfält för arbetskopia

- [`rep`](#)
- [`webbplats`](#)
- [`åtgärd`](#)
- [`språk`](#)
- [`navigeringsspår`](#)
- [`läge`](#)
- [`is_dir`](#)
- [`is_root_dir`](#)
- [`katalog`](#)
- [`utrota`](#)
- [`attachments_dir`](#)
- [`is_attachment`](#)
- [`status`](#)
- [`filial`](#)
- [`bild`](#)
- [`rubriker`](#)
- [`nöjd`](#)
- [`http_status`](#)
- [`nav_options`](#)
- [`actions_lang`](#)
- [`titta`](#).

### Lista över API-åtgärder

##### redigera

###### Friends Completion

##### uppdatering

#### återställ

#### kopiering

#### flytt

##### borttagning

#### lägg till

###### Friends Completion

#### bekräftelse

#### skillnad

####sammanslagning

#### produktion

#### befordran

#### lösning

##### återställning

##### sökning

#### statisk

#### konto

###### Credentials Changes

#### kommentar

###### Friends Completion

#### bevakning

#### utan matchning

#### som

#### till skillnad från

<!-- $Date$ $Author$ $Revision$ -->
