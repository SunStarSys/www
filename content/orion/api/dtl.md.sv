---
archived: ~
categories: ~
dependencies: '*.md.sv'
keywords: REST, API
published: ~
status: skiss
title: Orion API - Django Mallbibliotek
---

{# lede #}Det här dokumentet innehåller API:erna för **Django Template Library (DTL)**{# lede #}

[TOC]

----

## DTL (Django 1.0-mallbibliotek).

### Django 1.0 Filtertillägg ([Dotiac::DTL::Filter](https://github.com/SunStarSys/orion/blob/master/lib/Dotiac/DTL/Filter.pm).

#### tillägg

Tar ett enda argument och lägger till dess värde i de filtrerade indata.  Argumentet kan vara ett varname eller en sträng inom citattecken. Det här filtret är smart om `/` karaktärerna förenas på [`sätta på`](#).

#### nedskärningar

Liknar [`klippa`](#).

### ledd

Extraherar texten mellan &#123;# [`ledare`](#) #&#125;

#### ssi

Recursivt utvärderar alla Django [`ssi`](#).

#### starts_with

Test för prefixmatchning.

#### katalognamn

Returnerar den traditionella UNIX [`katalognamn`](#).

#### parse_filename

Gränssnitt för [`SunStarSys::Util::parse_filename`](#). Huvudskillnaden är att de två första returvärdena för den underrutinen byts ut och sökvägstilläggen bryts ut (med [`.`](#) prefixed) i enskilda argument, vilket gör att filtret kan ta en argumentsträng som representerar en lista med index i den resulterande uppställningen. Ett argument som slutar med [`..`](#).

#### basnamn

Returnerar den traditionella UNIX [`basnamn`](#) för sökvägen i den filtrerade indatasträngen. Överföra ett argument om [`0`](#).

#### tex2md

Transformeringar $$\LaTeX$$ källor till nedsättning+$$\KaTeX$$

#### md2tex

Omvänd omvandling av `tex2md`

#### vcs_date

Tar en [`språk`](#) argument för att ge en språkspecifik representation av dagen, månaden och året för den senaste ändringen som presenteras av [`$Datum`](#) Subversion-nyckelord i den filtrerade indatasträngen (som vanligtvis är den fullständiga [`nöjd`](#).

#### vcs_time

Representerar numerisk timme, minut, sekunder och tidszonsförskjutning för den senaste ändringen som presenteras av [`$Datum`](#).

#### vcs_author

Presenterar en [`kondom`](#) HTML-representation av den användare som senast uppdaterade innehållet enligt nyckelordet Subversion [`$Författare`](#) nyckelord i den filtrerade indatasträngen.  Tar ett valfritt [`språk`](#).

#### vcs_revision

Visar det numeriska revisionsnumret för den senaste ändringen av innehållet, som registrerats av [`$Revision`](#).

#### strip_prefix

Tar bort prefixet (path), som skickats som ett argument till filtret, från den filtrerade indatasträngen (path). Prefixet är som standard det reguljära uttrycket [`\S+/content/`](#).

#### blandning

Blanda arrayen.

#### bild

Hämta den första HTML5/Markdown-bilden från det filtrerade innehållet.

<!-- $Date$ $Author$ $Revision$ -->
