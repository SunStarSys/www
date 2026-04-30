---
categories: ~
dependencies: '*.md.sv'
keywords: VILA, API
status: verifierad=34604
title: Orion API - bygge
---

{# lede #}Det här dokumentet täcker API:erna **Bygg system**{# lede #}.

I grund och botten styrs byggsystemet av två Perl-moduler som tillhandahålls av användaren: [`lib/path.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm) och [`lib/view.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/view.pm).

Det första är att göra tre saker:

0. ladda [`lib/facts.yml`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/facts.yml) och [`lib/acl.yml`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/acl.yml),
1. konstruera `@path::mönster`och
2. opportunistiskt gå den `innehåll/` träd att fördefiniera `%path::beroenden` och `@path::acls` från metadata för filhuvud för nedsättning/yaml.

Den senares jobb är att tillhandahålla bokningsbara `visa`-baserad `$metod`s för matchande poster i `@path::mönster` (som ett strängifierat metodnamn i den andra rutan för varje arrayref-post), anropat av [skapa skript](https://github.com/SunStarSys/orion/blob/master/build_site.pl#L219-L258) enligt nedan ...

```perl
#api
  ...

my $path = "/content-rooted/path/to/source/file";

for my $p (@path::patterns) {
    my ($re, $method, $args) = @$p;
    next unless $path =~ $re;
    ++$matched;

my ($content, $mime_extension, $final_args, @new_sources) = view->can($method)->(path => $path, lang => $lang, %$args);

... write UTF-8 decoded $content to target file with associated $mime_extension file-type, and feed @new_sources back into the build.
  }

copy_if_newer("content$path", "$ENV{TARGET}/content$path") unless $matched;

...
#api
```

Många åsikter är avsedda att staplas som "filter" förbearbeta aspekter av filen i `$sökväg` som är nya, som extern kod `kodfragment` eller `asymptot`-hindrade nedsättningsblock. Du kan se ett exempel på detta [här](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm#L53).

[TOC]

----

## Byggsystem

### [SunStarSys::Visa](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm) &mdash; basklass för `lib/view.pm`

#### single_narrative(%args) &mdash; den mest populära (och sofistikerade) vyn

Den här vyn innehåller automatisk bearbetning av filer som finns i `$sökväg`bilagekatalog. Med andra ord, om `$path = "/foo.md.en"`, sedan de filer som lagras i  `/foo.page/` katalog associerad med "och" språktillägg kommer att införlivas i mallens adresserbara argument för att `$sökväg` Oavsett om `förbearbetning` argumentinställning &mdash; som, om det är sant, också skulle göra det materialet tillgängligt för själva **sidans innehåll**.

Obligatoriska argument:

- [`mall`](#)
- [`sökväg`](#)
- [`språk`](#)

Valfria argument:

- [`dl`](#) &mdash; åsidosätter normalt [`fetch_deps`]() bearbetning

- [`quick_deps`](#) &mdash; intern optimeringsinställning för deps-processing; bäst lämnad ej inställd

- [`förbearbetning`](#) &mdash; aktiverar mallbearbetning inom [`$sökväg`](#) Själva innehållet,

- [`archive_root`](#) &mdash; filer i "arkiverad" status är "kopierad" och spåras per år/månad undermappar till denna innehållsrotade plats via `ssi`,

- [`category_root`](#) &mdash; artiklar i "kategorier" Huvudet är "kopierad" över till lämpligt namngivna kategorimappar på den här innehållsbaserade platsen via `ssi`.

#### news_page(%args) &mdash; för aggregeringssidor med flera artiklar

#### webbplatskarta (%args) &mdash; för att skapa sidor för index.html och sitemap.html

Språkspecifikt, sorterat index för beroenden.

Obligatoriska argument:

- [`sökväg`](#)
- [`språk`](#)

Valfria argument:

- [`quick_deps`](#)
- [`kapslad`](#)
- [`förbearbetning`](#)

#### asymptot(%args)

Byggnader och cacheminnen [`Asymptot`](https://asymptote.sourceforge.io/) triple-backquoted-code block för HTML5-WebGL-canvas-aktiverad vektorgrafik.

Obligatoriska argument:

- [`visa`](#)
- [`språk`](#)
- [`sökväg`](#)

#### hoppa över(%args)

Bygg inte dessa alls.  Bygg i stället de associerade genererade källfilerna (t.ex. `.bib\$lang` $$\mapsto$$ `\$base.page/bibliography.yml\$lang`) som ska byggas på en sekundär byggsystemkörning.

#### yml2ext(%args)

Konvertera YAML-filer, vanligtvis till JSON.

Valfria argument:

- [`ext.`](#) standardvärdet är `json`
- [`filtrera`](#) standardvärdet är `json_raw`
- [`mall`](#) åsidosättningar `filtrera` standarduttryck

#### fetch_deps($path, $data, $quick)

Refactors $data argument hashref som en tidsstämpel ordnade arrayref av 2-element arrayrefs. Den första posten i varje 2-element arrayref är filsökvägens namn, det andra elementet är resultatet [`read_text_file`](#) hashref för det sökvägsnamnet.

Returnerar en lista över resulterande nya källfiler om [`$snabb > 2`](#).

Obligatoriska argument:

- [`sökväg`](#)
- [`data`](#) - Inmatning som hashref; lagrar resulterande anon-array av deps vid retur
- [`snabb`](#) - standardvärdet är 2

#### navigeringsspår($path)

Returnerar HTML-spårlista för [$sökväg](#).

#### memoize(%args)

Cachelagrar bygget. Används främst med fetch_deps och quick_deps > 2.

#### kommentar(%args)

Genererar SSI-inkluderingsbart HTML-fragment för en sidkommentar.

#### next_view(%args)

Verktyg för bearbetning av $args{visa}.

#### ssi(%args)

Utvärderar rekursivt [ssi](#) taggar.

#### offline(%args)

Kör next_view i offlineläge.

#### utdrag(%args)

[Bearbetar extern kod](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Value/Snippet.pm#L12-L13) [utdragslinjer](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm#L806), importerar vanligtvis sina källplatser på GitHub till programmeringsspråkiga avgränsade nedsättningsblock. [Exempel här](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/content/joe/perl7-sealed-lexicals.md.en#L135).

#### rekonstruera (%args)

Ombearbetar malldirektiv i inbyggt innehåll från next_view.

#### trim_local_links(%args)

Trims filändelser från lokala länkar.

#### normalize_links(%args)

Normaliserar lokala länkar (./ och ../).

----

### [SunStarSys::Tillfälle](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Util.pm) &mdash; verktygsbibliotek för [`lib/path.pm`](#) och [`lib/view.pm`](#)

#### read_text_file($file, $out, $content_lines) &mdash; Orions universella textfilprocessor

Parsar rubriker+innehåll i den UTF-8-kodade filen [`$fil`](#) och lagrar resultat i [`$out`](#). [`$content_lines`](#) är det (valfritt) högsta antalet innehållsrader att läsa.
Returnerar faktiskt antal lästa rader (inklusive huvuden).

[`$fil`](#) kan vara en referens till en rå sträng som representerar hela innehållet i en fil.  Resultaten i [`$out`](#) Kommer fortfarande att vara UTF-8 kodad.

#### copy_if_newer($src, $dest)

Kopior [`$src`](#) till [`öre`](#) om den tidigare ändringens tidsstämpel är nyare än den senare. På kopia, dessutom gzip-komprimerar [`öre`](#) fil om det är en textfil och lägger till ".gz" Tillägg till namnet.

#### get_lock($lockfile)

Tar ett exklusivt (f)lås (för aktuell UNIX-process) på [`$lockfil`](#).

#### blanda(\\&#64;däck)

Slumpmässig blandning på plats (Fisher-Yates) av [`@deck`](#).

#### sort_tables($content)

Sorterar nedsättningstabeller i $content enligt varje tabells kolumnspecifikation.  Exakt en kolumn kan sorteras per tabell, alternativt numeriskt [`n`](#)i antingen fallande [`v`](#) eller stigande [`^`](#) beställning.

#### fixup_code($prefix, $type, &#64;_)

Tar bort $prefix från varje argument i &#64;\_. Funktionen för argumentet $type är implementeringsspecifik, men används huvudsakligen för att fördefiniera editor.md "läge" för bearbetning av innehållet i &#64;_.

#### unload_package($pkg)

Aggressivt lossar Perl-paket (blad) [`kg`](#) från symboltabellen (STASH).

#### purge_from_inc(&#64;sökväg)

Tar bort [`@paths`](#) från [`@INC`](#).

#### beröring(&#64;_)

Berör alla filer i [`@_`](#). Om inga argument överförs används [`$_`](#).

#### normalize_svn_path(&#64;_)

Normaliserar alla sökvägar i [`@_`](#) för säker användning som råa argument till [`SVN::Klient`](#) kommandon.

#### sanitize_relative_path(&#64;_)

Säkrar sökvägar i [`@_`](#) för användning som rena relativa sökvägar i [`Dotiac::DTL`](#) (Django Template) sökvägsspecifika kommandon.

#### parse_filename($path)

Wrapper runt [`Filparse::Basename::fileparse`](#). Utan argument används [`$_`](#) som filnamnet som ska tolkas.

#### walk_content_tree($code)

Villkorligt vandrar [`./innehåll`](#) trädet i byggsystemet (kassa), först normalisering [`$_`](#) som formell innehållsbaserad undersökväg, och sedan anropa [`$code->()`](#) på varje föremål i trädgången. För de flesta byggen händer aldrig promenaden &mdash; i stället bygger bygget på cachelagrade data från tidigare byggen.

Det enda sättet att tvinga en promenad är genom att ställa [`$path::use_cache`](#) till ett falskt värde i de moduler som användaren tillhandahåller. I annat fall hanteras detta beteende sakkunnigt av [inkrementell byggteknik](https://iconoclasts.blog/joe/dependencies).

Returnerar 1 om vandringen faktiskt fortsatte, i stället för att förlita sig på cachelagrade data. Annars returneras ett falskt värde.

##### arkiverad($path)

Flaggor varje [`Status: arkiverad`](#) [`$sökväg`](#) (på ett naturligt språkligt sätt). Användningar [`$_`](#) om inga argument överförs.

Att arkivera filer är ett naturligt sätt att berätta för Orion att "sluta uppmärksamma den här filens permalänkade plats ... om den inte uppdateras igen, i vilket fall arkivplatsen kommer att uppdateras. I synnerhet visas inte arkiverade filer i kataloglistor i själva CMS-systemet. Du måste navigera till själva den aktiva sidan för att kunna redigera den igen online.

##### seed_file_deps($path)

Säker uppdatering [`%path::beroenden`](#) för detta [`$sökväg`](#)baserat på dess [`Beroenden`](#) globala sidhuvuden. Används som standard [`$_`](#) som sökvägen om inga argument överförs.

##### seed_file_acl($path)

Säkra uppdateringar [`@path::acl`](#) för detta [`$sökväg`](#)baserat på dess [`Åtkomstkontrollista`](#) huvudspec. Används som standard [`$_`](#) som sökvägen om inga argument överförs.

#### Ladda

Samma som [`YAML::XS::Load`](#).

#### Dumpa

Samma som [`YAML::XS::Dump`](#).

<!-- $Date$ $Author$ $Revision$ -->
