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
1. construcción [`@path::patrones`](#)y
2. oportunista caminar [`contenido/`](#) árbol para sembrar [`%path::dependencias`](#) y [`@path::acls`](#).

El trabajo de este último es proporcionar invocable [`vista`](#)basado en [`Método $`](#)'s para las entradas coincidentes en [`@path::patrones`](#) (como un nombre de método de cadena en la segunda ranura de cada entrada arrayref), se llama así...

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

[TOC]

----

## Sistema de creación

### [SunStarSys::Ver](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm) &mdash; clase base para [`lib/view.pm`](#)

#### single_narrative(%args) &mdash; La visión más popular (y sofisticada)

Argumentos obligatorios:

- [`plantilla`](#)
- [`ruta`](#)
- [`lang`](#)

Argumentos opcionales:

- [`deps`](#)
- [`quick_deps`](#)
- [`preprocesamiento`](#)
- [`archive_root`](#) &mdash; archivos en "archivado" estado son "copiado" y rastreado por subcarpetas de año/mes a esta ubicación de contenido a través de `ssi`
- [`category_root`](#) &mdash; elementos en la "categorías" cabecera son "copiado" en carpetas de categorías con nombre adecuado en esta ubicación con raíz de contenido mediante `ssi`

#### news_page(%args) &mdash; para páginas de agregación de varias descripciones

#### mapa del sitio (%args) &mdash; para crear páginas index.html y sitemap.html

Índice de dependencias ordenado y específico de la configuración regional.

Argumentos obligatorios:

- [`ruta`](#)
- [`lang`](#)

Argumentos opcionales:

- [`quick_deps`](#)
- [`anidado`](#)
- [`preprocesamiento`](#)

#### asíntota(%args)

Compilaciones y cachés [`asíntota`](#) bloques de código con comillas dobles.

Argumentos obligatorios:

- [`vista`](#)
- [`lang`](#)
- [`ruta`](#)

#### omitir(%args)

No los construyas en absoluto.  En su lugar, cree los archivos de origen generados asociados (por ejemplo, `.bib\$lang` $$\mapsto$$ `\$base.page/bibliography.yml\Lang`) que se va a crear en una ejecución de sistema de creación secundaria.

#### yml2ext(%args)

Convertir archivos YAML, normalmente en JSON.

Argumentos opcionales:

- [`Extensión`](#) valores por defecto para `json`
- [`filtro`](#) valores por defecto para `json_raw`
- [`plantilla`](#) sustituciones `filtro` expresión predeterminada

#### fetch_deps($path, $data, $quick)

Argumentos obligatorios:

- [`ruta`](#)
- [`datos`](#) - almacena el anon-array resultante de deps
- [`rápido`](#) - se define por defecto en 2

#### rutas de navegación ($path)

Devuelve la lista de rutas de navegación HTML para [$ruta](#).

#### memorizar(%args)

Almacena en caché la creación; se utiliza principalmente con fetch_deps y quick_deps > 2.

#### comentario(%args)

Genera un fragmento HTML que no se puede incluir en la SSI para un comentario de página.

#### next_view(%args)

Utilidad para procesar $args{vista}.

#### ssi(%args)

Evalúa recursivamente [ssi](#) etiquetas.

#### fuera de línea(%args)

Ejecuta next_view en modo fuera de línea.

#### fragmento (%args)

Procesa líneas de fragmento.

#### reconstruir(%args)

Vuelve a procesar las directivas de plantilla en contenido creado a partir de next_view.

#### trim_local_links(%args)

Extensiones de archivos Trims desde enlaces locales.

#### normalize_links(%args)

Normaliza los enlaces locales (./ y ../).

----

### [SunStarSys::Util](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Util.pm) &mdash; biblioteca de utilidades para [`lib/path.pm`](#) y [`lib/view.pm`](#)

#### read_text_file($file, $out, $content_lines) &mdash; Procesador de archivos de texto universal de Orion

Analiza cabeceras+contenido de archivo codificado UTF-8 [`$archivo`](#) y almacena los resultados en [`$out`](#). [`$content_lines`](#) es el número máximo (opcional) de líneas de contenido que se van a leer.
Devuelve el número real de líneas leídas (incluidas las cabeceras).

[`$archivo`](#) puede ser una referencia a una cadena raw, que representa el contenido completo de un archivo.  Los resultados en [`$out`](#) seguirá siendo UTF-8 codificado.

#### copy_if_newer($src, $dest)

Copias [`$Src`](#) a [`$dest`](#) si el registro de hora de modificación del primero es más reciente que el segundo. Al copiar, además, gzip-comprime el [`$dest`](#) archivo si es un archivo de texto y agrega ".gz" extensión del nombre.

#### get_lock($lockfile)

Toma un bloqueo exclusivo (f) (para el proceso UNIX actual) en [`Archivo de bloqueo`](#).

#### aleatorio(\\&#64;cubierta)

aleatorio in situ (Fisher-Yates) de [`@deck`](#).

#### sort_tables($contenido)

Ordena las tablas de rebaja en $content según la especificación de columna de cada tabla.  Se puede ordenar exactamente una columna por tabla, opcionalmente numéricamente [`n`](#), ya sea descendente [`v`](#) o ascendente [`^`](#) orden.

#### fixup_code($prefix, $type, &#64;_)

Extrae $prefix de cada argumento en &#64;\_. La función del argumento $type es específica de la implantación, pero se utiliza principalmente para rellenar editor.md "modo" para procesar este contenido en &#64;_.

#### unload_package($pkg)

Descarga agresivamente el paquete Perl (hoja) [`$paquete`](#) de la tabla de símbolos (STASH).

#### purge_from_inc(&#64;rutas)

Elimina [`@paths`](#) desde [`@INC`](#).

#### toque(&#64;_)

Toca todos los archivos en [`@_`](#). Si no se transfiere ningún argumento, utiliza [`$_`](#).

#### normalize_svn_path(&#64;_)

Normaliza todas las rutas en [`@_`](#) para un uso seguro como argumentos crudos para [`SVN::Cliente`](#) comandos.

#### sanitize_relative_path(&#64;_)

Asegura rutas en [`@_`](#) para su uso como caminos relativos puros en [`Dotiac::DTL`](#) (Django Template) comandos específicos de la ruta.

#### parse_filename(ruta de $)

Envoltorio alrededor [`Archivo::Basename::fileparse`](#). Sin argumentos, utiliza [`$_`](#) como nombre de archivo que se va a analizar.

#### walk_content_tree(código $)

Camina condicionalmente el [`./ Contenido`](#) árbol de la salida del sistema de creación, primero normalizando [`$_`](#) como la subruta raíz de contenido formal y, a continuación, invocando [`$code->()`](#) en cada elemento del árbol-camino. Para la mayoría de las construcciones, el paseo nunca sucede &mdash; en su lugar, la compilación se basa en los datos almacenados en caché de compilaciones anteriores.

La única manera de forzar un paseo es estableciendo [`$ruta::use_cache`](#) a un valor falso en los módulos proporcionados por el usuario. De lo contrario, este comportamiento es gestionado por expertos por el [tecnología de compilación incremental](https://iconoclasts.blog/joe/dependencies).

Devuelve 1 si el recorrido realmente se ha realizado, en lugar de depender de datos almacenados en caché. De lo contrario, devuelve un valor falso.

##### archivado($path)

Marca cada [`Estado: archivado`](#) [`$ruta`](#) (de una manera específica del lenguaje natural). Usos [`$_`](#) si no se transfieren argumentos.

Archivar archivos es una forma natural de decirle a Orión "dejar de prestar atención a la ubicación de enlace permanente de este archivo ... a menos que se vuelva a actualizar, en cuyo caso se refrescará la ubicación de archivado. En particular, los archivos archivados no aparecen en los listados de directorios dentro del propio CMS; debe navegar a la página activa para poder editarla nuevamente en línea.

##### seed_file_deps(ruta de $)

Actualizaciones seguras [`%path::dependencias`](#) para ello [`$ruta`](#), basándose en su [`Dependencias`](#) glob(es) de cabecera. Se utiliza de forma predeterminada [`$_`](#) como ruta si no se transfieren argumentos.

##### seed_file_acl(ruta de $)

Actualizaciones seguras [`@path::acl`](#) para ello [`$ruta`](#), basándose en su [`ACL`](#) especificación de cabecera. Se utiliza de forma predeterminada [`$_`](#) como ruta si no se transfieren argumentos.

#### Cargar

Igual que [`YAML::XS::Cargar`](#).

#### Volcado

Igual que [`YAML::XS::Volcado`](#).

<!-- $Date$ $Author$ $Revision$ -->
