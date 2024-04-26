---
archived: ~
categories: ~
dependencies: '*.md.es api/index.md.es'
keywords: Rebaja, asíntota, sirena
published: ~
status: borrador
title: Tecnología Orion
---

## Solaris 11.4

- DTrace &mdash;

- ZFS &mdash;

- Zonas &mdash;

## node.js versión 21.6.1

- Debido a que Editor.md es **impresionante**, lo hemos transferido a [`node.js`](#) &mdash;

## Perl v5.38.2

- {# lede #}Ahora con mod_perl v2.0.13 w/ ithreads y httpd v2.4.58 w/ event mpm.{# lede #}

## Subversión v1.14.4

- seguro de ithread personalizado [`SVN::Cliente`](#).

- enlaces python3 nativos (v3.8.3).

- puertos python3 roscados de svnpubsub y svnwcsub &mdash;

- ha terminado python3 [visor](https://vcs.sunstarsys.com/viewvc/public/site).

------------

## Algunas observaciones sobre las carreteras no (¿todavía?) Tomado...

<br/>

### SQL

Somos una tienda NoSQL para toda la infraestructura de nuestro sitio web, y si está cargado con un punto único de fallo gigante conocido como un RDBMS que maneja los activos de su sitio, reconsidere un enfoque más descentralizado basado en la tecnología #Jamstack y Serverless. Aunque no sea nuestra. ¡Nos lo agradecerás más tarde!

### ¿Por qué no Git?

- El [`svn de git`](#) bridge ya existe si prefiere trabajar con git usted mismo, en lugar de utilizar el IDE en línea para Orion &trade;. ¡Tienes opciones! Puede encontrar que obtiene aún más kilometraje de las acciones GitHub empujando los cambios a GitHub (y colocándolos en una acción GitHub, o un enlace de confirmación previa, o ambos, por ejemplo) antes [`git svn dcommit`](#)-en nuestros repositorios de Subversion para publicación en vivo. [Aquí](https://github.com/SunStarSys/www).

- Los árboles de origen de sitio web no son como los árboles de origen de software, en términos de cómo los alteras y manejas.  Están más alineados con [desarrollo basado en troncos/devops](/essays/devops) que con [`gitflow`](#). Además, los sitios gigantescos van a necesitar SSI, y tal vez un poco de CGI, para su uso: al menos para evitar el abandono masivo e irreprochable del sitio de correo igualmente masivo. [`diferencia`](#).

- Es decir: tratar de obtener una implementación SSI totalmente funcional de algún "servidor web" local que utiliza para obtener una vista previa de sus cambios en algún otro sistema de construcción, es un poco tonto si se detiene y piensa en ello.  Con nuestro Orion, solo creas una rama en svn y sales: editando, confirmando, construyendo, explorando y **iterando**, instantáneamente, en un sitio web efímero de Apache por rama que está integrado en Orion &trade;

- Cuando llegue el momento de migrar esos cambios al sitio de producción basado en troncos, puede optar por promocionar tanto, o tan poco, de la rama como desee, de nuevo al tronco.  Si el tronco ha avanzado desde que las modificaciones de la rama estaban listas en última instancia para el horario estelar, simplemente haga clic en el botón <span class="text-white">Sincronizar</span> para sincronizar y fusionar el tronco con la rama.  Después de comprobar dos veces los resultados de la compilación de la confirmación posterior a la fusión de sincronización en el sitio web de la sucursal, siga adelante y haga clic en el enlace <span class="text-white">Ascender</span>, realice un seguimiento con una <span class="text-white">Confirmar</span> en la misma página con un mensaje de log de confirmación razonable y, voil, ahora está emitiendo en la compilación de producción del tronco.

- Si necesita distribuir y tratar con los árboles de construcción resultantes utilizando el control de versiones, no le gustará git a gran escala. Especialmente cuando se integran artefactos binarios (por ejemplo, versiones de software) o documentación de productos (antiguos) (piense en doxygen o javadocs), creados con este sistema o mediante un creador de terceros que utiliza localmente para cargar esos resultados de compilación directamente en nuestros repositorios de destino. Con nuestro enfoque, puede evitar el desorden innecesario y la hinchazón en el árbol de origen de su sitio, a diferencia de cómo funcionaría con git, utilizando ramas en un repositorio común tanto a su fuente como a construir árboles.

- Subversion soporta **control de acceso detallado** y le permite realizar desprotecciones parciales/parciales de [`Cabeza`](#).

- Para el IDE, necesitaríamos enlaces Perl de lectura + escritura para [`libgit2`](#) (que **no es proporcionado por el equipo de desarrollo de git real**, y está respaldado en gran medida por corporaciones megalíticas que NO proporcionan un IDE en línea para git como un producto SaaS comparable; y no, GitHubpara que coincida con el régimen de gestión de memoria compatible con httpd de svn y la seguridad de subprocesos POSIX (+ Perl ithreads), en un tiempo de ejecución persistente y en varios repositorios de git en disco del servidor de árboles de sitios web de cliente.  La madurez de esa infraestructura de código abierto no es financiable para 2020 en nuestra estimación, pero seguiremos monitoreando los desarrollos en el futuro.  Mirándote, [`Git::Raw`](#).

- Todavía no sé cómo hacer una porcelana git segura de posix-thread.  La seguridad de subprocesos a través de repositorios separados, pero dentro de la RAM de un proceso común, es el caso de uso, no la seguridad de subprocesos dentro de un repositorio dado (que es una pregunta difícil).

### ¿Por qué no Python, Ruby, Javascript o Go?

- [GIL](https://en.wikipedia.org/wiki/Global_interpreter_lock)-añadido [`mod_python`](#) aún tiene un camino por recorrer antes de que alcance la madurez de [`mod_perl`](#) en un mpm roscado. Además, la implementación actual de nuestro producto está estrechamente integrada con la API de módulo completo del servidor Apache HTTPd, que solo [`mod_perl`](#).

- [GIL](https://en.wikipedia.org/wiki/Global_interpreter_lock)-añadido [`mod_ruby`](#) fue abandonado en gran medida por la comunidad de Ruby por varias razones de control de calidad.  Transferencia de las fuentes personalizadas de 5K LOC Perl 5 de Orion &trade;

Para estar seguro, aquí hay una instantánea, con fecha del 19 de julio de 2020, de la parte SunStar Systems del árbol de origen de producción para todo Orion (IDE+build).  Hay poco más involucrado más allá de nuestro [`Dotiac::DTL`](#).

```shell
joe@zeus:/x1/Orion% wc -l */lib/SunStarSys/**/*.pm
     1 build/lib/SunStarSys/ASF.pm
   128 build/lib/SunStarSys/SVNUtil.pm
   270 build/lib/SunStarSys/Util.pm
    36 build/lib/SunStarSys/Value.pm
    82 build/lib/SunStarSys/Value/Blogs.pm
    61 build/lib/SunStarSys/Value/Jira.pm
    77 build/lib/SunStarSys/Value/Mail.pm
    70 build/lib/SunStarSys/Value/SVN.pm
   106 build/lib/SunStarSys/Value/Snippet.pm
    85 build/lib/SunStarSys/Value/Twitter.pm
   378 build/lib/SunStarSys/View.pm
  1260 webgui/lib/SunStarSys/Orion.pm
   112 webgui/lib/SunStarSys/Orion/Cookie.pm
   183 webgui/lib/SunStarSys/Orion/Filter.pm
    90 webgui/lib/SunStarSys/Orion/MapToStorage.pm
    59 webgui/lib/SunStarSys/Orion/WC.pm
   194 webgui/lib/SunStarSys/Orion/WC/Add.pm
    97 webgui/lib/SunStarSys/Orion/WC/Browse.pm
   133 webgui/lib/SunStarSys/Orion/WC/Commit.pm
    79 webgui/lib/SunStarSys/Orion/WC/Copy.pm
    66 webgui/lib/SunStarSys/Orion/WC/Delete.pm
    47 webgui/lib/SunStarSys/Orion/WC/Diff.pm
   182 webgui/lib/SunStarSys/Orion/WC/Edit.pm
   116 webgui/lib/SunStarSys/Orion/WC/Mail.pm
    70 webgui/lib/SunStarSys/Orion/WC/Merge.pm
    67 webgui/lib/SunStarSys/Orion/WC/Move.pm
    52 webgui/lib/SunStarSys/Orion/WC/Production.pm
    47 webgui/lib/SunStarSys/Orion/WC/Promote.pm
    60 webgui/lib/SunStarSys/Orion/WC/Resolve.pm
    64 webgui/lib/SunStarSys/Orion/WC/Revert.pm
    82 webgui/lib/SunStarSys/Orion/WC/Rollback.pm
   123 webgui/lib/SunStarSys/Orion/WC/Search.pm
    78 webgui/lib/SunStarSys/Orion/WC/Staged.pm
    24 webgui/lib/SunStarSys/Orion/WC/Static.pm
    49 webgui/lib/SunStarSys/Orion/WC/Update.pm
   220 webgui/lib/SunStarSys/SVN/Client.pm
  4848 total
```

- [`mod_js`](#).

- Intentando incrustar [`GoLang`](#).

- En lo que respecta al sistema de construcción Perl 5, ¡manténgase sintonizado!  *No hay razón por la que no pueda * ser portado a ningún otro lenguaje de programación, ya que el sistema de construcción está completamente aislado de Orion &trade;IDE en línea (fuera del daemon del representador Markdown basado en [`node.js`](#), que es un sistema independiente en sí mismo) por un millón de razones de seguridad / diseño arquitectónico.  Si necesitas un teaser sobre las posibilidades, echa un vistazo al [`build_external.pl`](#).

- Sí, la trayectoria de popularidad de Perl rastrea irónicamente la de COBOL, o incluso Common Lisp, a pesar del dominio de Unix en el mercado de servidores; pero algunas cosas envejecen mejor que otras. El sólido (y único Perl) [`ithread`](#) ingeniería fuera de [`p5p`](#), en preparación para el advenimiento de Perl 7, es una buena noticia para los desarrolladores de mod_perl que todavía se aferran a la visión original de Doug MacEachern.  Si te encuentras hasta las rodillas en más de 100 fuentes de LOC Perl para obtener lo que necesitas de nuestro sistema de construcción actual de solo Perl, chateemos &mdash;

### ¿Por qué no con algo basado en JVM?

-  Acabo de trabajar de esa manera, dada mi historia de 20 años con la pila LAMP y contribuciones constructivas a la comunidad ampliada de servidores web Apache HTTPd.  Es factible, pero de nuevo una empresa masiva con muchos problemas de ingeniería difíciles de resolver en el camino.

--------

## Índice

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
