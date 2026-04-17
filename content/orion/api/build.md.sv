---
archived: ~
categories: ~
dependencies: '*.md.sv '
keywords: REST, API
published: ~
status: skiss
title: Orion API - bygge
---

{# lede #}Det här dokumentet beskriver API:erna för **Bygg system**{# lede #}

[TOC]

----

## Byggsystem

### [SunStarSys::Visa](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm).

#### single_narrative(%args).

Obligatoriska argument:

- [`mall`](#)
- [`sökväg`](#)
- [`språk`](#).

Valfria argument:

- [`håna`](#)
- [`quick_deps`](#)
- [`förbearbetning`](#)
- [`archive_root`](#)
- [`category_root`](#).

#### news_page(%args).

#### sitemap(%args).

Språkspecifikt, sorterat index över beroenden.

Obligatoriska argument:

- [`sökväg`](#)
- [`språk`](#).

Valfria argument:

- [`quick_deps`](#)
- [`kapslad`](#)
- [`förbearbetning`](#).

#### asymptote(%args).

Byggnader och cacheminnen [`asymptot`](#).

Obligatoriska argument:

- [`visa`](#)
- [`språk`](#)
- [`sökväg`](#).

#### hoppa över(%args).

Bygg inte dessa alls.  Skapa i stället de associerade genererade källfilerna (t.ex. `.bib\$lang` $$\mapsto$$ `\$base.page/bibliography.yml\$lang`

#### yml2ext(%args).

Konvertera YAML-filer.

Valfria argument:

- [`utrota`](#) standardinställs på `json`
- [`filtrera`](#) standardinställs på `json_raw`
-[`mall`](#) åsidosätta `filtrera`

#### fetch_deps($path, $data, $quick).

Obligatoriska argument:

- [`sökväg`](#)
- [`data`](#) - butiker som resulterar anon-array av deps
- [`snabb`](#).

#### breadcrumbs($path).

Returnerar HTML-spårlista för [$sökväg](#).

#### memoize(%args).

Cachelagrar bygget. Används huvudsakligen med fetch_deps och quick_deps > 2.

#### compress(%args).

Inaktuell.

#### next_view(%args).

Verktyg för bearbetning av $args{view}.

#### ssi(%args).

Utvärderar rekursivt [ssi](#).

#### offline(%args).

Kör next_view i offlineläge.

#### snippet(%args).

Bearbetar kodfragmentrader.

#### reconstruct(%args).

Ombearbetar malldirektiv i inbyggt innehåll från next_view.

#### trim_local_links(%args).

Trimmar filändelser från lokala länkar.

#### normalize_links(%args).

Normaliserar lokala länkar (./ och ../).

----

### [SunStarSys::Till](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Util.pm).

#### read_text_file($file, $out, $content_lines).

Tolkar rubriker + innehåll i UTF-8-kodad fil [`$fil`](#) och lagrar resultat i [`$ut`](#). [`$content_lines`](#) är det (valfria) högsta antalet innehållsrader att läsa.


[`$fil`](#) kan vara en referens till en rå sträng som representerar hela innehållet i en fil.  Resultaten i [`$ut`](#).

#### copy_if_newer($src, $dest).

Kopior [`$prognos`](#) till [`$dest`](#) om den förstnämnda ändringens tidsstämpel är nyare än den senare. På kopia, dessutom gzip-komprimerar [`$dest`](#).

#### get_lock($lockfile).

Tar ett exklusivt (f)lås (för den aktuella UNIX-processen) på [`$lockfile`](#).

#### blandning(\\@deck).

På plats slumpmässig (Fisher-Yates) blandning av [`@deck`](#).

#### sort_tables($content).

Sorterar nedsättningstabeller i $content enligt varje tabells kolumnspecifikation.  Exakt en kolumn kan sorteras per tabell, valfritt numeriskt [`n`](#)i antingen fallande [`v`](#) eller stigande [`^`](#).

#### fixup_code($prefix, $type, @\_).

Tar bort $prefix från varje argument i @\_. Funktionen för argumentet $type är implementeringsspecifik, men används huvudsakligen för att fördefiniera "läget" för editor.md för bearbetning av innehållet i @\_.

#### unload_package($pkg).

Aggressivt lossar Perl-paketet [`$paket`](#).

#### purge_from_inc(@paths).

Tar bort [`@paths`](#) från [`@INC`](#).

#### touch(@\_).

Tar med alla filer i [`@_`](#). Om inga argument överförs används [`$_`](#).

#### normalize_svn_path(@\_).

Normaliserar alla sökvägar i [`@_`](#) för säker användning som råa argument till [`SVN::Klient`](#).

#### sanitize_relative_path(@\_).

Säkrar sökvägar i [`@_`](#) för användning som rena relativa vägar i [`Dotiac::DTL`](#).

#### parse_filename($path).

Wrapper runt [`Fil::Basename::fileparse`](#). Utan argument, använder [`$_`](#).

#### walk_content_tree($code).

Villkorligt vandrar [`./innehåll`](#) trädet i utcheckningen av konfigurationssystemet, normaliserar först [`$_`](#) som den formella undervägen och sedan åberopa [`$kod`](#).

##### archived($path).

Flaggor varje [`Status: arkiv`](#) [`$sökväg`](#). Användningar [`$_`](#).

##### seed_file_deps($path).

Uppdateringar [`%path::beroenden`](#) för detta [`$sökväg`](#), baserat på dess [`Beroenden`](#) global teckenbredd. Standardinställningen är att använda [`$_`](#).

##### seed_file_acl($path).

Uppdateringar [`@path::acl`](#) för detta [`$sökväg`](#), baserat på dess [`Åtkomstlista`](#) huvudspecifikation Standardinställningen är att använda [`$_`](#).

#### Laddning

Samma som [`YAML::XS::Ladda`](#).

#### Dumpa

Samma som [`YAML::XS::Dump`](#).

<!-- $Date$ $Author$ $Revision$ -->
