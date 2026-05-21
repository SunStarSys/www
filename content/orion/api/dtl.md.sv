---
categories: ~
dependencies: '*.md.sv'
keywords: VILA, API
status: verifierad=38132
title: Orion API - Django mallbibliotek
---

<div class="right">

![SunStar System](../../images/sunstarstaronly)

</div>

{# lede #}Det här dokumentet täcker **Django Template Library (DTL)** filter-API:er{# lede #}.

[TOC]

## DTL (Django 1.0-mallbibliotek)

### Django 1.0 Filterförlängningar ([Dotiac::DTL::Filter](https://github.com/SunStarSys/orion/blob/master/lib/Dotiac/DTL/Filter.pm))

-----

#### `append`

Tar ett enda argument och lägger till dess värde i de filtrerade indata.  Argumentet kan vara ett varname eller en sträng inom citattecken. Det här filtret är smart om `/` tecken som förenas på `append`.

-----

#### `cuts`

Liknar `cut`, men argumentet tas som en *understräng* för att elidera, i stället för en lista med tecken.

-----

#### `lede`

Extraherar texten mellan &#123;# `lede` #&#125; block i den filtrerade indatasträngen.

-----

#### `ssi`

Utvärderar alla Django `ssi` taggar i den filtrerade indatasträngen.

-----

#### `starts_with`

Tester för prefixmatchning.

-----

#### `dirname`

Returnerar det traditionella `UNIX dirname` för sökvägen i den filtrerade indatasträngen.

-----

#### `parse_filename`

Gränssnitt för [`SunStarSys::Util::parse_filename`](build#-code-parse_filename-path-code-). Den viktigaste skillnaden är att de två första returvärdena för den subrutinen byts ut och banans förlängningar bryts ut (med `.` med prefix) i enskilda argument, vilket gör att filtret kan ta en argumentsträng som representerar en lista med index i den resulterande uppställningen. Ett argument som slutar med `..` kommer att ansluta till *alla* tolkade tillägg till slutet av den resulterande strängen.

-----

#### `basename`

Returnerar det traditionella `UNIX basename` för sökvägen i den filtrerade indatasträngen. Att argumentera för `0` till det här filtret kommer det att ta bort alla filtillägg från den resulterande strängen.

-----

#### `tex2md`

Transformeringar $$\LaTeX$$ källor till nedsättning+$$\KaTeX$$ källor. Experimentell.

-----

#### `md2tex`

Produktionskvalitetsomvandling av `tex2md`.

-----

#### `vcs_date`

Tar en `lang` argument för att tillhandahålla en språkspecifik representation av dag, månad och år för den senaste ändringen som presenteras av `$Date` Subversion-nyckelord i den filtrerade indatasträngen (som vanligtvis är hela `content` den nuvarande resursen).

-----

#### `vcs_time`

Representerar den numeriska tim-, minut-, sekund- och tidszonsförskjutningen för den senaste ändringen som presenteras av `$Date` Subversion-nyckelord i den filtrerade indatasträngen.

-----

#### `vcs_author`

Visar en `safe` `HTML` återgivning av den användare som senast uppdaterade innehållet, som registrerats med nyckelordet Subversion `$Author` nyckelordet i den filtrerade indatasträngen.  Tar ett valfritt alternativ `lang` argument för en språkspecifik representation.

-----

#### `vcs_revision`

Visar det numeriska revisionsnumret för den senaste ändringen av innehållet, som registrerats av `$Revision` nyckelordet i den filtrerade indatasträngen.

-----

#### `strip_prefix`

Tar bort prefixet (sökväg), som skickas som ett argument till det här filtret, från den filtrerade indatasträngen (sökväg). Prefixet är som standard det reguljära uttrycket `\S+/content/` annars.

-----

#### `selectattr`

Söker efter det första matchande html-taggattributet, med attributnamnet som ett argument till filtret.

-----

#### `shuffle`

Blanda matrisen.

-----

#### `img`

Hämta den första HTML5/Markdown-bilden från det filtrerade innehållet.

-----

#### `pdl_*`

Fullständig [`PDL`](https://metacpan.org/pod/PDL) API.  Om du överför det här filtret en arrayref som argument avrefereras arrayen så att dess element kan överföras direkt till `pdl_` metod med prefix som detta filter anropar.

-----

#### `grep`

Samma som det välkända verktyget UNIX/Perl; du skickar det ett reguljärt uttryck som argument och det filtrerar ut det icke-`PCRE`-matcha källor.

-----

#### `code`

Hämtar en matris med `GFM` inhägnad kod blockerar ur källan; du skickar det namnet / typen av kodblock du önskar.

<!-- $Date$ $Author$ $Revision$ -->
