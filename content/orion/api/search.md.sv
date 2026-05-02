---
archived: ~
categories: ~
dependencies: '*.md.sv '
keywords: REST, API
published: ~
status: skiss
title: Orion API - Sök
---

{# lede #}Det här dokumentet innehåller API:erna för **Search**{# lede #}

[TOC]

----

## Dynamic Search (/dynamic/search.pl/...).

### Frågesträngsargument

#### språk

- [`.en`](#)
- [`.es`](#)
- [`.fr`](#)
- [`.de`](#).

#### markdown_search

boolesk (0 eller 1).

#### reguljärt uttryck

#### speciallägen

###### all accounts

- [`vänner=`](#)
- [`klocka=`](#)
- [`underrätta=$revision`](#)
- [`som=`](#) (PIA)
- [`diff=$revision`](#)
- [`log=$revision`](#)
- [`@$group=`](#)
- [`$user=`](#).

###### svnadmin group

- [`bygga=`](#)
- [`acl=`](#)
- [`deps=`](#)
- [`svnauthz=`](#).

#### kompatibilitetslägen

- sträng inom citattecken


#### PCRE-läge

### Filteriteration

- [`filtrera`](#).

Tillståndsbaserat, itererat PCRE-filter för matchande filer.

### Allmänna JSON-svarsfält

- [`sökväg`](#)
- [`rubrik`](#)
- [`markdown_search`](#)
- [`matchar`](#)
- [`språk`](#)
- [`reguljärt uttryck`](#)
- [`navigeringsspår`](#)
- [`nyckelord`](#)
- [`vänner`](#)
- [`klocka`](#)
- [`grafviz`](#)
- [`varaktighet`](#)
- [`logg`](#)
- [`blogg`](#)
- [`skillnad`](#)
- [`meta`](#)
- [`logg`](#)
- [`sylt`](#)
- [`rep`](#)
- [`webbplats`](#)
- [`hash`](#)
- [`filtrera`](#)
- [`specialerbjudanden`](#).

<!-- $Date$ $Author$ $Revision$ -->
