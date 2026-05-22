---
categories: ~
dependencies: '*.md.es'
keywords: DESCANSO, APIO
status: verificado=39358
title: Orion API - Biblioteca de plantillas de Django
---

<div class="right">

![Sistemas SunStar](../../images/sunstarstaronly)

</div>

{# lede #}En este documento se tratan las API de filtro de **biblioteca de plantillas de Django (DTL)**{# lede #}.

[TOC]

## Django 1.0 Etiquetas

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

## Extensiones de filtro Django 1.0 ([Dotiac::DTL::Filtro](https://github.com/SunStarSys/orion/blob/master/lib/Dotiac/DTL/Filter.pm))

-----

#### `append`

Toma un único argumento y agrega su valor a la entrada filtrada.  El argumento puede ser un nombre var o una cadena entre comillas; este filtro será inteligente sobre `/` personajes que se unen en `append`.

-----

#### `cuts`

Me gusta `cut`, pero el argumento se toma como una subcadena para eludir, en lugar de una lista de caracteres.

-----

#### `lede`

Extrae el texto entre la &#123;# `lede` #&#125; bloques en la cadena de entrada filtrada.

-----

#### `ssi`

Evalúa de forma recursiva todo Django `ssi` etiquetas en la cadena de entrada filtrada.

-----

#### `starts_with`

Prueba de coincidencia de prefijos.

-----

#### `dirname`

Devuelve el tradicional `UNIX dirname` de la ruta en la cadena de entrada filtrada.

-----

#### `parse_filename`

Interfaz para [`SunStarSys::Util::parse_filename`](build#-code-parse_filename-path-code-). La diferencia clave es que los dos primeros valores devueltos de esa subrutina se intercambian y todas las extensiones de ruta se desglosan (con `.` prefijado) en argumentos individuales, lo que permite que este filtro tome una cadena de argumentos que representa una lista de índices en la matriz resultante. Como caso especial, un argumento que termina en `..` Unirá *todas* las extensiones analizadas hasta el final de la cadena resultante.

-----

#### `basename`

Devuelve el tradicional `UNIX basename` de la ruta en la cadena de entrada filtrada. Pasando un argumento de `0` a este filtro hará que se eliminen todas las extensiones de archivo de la cadena resultante.

-----

#### `tex2md`

Transformaciones $$\LaTeX$$ fuentes en Markdown+$$\KaTeX$$ fuentes. Experimental.

-----

#### `md2tex`

Transformación inversa de la calidad de producción de `tex2md`.

-----

#### `vcs_date`

Toma un `lang` argumento para proporcionar una representación específica de la configuración regional del día, mes y año del cambio más reciente presentado por el `$Date` Palabra clave de subversión en la cadena de entrada filtrada (que suele ser la completa) `content` del recurso actual).

-----

#### `vcs_time`

Representa el desfase numérico de hora, minuto, segundos y zona horaria del cambio más reciente presentado por el `$Date` Palabra clave de subversión en la cadena de entrada filtrada.

-----

#### `vcs_author`

Presenta un `safe` `HTML` Representación del usuario que actualizó el contenido más recientemente, según lo registrado por la palabra clave Subversion `$Author` palabra clave en la cadena de entrada filtrada.  Toma un opcional `lang` argumento para una representación específica de la configuración regional.

-----

#### `vcs_revision`

Presenta el número de revisión numérica del cambio más reciente en el contenido, según lo registrado por la `$Revision` palabra clave en la cadena de entrada filtrada.

-----

#### `strip_prefix`

Extrae el prefijo (ruta), transferido como argumento a este filtro, de la cadena de entrada filtrada (ruta). El prefijo por defecto es la expresión regular `\S+/content/` en caso contrario.

-----

#### `selectattr`

Busca el primer atributo de etiqueta html coincidente, con el nombre de atributo transferido como argumento a este filtro.

-----

#### `shuffle`

Mezcle la matriz.

-----

#### `img`

Tome la primera imagen HTML5/Markdown del contenido filtrado.

-----

#### `pdl_*`

Completo [`PDL`](https://metacpan.org/pod/PDL) API.  Al transferir este filtro, una referencia de matriz como argumento provocará que se anule la referencia de matriz para que sus elementos se puedan transferir directamente a la `pdl_` método con prefijo que invoca este filtro.

-----

#### `grep`

Igual que la conocida utilidad UNIX/Perl; se transfiere una expresión regular como argumento y se filtra el no`PCRE`-coincidencia de orígenes.

-----

#### `code`

Extrae una matriz de `GFM` código vallado bloquea fuera de la fuente; se le pasa el nombre / tipo de los bloques de código que desea.

<!-- $Date$ $Author$ $Revision$ -->
