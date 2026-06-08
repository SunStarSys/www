---
categories: ~
dependencies: '*.md.sv'
keywords: REST,API,Django
status: verifierad=39442
title: Orion API - Django mallbibliotek
---

<div class="right">

![SunStar System](../../images/sunstarstaronly)

</div>

{# lede #}Det här dokumentet täcker tagg-, insticksprograms- och filter-API:erna **Django Template Library (DTL)**{# lede #}.

[TOC]

## Django 1.0 Taggar

-----

### `autoescape`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/autoescape.pm:token==head1,=cut:lang=perl]

-----

### `block`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/block.pm:token==head1,=cut:lang=perl]

-----

### `comment`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/comment.pm:token==head1,=cut:lang=perl]

-----

### `debug`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/debug.pm:token==head1,=cut:lang=perl]

-----

### `extends`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/extends.pm:token==head1,=cut:lang=perl]

-----

### `filter`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/filter.pm:token==head1,=cut:lang=perl]

-----

### `firstof`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/firstof.pm:token==head1,=cut:lang=perl]

-----

### `for`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/for.pm:token==head1,=cut:lang=perl]

-----

### `ifchanged`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/ifchanged.pm:token==head1,=cut:lang=perl]

-----

### `ifequal`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/ifequal.pm:token==head1,=cut:lang=perl]

-----

### `ifnotequal`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/ifnotequal.pm:token==head1,=cut:lang=perl]

-----

### `if`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/if.pm:token==head1,=cut:lang=perl]

-----

### `include`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/include.pm:token==head1,=cut:lang=perl]

-----

### `load`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/load.pm:token==head1,=cut:lang=perl]

-----

### `now`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/now.pm:token==head1,=cut:lang=perl]

-----

### `regroup`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/regroup.pm:token==head1,=cut:lang=perl]

-----

### `spaceless`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/spaceless.pm:token==head1,=cut:lang=perl]

-----

### `ssi`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/ssi.pm:token==head1,=cut:lang=perl]

-----

### `templatetag`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/templatetag.pm:token==head1,=cut:lang=perl]

-----

### `url`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/url.pm:token==head1,=cut:lang=perl]

-----

### `widthratio`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/widthratio.pm:token==head1,=cut:lang=perl]

-----

## Django Laddade Plugins

### `markup`
[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Addon/markup.pm:token==head1,=cut:lang=perl]

-----

### `json`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Addon/json.pm:token==head1,=cut:lang=perl]

-----

## Django 1.0 Filter API

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Filter.pm:token==head1,=cut:lang=perl]

-----

## API-tillägg för Orion-filter

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

#### `fenced`

Hämtar en matris med `GFM` inhägnad kod blockerar ur källan; du skickar det namnet / typen av kodblock du önskar.

<!-- $Date$ $Author$ $Revision$ -->
