---
categories: ~
dependencies: '*.md.es'
keywords: DESCANSO, APIO
status: borrador
title: API de Orion - Crear
---

{# lede #}En este documento se tratan las API **Crear sistema**{# lede #}.

Básicamente, el sistema de creación se rige por dos módulos Perl proporcionados por el usuario: [`lib/path.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm) y [`lib/view.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/view.pm).

El trabajo del primero es hacer tres cosas:

0. carga [`lib/facts.yml`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/facts.yml) y [`lib/acl.yml`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/acl.yml),
1. construcción `@path::patrones`y
2. oportunista caminar `contenido/` árbol para sembrar `%path::dependencias` y `@path::acls` de los metadatos de cabecera del archivo markdown/yaml.

El trabajo de este último es proporcionar invocable `vista`basado en `Método $`s para las entradas coincidentes en `@path::patrones` (como un nombre de método de cadena en la segunda ranura de cada entrada arrayref), invocado por el [creación de scripts](https://github.com/SunStarSys/orion/blob/master/build_site.pl#L219-L258) como abajo ...

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

Muchas vistas están destinadas a ser apiladas como "filtros" para preprocesar aspectos del archivo en `$ruta` que son novedosas, como el código externo `fragmentos` o `asíntota`-bloques de rebaja vallados. Se puede ver un ejemplo de ello [aquí](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm#L53).

[TOC]

----

## Sistema de creación

### [SunStarSys::Ver](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm) &mdash; clase base para `lib/view.pm`

<div class="card border-primary mb-3">
  <div class="card-header">

#### `single_narrative(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

La vista más popular (y sofisticada)

</div>

<p class="card-text">

Esta vista incorpora el procesamiento automatizado de archivos ubicados dentro de la `$ruta`directorio de anexos. Es decir, si `$ruta = "/es.md.es"`, a continuación, los archivos almacenados en el  `/foo.page/` directorio asociado con el ".en" extensión lingüística se incorporará en la plantilla de argumentos direccionables para que `$ruta` independientemente del `preprocesamiento` configuración del argumento &mdash; que, si es cierto, también haría que ese material fuera accesible por el propio contenido de la **página**.

Argumentos obligatorios:

- `plantilla`
- `ruta`
- `lang`

Argumentos opcionales:

- `deps` &mdash; sustituye a normal `fetch_deps` proceso

- `quick_deps` &mdash; configuración de optimización interna de proceso de deps; mejor dejar sin configurar

- `preprocesamiento` &mdash; permite el procesamiento de plantillas en `$ruta` contenido en sí,

- `archive_root` &mdash; archivos en "archivado" estado son "copiado" y rastreado por subcarpetas de año/mes a esta ubicación de contenido a través de `ssi`,

- `category_root` &mdash; elementos en la "categorías" cabecera son "copiado" en carpetas de categorías con nombre adecuado en esta ubicación con raíz de contenido mediante `ssi`.

</p>
  </div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `news_page(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Para páginas de agregación (varias descripciones)

</div>

<p class="card-text">

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `mapa del sitio (%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Para crear las páginas index.html y sitemap.html

</div>

<p class="card-text">

Índice de dependencias ordenado y específico de la configuración regional.

Argumentos obligatorios:

- `ruta`
- `lang`

Argumentos opcionales:

- `quick_deps`
- `anidado`
- `preprocesamiento`

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `asíntota(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Compilaciones y cachés [`Asíntota`](https://asymptote.sourceforge.io/) bloques de código con comillas dobles para gráficos vectoriales activados para lienzo HTML5-WebGL

</div>
<p class="card-text">

Argumentos obligatorios:

- `vista`
- `lang`
- `ruta`

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `omitir(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

No los construyas en absoluto.

</div>
<p class="card-text">

En su lugar, cree los archivos de origen generados asociados (por ejemplo, `.bib\$lang` $$\mapsto$$ `\$base.page/bibliography.yml\Lang`) que se va a crear en una ejecución de sistema de creación secundaria.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `yml2ext(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Convertir archivos YAML, normalmente en JSON.

</div>
<p class="card-text">

Argumentos opcionales:

- `Extensión` valores por defecto para `json`
- `filtro` valores por defecto para `json_raw`
- `plantilla` sustituciones `filtro` expresión predeterminada

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

#### `fetch_deps($path, $data, $quick)`

</div>
  <div class="card-body">
    <div class="card-title">

Refactores $data argumento hashref como una referencia de matriz ordenada de registro de hora de arrayrefs de 2 elementos.

</div>
<p class="card-text">

La primera entrada en cada arrayref de 2 elementos es el nombre de ruta de archivo, el segundo elemento es el resultado [`read_text_file`](#) hashref para ese nombre de ruta.

Devuelve una lista de los nuevos archivos de origen resultantes si [`$quick > 2`](#).

Argumentos obligatorios:

- `ruta`
- `datos` - entrada como hashref; almacena el anon-array resultante de deps a la vuelta
- `rápido` - se define por defecto en 2

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

#### `rutas de navegación ($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Devuelve la lista de rutas de navegación HTML para `$ruta`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `memorizar(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Almacena en caché la creación; se utiliza principalmente con fetch_deps y quick_deps > 2.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `comentario(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Genera un fragmento HTML que no se puede incluir en la SSI para un comentario de página.

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

Utilidad para el procesamiento secuencial `$args{vista}`.

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

Evalúa recursivamente `ssi` etiquetas.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `fuera de línea(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Ejecuta el `next_view` en modo fuera de línea.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `fragmento (%args)`

</div>
  <div class="card-body">
    <div class="card-title">

[Procesa el código externo](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Value/Snippet.pm#L12-L13) [líneas de fragmento](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm#L806), normalmente importando sus ubicaciones de origen en GitHub en bloques de rebaja con aislamiento específicos del lenguaje de programación. [Ejemplo aquí](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/content/joe/perl7-sealed-lexicals.md.en#L135).

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `reconstruir(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Vuelve a procesar las directivas de plantilla en contenido creado a partir de next_view.

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

Extensiones de archivos Trims desde enlaces locales.

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

Normaliza los enlaces locales (`./` y `../`).

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

Anexos `$args{lang}` a `$args{plantilla}`.

</div>
<p class="card-text">
</p>
</div>
</div>

----

### [SunStarSys::Util](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Util.pm) &mdash; biblioteca de utilidades para `lib/path.pm` y `lib/view.pm`

#### read_text_file($file, $out, $content_lines) &mdash; Procesador de archivos de texto universal de Orion

Analiza cabeceras+contenido de archivo codificado UTF-8 `$archivo` y almacena los resultados en hashref `$out`. `$content_lines` es el número máximo (opcional) de líneas de contenido que se van a leer.

Devuelve el número real de líneas leídas (incluidas las cabeceras).

`$archivo` puede ser una referencia a una cadena raw, que representa el contenido completo de un archivo.  Los resultados en `$out` seguirá siendo UTF-8 codificado.

#### copy_if_newer($src, $dest)

Copias `$Src` a `$dest` si el registro de hora de modificación del primero es más reciente que el segundo. Al copiar, además, gzip-comprime el `$dest` archivo si es un archivo de texto y agrega ".gz" extensión del nombre.

#### get_lock($lockfile)

Toma un bloqueo exclusivo (f) (para el proceso UNIX actual) en `Archivo de bloqueo`.

#### aleatorio(\\&#64;cubierta)

aleatorio in situ (Fisher-Yates) de `@deck`.

#### sort_tables($contenido)

Ordena las tablas de rebaja en $content según la especificación de columna de cada tabla.  Se puede ordenar exactamente una columna por tabla, opcionalmente numéricamente `n`, ya sea descendente `v` o ascendente `^` orden.

#### fixup_code($prefix, $type, &#64;_)

Extrae $prefix de cada argumento en &#64;\_. La función del argumento $type es específica de la implantación, pero se utiliza principalmente para rellenar editor.md "modo" para procesar este contenido en &#64;_.

#### unload_package($pkg)

Descarga agresivamente el paquete Perl (hoja) `$paquete` de la tabla de símbolos (STASH).

#### purge_from_inc(&#64;rutas)

Elimina `@paths` desde `@INC`.

#### toque(&#64;_)

Toca todos los archivos en `@_`. Si no se transfiere ningún argumento, utiliza `$_`.

#### normalize_svn_path(&#64;_)

Normaliza todas las rutas en `@_` para un uso seguro como argumentos crudos para `SVN::Cliente` comandos.

#### sanitize_relative_path(&#64;_)

Asegura rutas en `@_` para su uso como caminos relativos puros en `Dotiac::DTL` (Django Template) comandos específicos de la ruta.

#### parse_filename(ruta de $)

Envoltorio alrededor `Archivo::Basename::fileparse`. Sin argumentos, utiliza `$_` como nombre de archivo que se va a analizar.

#### walk_content_tree(código $)

Camina condicionalmente el `./ Contenido` árbol de la salida del sistema de creación, primero normalizando `$_` como la subruta raíz de contenido formal y, a continuación, invocando `$code->()` en cada elemento del árbol-camino. Para la mayoría de las construcciones, el paseo nunca sucede &mdash; en su lugar, la compilación se basa en los datos almacenados en caché de compilaciones anteriores.

La única manera de forzar un paseo es estableciendo `$ruta::use_cache` a un valor falso en los módulos proporcionados por el usuario. De lo contrario, este comportamiento es gestionado por expertos por el [tecnología de compilación incremental](https://iconoclasts.blog/joe/dependencies).

Devuelve 1 si el recorrido realmente se ha realizado, en lugar de depender de datos almacenados en caché. De lo contrario, devuelve un valor falso.

##### archivado($path)

Marca cada `Estado: archivado` `$ruta` (de una manera específica del lenguaje natural). Usos `$_` si no se transfieren argumentos.

Archivar archivos es una forma natural de decirle a Orión "dejar de prestar atención a la ubicación de enlace permanente de este archivo ... a menos que se vuelva a actualizar, en cuyo caso se refrescará la ubicación de archivado. En particular, los archivos archivados no aparecen en los listados de directorios dentro del propio CMS; debe navegar a la página activa para poder editarla nuevamente en línea.

##### seed_file_deps(ruta de $)

Actualizaciones seguras `%path::dependencias` para ello `$ruta`, basándose en su `dependencias` glob(es) de cabecera. Se utiliza de forma predeterminada `$_` como ruta si no se transfieren argumentos.

##### seed_file_acl(ruta de $)

Actualizaciones seguras `@path::acl` para ello `$ruta`, basándose en su `ACL` especificación de cabecera. Se utiliza de forma predeterminada `$_` como ruta si no se transfieren argumentos.

#### Cargar

Igual que `YAML::XS::Cargar`.

#### Volcado

Igual que `YAML::XS::Volcado`.

<!-- $Date$ $Author$ $Revision$ -->
