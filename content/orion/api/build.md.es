---
archived: ~
categories: ~
dependencies: '*.md.es '
keywords: RESTO,API
published: ~
status: borrador
title: API de Orion - Crear
---

{# lede #}En este documento se tratan las API del **sistema de creación**{# lede #}

[TOC]

----

## Sistema de creación

### [SunStarSys::Ver](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm).

#### single_narrative(%args).

Argumentos obligatorios:

- [`plantilla`](#)
- [`ruta`](#)
- [`lang`](#).

Argmuents opcionales:

- [`deps`](#)
- [`quick_deps`](#)
- [`preprocesamiento`](#)
- [`archive_root`](#)
- [`category_root`](#).

#### news_page(%args).

#### sitemap(%args).

Índice de dependencias ordenado específico de la configuración regional.

Argumentos obligatorios:

- [`ruta`](#)
- [`lang`](#).

Argumentos opcionales:

- [`quick_deps`](#)
- [`anidado`](#)
- [`preprocesamiento`](#).

#### asymptote(%args).

Ensamblajes y cachés [`asínto`](#).

Argumentos obligatorios:

- [`ver`](#)
- [`lang`](#)
- [`ruta`](#).

#### omitir(%args).

No los construyas en absoluto.  En su lugar, cree los archivos de origen generados asociados (por ejemplo, `.bib\$lang` $$\mapsto$$ `\$base.page/bibliography.yml\$lang`

#### yml2ext(%args).

Convertir archivos YAML.

Argumentos opcionales:

- [`ext`](#) valores por defecto `json`
- [`filtro`](#) valores por defecto `json_raw`
-[`plantilla`](#) sustituciones `filtro`

#### fetch_deps($path, $data, $quick).

Argumentos obligatorios:

- [`ruta`](#)
- [`datos`](#) - Almacenes resultantes en una matriz de deps
- [`rápido`](#).

#### breadcrumbs($path).

Devuelve la lista de rutas de navegación HTML para [$ruta](#).

#### memoize(%args).

almacena en caché la compilación; se utiliza principalmente con fetch_deps y quick_deps > 2.

#### compress(%args).

En desuso.

#### next_view(%args).

Utilidad para procesar $args{view}.

#### ssi(%args).

Evaluaciones recursivas [ssi](#).

#### offline(%args).

Ejecuta next_view en modo fuera de línea.

#### snippet(%args).

Permite procesar líneas de fragmentos.

#### reconstruct(%args).

Vuelve a procesar las directivas de plantilla en el contenido creado de next_view.

#### trim_local_links(%args).

Recorta extensiones de archivo desde enlaces locales.

#### normalize_links(%args).

Normaliza los enlaces locales (./ y ../).

----

### [SunStarSys::Util](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Util.pm).

#### read_text_file($file, $out, $content_lines).

Analiza cabeceras + contenido del archivo codificado UTF-8 [`Archivo $`](#) y almacena los resultados en [`$out`](#). [`$content_lines`](#) es el número máximo (opcional) de líneas de contenido para leer.


[`Archivo $`](#) puede ser una referencia a una cadena raw, que representa el contenido completo de un archivo.  Los resultados en [`$out`](#).

#### copy_if_newer($src, $dest).

Copias [`Origen $`](#) para [`$est`](#) si el registro de hora de modificación del primero es más nuevo que el del segundo. Al copiar, además gzip-comprime el [`$est`](#).

#### get_lock(archivo_bloque).

Realiza un bloqueo (f) exclusivo (para el proceso UNIX actual) activado [`Archivo $lock`](#).

#### mezclar(\\@deck).

aleatorio (Fisher-Yates) barajado de [`@deck`](#).

#### sort_tables($content).

Ordena las tablas de rebaja en $content según la especificación de columna de cada tabla.  Se puede ordenar exactamente una columna por tabla, opcionalmente numérica [`n`](#), ya sea descendente [`v`](#) o ascendente [`^`](#).

#### fixup_code($prefix, $type, @\_).

Borra $prefix de cada argumento en @\_. La función del argumento $type es específica de la implantación, pero se utiliza principalmente para iniciar el "modo" editor.md para procesar este contenido en @\_.

#### unload_package($pkg).

Descarga agresivamente el paquete Perl [`$paquete`](#).

#### purge_from_inc(@paths).

Elimina [`@paths`](#) desde [`@INC`](#).

#### contacto(@\_).

Toca todos los archivos en [`@_`](#). Si no se transfieren argumentos, se utilizan [`$_`](#).

#### normalize_svn_path(@\_).

Normaliza todas las rutas de [`@_`](#) para un uso seguro como argumentos [`SVN::Cliente`](#).

#### sanitize_relative_path(@\_).

Protege las rutas en [`@_`](#) para su uso como rutas relativas puras en [`Dotiac::DTL`](#).

#### parse_filename(ruta $).

Envoltorio alrededor [`Archivo::Basename::fileparse`](#). Sin argumentos, utiliza [`$_`](#).

#### walk_content_tree(código $).

Pasea condicionalmente por [`. / contenido`](#) árbol de la salida del sistema de creación, primera normalización [`$_`](#) como subruta formal y, a continuación, llamar a [`Código $`](#).

##### archived($path).

Indicadores cada [`Estado: archivo`](#) [`$ruta`](#). Usos [`$_`](#).

##### seed_file_deps(ruta $).

Actualizaciones [`%path::dependencias`](#) para esto [`$ruta`](#), basado en su [`Dependencias`](#) glob de cabecera. Se utiliza por defecto [`$_`](#).

##### seed_file_acl(ruta $).

Actualizaciones [`@path::acl`](#) para esto [`$ruta`](#), basado en su [`ACL`](#) especificación de cabecera Se utiliza por defecto [`$_`](#).

#### Carga

Igual que [`YAML::XS::Cargar`](#).

#### Volcado

Igual que [`YAML::XS::Volver`](#).

<!-- $Date: 2024-04-14 02:05:29 +0000 (Sun, 14 Apr 2024) $ $Author: joe $ $Revision: 22295 $ -->
