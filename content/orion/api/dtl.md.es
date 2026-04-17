---
archived: ~
categories: ~
dependencies: '*.md.es'
keywords: RESTO,API
published: ~
status: borrador
title: API de Orion - Biblioteca de plantillas de Django
---

{# lede #}En este documento se tratan las API de **Biblioteca de plantillas de Django (DTL)**{# lede #}

[TOC]

----

## DTL (Biblioteca de plantillas de Django 1.0).

Extensiones de filtro de Django 1.0 ([Dotiac::DTL::Filtro](https://github.com/SunStarSys/orion/blob/master/lib/Dotiac/DTL/Filter.pm).

#### agregar

Toma un único argumento y agrega su valor a la entrada filtrada.  El argumento puede ser un nombre de variable o una cadena entre comillas; este filtro será inteligente sobre `/` personajes que se unen en [`agregar`](#).

#### recortes

Me gusta [`corte`](#).

#### led

Extrae el texto entre el &#123;# [`LED`](#) #&#125;

#### ssi

Evaluar de forma recursiva todos los Django [`ssi`](#).

#### starts_with

Pruebas de coincidencia de prefijo.

#### nombre de directorio

Devuelve el UNIX tradicional [`nombre de dir`](#).

#### parse_filename

Interfaz para [`SunStarSys::Util::parse_filename`](#). La diferencia clave es que los dos primeros valores de retorno de esa subrutina se intercambian y las extensiones de ruta de acceso se desglosan (con [`.`](#) prefijado) en argumentos individuales, lo que permite a este filtro tomar una cadena de argumentos que representa una lista de índices en la matriz resultante. Como caso especial, un argumento que termina en [`..`](#).

#### nombre base

Devuelve el UNIX tradicional [`nombrebase`](#) de la ruta en la cadena de entrada filtrada. Aprobando un argumento de [`0`](#).

#### tex2md

Transformaciones $$\LaTeX$$ fuentes en Markdown+$$\KaTeX$$

#### md2tex

La transformación inversa de `tex2md`

#### vcs_date

Toma un [`lang`](#) argumento para proporcionar una representación específica de la configuración regional del día, mes y año del cambio más reciente presentado por el [`Fecha $`](#) Palabra clave de subversión en la cadena de entrada filtrada (que suele ser la [`contenido`](#).

#### vcs_time

Representa el desplazamiento numérico de hora, minuto, segundos y zona horaria del cambio más reciente presentado por el [`Fecha $`](#).

#### vcs_author

Presenta un [`seguro`](#) Representación HTML del usuario que actualizó el contenido más recientemente, según lo registrado por la palabra clave Subversion [`Autor de $`](#) palabra clave en la cadena de entrada filtrada.  Toma una opción [`lang`](#).

#### vcs_revision

Presenta el número de revisión numérica del cambio más reciente en el contenido, según lo registrado por el [`Revisión de $`](#).

#### strip_prefix

Borra el prefijo (path), transferido como argumento a este filtro, de la cadena de entrada (path) filtrada. El prefijo predeterminado es la expresión regular [`\S+/content/`](#).

#### mezclar

Mezclar la matriz.

#### img

Tome la primera imagen HTML5/Markdown del contenido filtrado.

<!-- $Date$ $Author$ $Revision$ -->
