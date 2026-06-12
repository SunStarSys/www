---
categories: ~
dependencies: '*.md.sv'
keywords: VILA, API
status: verifierad=39465
title: Orion API - bygge
---

<div class="right">

![SunStar System](../../images/sunstarstaronly)

</div>
<ul class="nav nav-tabs" role="tablist">
  <li class="nav-item" role="presentation">
    <a class="nav-link" data-bs-toggle="tab" href="#stats" aria-selected="false" role="tab" tabindex="-1">Statistik</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link active" data-bs-toggle="tab" href="#docs" aria-selected="true" role="tab">Dokumentation</a>
  </li>
</ul>
</div>
<div class="tab-content">
<div class="tab-pane fade active show" id="docs" role="tabpanel">

&nbsp;

[TOC]#sidebar

## Byggsystem

{# lede #}Det här dokumentet täcker API:erna **Bygg system**{# lede #}.

I grund och botten styrs byggsystemet av två Perl-moduler som tillhandahålls av användaren: [`lib/path.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm) och [`lib/view.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/view.pm).

Det första är att göra tre saker:

0. ladda [`lib/facts.yml`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/facts.yml) och [`lib/acl.yml`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/acl.yml),
1. konstruera `@path::patterns`och
2. opportunistiskt gå den `content/` träd att fördefiniera `%path::dependencies` och `@path::acls` från metadata för filhuvud för nedsättning/yaml.

Den senares jobb är att tillhandahålla bokningsbara `view`-baserad `$method`s för matchande poster i `@path::patterns` (som ett strängifierat metodnamn i den andra rutan för varje arrayref-post), anropat av [skapa skript]({{snippetA.pretty_uri}}):

[snippet:repo=SunStarSys/orion:path=build_site.pl:token=#api:lang=perl]

&nbsp;

Många åsikter är avsedda att staplas som "filter" Förbearbeta (eller efterbearbeta) aspekter av filen i `$path` som är nya, som extern kod `snippets` eller `asymptote`-hindrade nedsättningsblock. Du kan se ett exempel på detta [här](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm#L52).

## Innehållsförteckning

[TOC]

&nbsp;

----

&nbsp;

### [`SunStarSys::View`](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm) &mdash; basklass för `lib/view.pm`

&nbsp;

<div class="card border-primary mb-3">
  <div class="card-header">

#### `single_narrative(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Den mest populära (och sofistikerade) vyn

</div>

<p class="card-text">

Den här vyn innehåller automatisk bearbetning av filer som finns i `$path`bilagekatalog. Med andra ord, om `$path = "/foo.md.en"`, sedan de filer som lagras i  `/foo.page/` katalog associerad med "och" språktillägg kommer att införlivas i mallens adresserbara argument för att `$path` Oavsett om `preprocess` argumentinställning &mdash; som, om det är sant, också skulle göra det materialet tillgängligt för själva **sidans innehåll**.

Mandatory Arguments:

- `template`
- `path`
- `lang`

Optional Argmuents:

- `deps` &mdash; åsidosätter normalt `fetch_deps` bearbetning

- `quick_deps` &mdash; intern optimeringsinställning för deps-processing; bäst lämnad ej inställd

- `preprocess` &mdash; aktiverar mallbearbetning inom `$path` Själva innehållet,

- `archive_root` &mdash; filer i "arkiverad" status är "kopierad" och spåras per år/månad undermappar till denna innehållsrotade plats via `ssi`,

- `category_root` &mdash; artiklar i "kategorier" Huvudet är "kopierad" över till lämpligt namngivna kategorimappar på den här innehållsbaserade platsen via `ssi`.

</p>
  </div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `news_page(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

För (flerberättande) aggregerade sidor

</div>

<p class="card-text">

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `sitemap(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

För att skapa sidorna index.html och sitemap.html

</div>

<p class="card-text">

Språkspecifikt, sorterat index för beroenden.

Mandatory Arguments:

- `path`
- `lang`

Optional Arguments:

- `quick_deps`
- `nested`
- `preprocess`

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `asymptote(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Byggen och cachar [`Asymptote`](https://asymptote.sourceforge.io/) triple-backquoted-code block för HTML5-WebGL-canvas-aktiverad vektorgrafik

</div>
<p class="card-text">

Mandatory Arguments:

- `view`
- `lang`
- `path`

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `skip(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Bygg inte dessa alls.

</div>
<p class="card-text">

Bygg i stället de associerade genererade källfilerna (t.ex. `.bib\$lang` $$\mapsto$$ `\$base.page/bibliography.yml\$lang`) som ska byggas på en sekundär byggsystemkörning.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `yml2ext(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Konvertera YAML-filer, vanligtvis till JSON.

</div>
<p class="card-text">

Optional Arguments:

- `ext` standardvärdet är `json`
- `filter` standardvärdet är `json_raw`
- `template` åsidosättningar `filter` standarduttryck

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `csv2ext(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Konvertera CSV-filer, vanligtvis till JSON.

</div>
<p class="card-text">

Optional Arguments:

- `ext` standardvärdet är `json`
- `filter` standardvärdet är `json_raw`
- `template` åsidosättningar `filter` standarduttryck

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

#### `fetch_deps($path, $data, $quick)`

</div>
  <div class="card-body">
    <div class="card-title">

Refaktorer `$data` argument hashref som en tidsstämpel ordnad arrayref av 2-element arrayrefs.

</div>
<p class="card-text">

Den första posten i varje 2-element arrayref är filsökvägens namn, det andra elementet är resultatet `read_text_file` hashref för det sökvägsnamnet.

Returnerar en lista över resulterande nya källfiler om `$quick > 2`.

Mandatory Arguments:

- `path`
- `data` - indata som hashref; lagrar resulterande arrayref av deps vid retur
- `quick` - standardvärdet är 2

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

#### `breadcrumbs($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Returnerar HTML-spårlista för `$path`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `memoize(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Cachar byggnaden; används främst med `fetch_deps` och `quick_deps > 2`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `comment(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Genererar `SSI`-inkluderingsbar `HTML5` fragment för en sidkommentar.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

#### `next_view(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Verktyg för sekventiell bearbetning `$args{view}`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `ssi(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Utvärderar rekursivt `ssi` taggar.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `offline(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Kör `next_view` i offlineläge.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `snippet(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

[Bearbetar extern kod](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Value/Snippet.pm#L12-L13) [utdragslinjer](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm#L806), importerar vanligtvis sina källplatser på GitHub till programmeringsspråkiga avgränsade nedsättningsblock. [Exempel här](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/content/joe/perl7-sealed-lexicals.md.en#L135).

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `reconstruct(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Ombearbetningar `Template` direktiv i inbyggt innehåll från `next_view`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `trim_local_links(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Trims filändelser från lokala länkar.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `normalize_links(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Normaliserar lokala länkar (`./` och `../`).

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `langify_template(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Tillägg `$args{lang}` till `$args{template}`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `titleize_links(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Lägger till en rubriksträng i nedsättningslänkar. Normalt bör användas under `offline` för att undvika att dra in titlar från fjärrplatser, vilket kan sätta en betydande dra på sidan byggtider.

</div>
<p class="card-text">
</p>
</div>
</div>

&nbsp;

----

### [`SunStarSys::Util`](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Util.pm) &mdash; verktygsbibliotek för `lib/path.pm` och `lib/view.pm`

&nbsp;

<div class="card border-primary mb-3">
  <div class="card-header">

#### `read_text_file($file, $out, $content_lines)`

</div>
  <div class="card-body">
    <div class="card-title">

Orions universella textfilprocessor

</div>
<p class="card-text">

Parsar rubriker+innehåll i den UTF-8-kodade filen `$file` och lagrar resultat i hashref `$out`. `$content_lines` är det (valfritt) högsta antalet innehållsrader att läsa.

Returnerar faktiskt antal lästa rader (inklusive huvuden).

`$file` kan vara en referens till en rå sträng som representerar hela innehållet i en fil.  Resultaten i `$out` Kommer fortfarande att vara UTF-8 kodad.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `copy_if_newer($src, $dest)`

</div>
  <div class="card-body">
    <div class="card-title">

Kopior `$src` till `$dest` om den tidigare ändringens tidsstämpel är nyare än den senare.

</div>
<p class="card-text">

På kopia, dessutom gzip-komprimerar `$dest` fil om det är en textfil och lägger till ".gz" Tillägg till namnet.  `GZIP` komprimering kan inaktiveras genom inställning `$ENV{NO_COPY_COMPRESS}=1`.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `get_lock($lockfile)`

</div>
  <div class="card-body">
    <div class="card-title">

Tar ett exklusivt (f)lås (för aktuell UNIX-process) på `$lockfile`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `shuffle(\@deck)`

</div>
  <div class="card-body">
    <div class="card-title">

Slumpmässig blandning på plats (Fisher-Yates) av `@deck`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `sort_tables($content)`

</div>
  <div class="card-body">
    <div class="card-title">

Sorterar nedsättningstabeller i `$content` enligt varje tabells kolumnspecifikation.

</div>
<p class="card-text">

Exakt en kolumn kan sorteras per tabell, alternativt numeriskt `n`i antingen fallande `v` eller stigande `^` beställning.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `fixup_code($prefix, $type, @_)`

</div>
  <div class="card-body">
    <div class="card-title">

Remsor `$prefix` från varje arg i &#64;\_.

</div>
<p class="card-text">

Syftet med `$type` argumentet är implementeringsspecifikt, men används huvudsakligen för att fördefiniera `editor.md "mode"` för bearbetning av innehållet i &#64;_.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `unload_package($pkg)`

</div>
  <div class="card-body">
    <div class="card-title">

Aggressivt avlastade `Perl` (blad) förpackning `$pkg` från symboltabellen (`STASH`).

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `purge_from_inc(@paths)`

</div>
  <div class="card-body">
    <div class="card-title">

Tar bort `@paths` från `@INC`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `touch(@_)`

</div>
  <div class="card-body">
    <div class="card-title">

Berör alla filer i `@_`. Om inga argument överförs används `$_`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `normalize_svn_path(@_)`

</div>
  <div class="card-body">
    <div class="card-title">

Normaliserar alla sökvägar i `@_` för säker användning som råa argument till `SVN::Client` kommandon.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `sanitize_relative_path(@_)`

</div>
  <div class="card-body">
    <div class="card-title">

Säkrar sökvägar i `@_` för användning som rena relativa sökvägar i `Dotiac::DTL` (Django Template) sökvägsspecifika kommandon.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `parse_filename($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Wrapper runt `File::Basename::fileparse`. Utan argument används `$_` som filnamnet som ska tolkas.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `walk_content_tree($code)`

</div>
  <div class="card-body">
    <div class="card-title">

Villkorligt vandrar `./content` träd för utcheckning av byggsystemet; första normalisering `$_` som formell innehållsbaserad undersökväg, och sedan anropa `$code->()` på varje föremål i trädgången.

</div>
<p class="text-body">

För de flesta byggen händer aldrig promenaden &mdash; i stället bygger bygget på cachelagrade data från tidigare byggen.

Det enda sättet att tvinga en promenad är genom att ställa `$path::use_cache` till ett falskt värde i de moduler som användaren tillhandahåller. I annat fall hanteras detta beteende sakkunnigt av [inkrementell byggteknik](https://iconoclasts.blog/joe/dependencies).

Returnerar 1 om vandringen faktiskt fortsatte, i stället för att förlita sig på cachelagrade data. Annars returneras ett falskt värde.

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `archived($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Flaggor varje `Status: archived` `$path` (på ett naturligt språkligt sätt). Användningar `$_` om inga argument överförs.

</div>
<p class="card-text">

Arkivering Markdown-filer är ett naturligt sätt att berätta för Orion att "sluta uppmärksamma den här filens permalänkade plats", om den inte uppdateras igen, i vilket fall arkivplatsen kommer att uppdateras. I synnerhet visas inte arkiverade filer i kataloglistor inom själva Orion CMS; du måste navigera till själva den aktiva sidan för att kunna redigera den igen online.

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `seed_file_deps($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Säker uppdatering `%path::dependencies` för detta `$path`baserat på dess `dependencies` sidhuvud `glob(s)`.

</div>
<p class="card-text">

Används som standard `$_` som sökvägen om inga argument överförs.

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `seed_file_acl($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Säkra uppdateringar `@path::acl` för detta `$path`baserat på dess `acl` huvudspec.

</div>
<p class="card-text">

Används som standard `$_` som sökvägen om inga argument överförs.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `Load`

</div>
  <div class="card-body">
    <div class="card-title">

Samma som `YAML::XS::Load`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `Dump`

</div>
  <div class="card-body">
    <div class="card-title">

Samma som `YAML::XS::Dump`.

</div>
<p class="card-text">
</p>
</div>
</div>
  </div>

<div class="tab-pane fade" id="stats" role="tabpanel">
    <script src="/editor.md/js/chart.umd.js"></script>
    <canvas id="myChart" width="100%" height="800px"></canvas>
</div>
</div>

<script async="" type="module">
  var ctx = document.getElementById("myChart").getContext("2d");
  const response = await fetch("/dynamic/search/?regex=build%3D;lang={{lang}};as_json=1;markdown_search=1");
  if (response.ok) {
    const json = await response.json();
	const data = json.duration;
    const values = data.map(x => x[1]);
    var total = 0;
    for (var i=0; i < values.length; ++i)
        total += +values[i];
    const labels = data.map(x => "r" + x[0] + ":" + x[2] + ":" + x[3] + ":" + x[4]);
    var myChart = new Chart(
      ctx,
      {
          type: "bar",
          data: {
              labels: labels.reverse(),
              datasets: [{
                  label: "Build Duration (s)",
                  data: values.reverse(),
                  backgroundColor: "#8f99fb",
              }],
          },
          options: {
              indexAxis: "y",
              plugins: {
                  title: {
                      display: true,
                      text: (total / 60).toFixed(0) + " build minutes this month (average build duration is " + (total / values.length).toFixed(0) + " s)",
                  }
              },
              onClick: (e, elts, chart) => {
                  if (elts) {
                      const idx = elts[0].index;
                      const revision = labels[idx].split(/:/)[0];
                      document.location = "/dynamic/search/?regex=build=" + revision + ";lang={{lang}};markdown_search=1";
                  }
              },
          },
      });
  }
</script>

<!-- $Date$ $Author$ $Revision$ -->
