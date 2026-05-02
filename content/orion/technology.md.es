---
categories: ~
dependencies: '*.md.es api/index.md.es'
keywords: Rebaja, asíntota, sirena
status: borrador
title: Tecnología de Orion
---

## Versión 11.4

- DTrace &mdash; Tomamos el enfoque del fregadero de la cocina: todas nuestras herramientas de lenguaje de programación dinámica se integran con él.  Mientras que bpftrace es un buen desarrollo reciente para Linux, tener que hacer cosas útiles en el espacio de lenguaje dinámico está muy lejos, que es donde está la acción.

- ZFS &mdash; mejor con Solaris, respaldado por Oracle Support.  No acepte sustitutos.

- Zonas &mdash; proporciona aislamiento de servicio y compilaciones de sitios sandbox adecuados.

## node.js v21.6.1

- Debido a que Editor.md es **impresionante**, lo transferimos a [`node.js`](#) &mdash; WYSIWYG, independientemente del contexto del espectador (editando en nuestro IDE en línea, o navegando por el sitio de producción resultante).

## Perl v5.38.2

- {# lede #}Ahora con mod_perl v2.0.14 w/ ithreads y httpd v2.4.67 w/ event mpm.{# lede #}

## Subversión v1.14.6

- seguridad de ithread personalizada [`SVN::Cliente`](#) enlaces con agrupaciones de memoria por solicitud.

: enlaces python3 nativos (v3.8.3).

- puertos python3 roscados de svnpubsub y svnwcsub &mdash; todo el *kit y el caboodle* para el despliegue de sitios de empresa/CDN distribuidos mediante Subversion.

- completó python3 [vistavc](https://vcs.sunstarsys.com/viewvc/public/site) puerto.  Buscará una solicitud de recuperación para mis cambios aguas arriba según lo permita el tiempo.

------------

## Algunos comentarios sobre las carreteras no (¿aún?) Tomado...

<br/>

### SQL

Somos una tienda NoSQL para toda la infraestructura de nuestro sitio web, y si usted está cargado con un único punto de fallo gigante conocido como un RDBMS que conduce los activos de su sitio, por favor reconsidere un enfoque más descentralizado basado en el Jamstack y Serverless Technology. Aunque no sea nuestro. ¡Nos lo agradecerás más tarde!

### ¿Por qué no Git?

- El [`git svn`](#) puente ya existe si prefiere trabajar con git usted mismo, en lugar de utilizar el IDE en línea para Orion &trade;. ¡Tienes opciones! Es posible que obtenga aún más kilometraje de las acciones GitHub al transferir los cambios a GitHub (y al incluirlos en una acción GitHub, o en un gancho de confirmación previa, o ambos, por ejemplo) antes [`git svn dcommit`](#)- enviarlos a nuestros repositorios de Subversion para su publicación en vivo. [Aquí](https://github.com/SunStarSys/www) Es una copia en vivo, completa de la historia de las fuentes de este sitio web.

- Los árboles fuente del sitio web no son como los árboles fuente de software, en términos de cómo los alteras y los gestionas.  Están más alineados con [desarrollo basado en devops / tronco](/essays/devops) que con [`gitflow`](#). Además, los sitios gigantescos van a necesitar SSI, y tal vez un poco de CGI, para su uso: al menos para evitar el abandono masivo e irrevisible del sitio de correo de compromiso igualmente masivo. [`dif`](#) salida en los deltas de árbol de creación resultantes.

- Para saber: tratando de obtener una implementación SSI totalmente funcional de algunos locales "servidor web" que utiliza para previsualizar los cambios en algún otro sistema de creación, es un poco tonto si se detiene y piensa en ello.  Con nuestro Orion, solo tienes que crear una sucursal en svn y listo: editar, confirmar, construir, navegar y **iterar**, al instante, en un sitio web efímero servido por Apache por rama que está integrado en Orion &trade; La infraestructura de enlace bidireccional (y redireccionamiento de marcadores) de IDE.  <span class="text-primary">Sin salir nunca del navegador</span>.

- Cuando llegue el momento de migrar esos cambios al sitio de producción basado en troncos, puede optar por promocionar tanto, o tan poco, de la rama como lo considere oportuno, de vuelta al tronco.  Si el tronco ha avanzado desde que las alteraciones de la rama finalmente estaban listas para el horario de máxima audiencia, simplemente haga clic en <span class="text-white">Sincronizar</span> botón para sincronizar y fusionar tronco con su rama.  Después de comprobar dos veces los resultados de compilación de la confirmación posterior a la fusión de sincronización en el sitio web de su sucursal, siga adelante y haga clic en la <span class="text-white">Promocionar</span> enlace, seguirlo con un <span class="text-white">Confirmar</span> en la misma página con un mensaje de registro de confirmación razonable, y voilà, ahora está transmitiendo en la creación de producción de trunk.

- Si necesita distribuir y lidiar con los árboles de construcción resultantes utilizando el control de versiones, no le gustará el git a gran escala. Especialmente al integrar artefactos binarios (por ejemplo, versiones de software) o documentación de producto (heredada) (piense en doxygen o javadocs), creados con este sistema o utilizando un creador de terceros que utiliza localmente para cargar esos resultados de compilación directamente en nuestros repositorios de destino. Con nuestro enfoque, puede evitar el desorden innecesario y la hinchazón en el árbol de origen de su sitio, a diferencia de cómo funcionaría con git, utilizando ramas en un repositorio común tanto a su fuente como a la construcción de árboles.

- Subversion soporta **control de acceso detallado**, y le permite realizar desprotecciones parciales o dispersas de [`CABEZA`](#); con Git, **NO hay ACL** que NO sea en una transferencia de rama de todo o nada, y debe clonar toda la rama (que incluye el historial) antes.  Si no reconoce la necesidad de estos conjuntos de funciones solo svn, aún no ha analizado los comentarios del artículo anterior (ver más arriba).

- Para el IDE, necesitaríamos enlaces Perl de lectura y escritura para [`libgit2`](#) (que **no es proporcionado por el equipo real de desarrollo de git**, y está respaldado en gran medida por corporaciones megalíticas que NO proporcionan un IDE en línea para git como un producto SaaS comparable; y no, GitHubPara que coincida con el régimen de gestión de memoria compatible con httpd de svn y la seguridad de subprocesos POSIX (+ Perl ithreads), en un tiempo de ejecución persistente y en varios repositorios de git en disco del lado del servidor de los árboles del sitio web del cliente.  La madurez de esa infraestructura de código abierto no es financiable para 2020 en nuestra estimación, pero mantendremos el control de los desarrollos en el futuro.  Mirándote, [`Git::Raw`](#)!

- Todavía no sé cómo hacer una porcelana git segura posix-thread.  La seguridad de subprocesos en repositorios separados, pero dentro de la RAM de un proceso común, es el caso de uso, no la seguridad de subprocesos dentro de un repositorio determinado (que es una pregunta de nuez).

### ¿Por qué no Python, Ruby, Javascript o Go?

- [GIL](https://en.wikipedia.org/wiki/Global_interpreter_lock)-agregado [`mod_python`](#) todavía tiene un camino por recorrer antes de que alcance la madurez de [`mod_perl`](#) en una mpm roscada. Además, la implementación actual de nuestro producto está estrechamente integrada con la API de módulo completo del servidor Apache HTTPd, que solo [`mod_perl`](#) proporciona.

- [GIL](https://en.wikipedia.org/wiki/Global_interpreter_lock)-agregado [`mod_ruby`](#) Fue abandonado en gran medida por la comunidad de Ruby por varias razones de control de calidad.  Transferencia de las fuentes personalizadas de 5K LOC Perl 5 de Orion &trade; a un entorno de programación diferente daría como resultado aproximadamente un <span class="text-warning">10-100 globos plegables</span> del recuento de líneas de la implantación y, por consiguiente, una importante degradación del rendimiento en cualquier otro lenguaje de programación dinámico.

Para estar seguro, aquí hay una instantánea, con fecha del 19 de julio de 2020, de la parte SunStar Systems del árbol de origen de producción para todo Orion (IDE+build).  No hay mucho más involucrado más allá de nuestra [`Dotiac::DTL`](#) bifurcación.  Todo el código relacionado con la creación ya ha sido de código abierto en GitHub.  Lo que sigue siendo privado son las personalizaciones basadas en C para árboles de origen de terceros, que son diferenciadores únicos para nuestro producto.

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

- [`mod_js`](#) Nunca hizo el corte para httpd v2, mucho menos mpm roscados.

- Intentando incrustar [`GoLang`](#) En httpd, con enlaces nativos de control de versiones, sería un desafío divertido; simplemente no para mí personalmente.  Buen lenguaje con interesantes compensaciones cuando se trata de vinculación dinámica, pero un definitivo tal vez para futuras investigaciones.

- En lo que respecta al sistema de compilación Perl 5, ¡estén atentos!  *No hay razón por la que no pueda *ser portado a ningún otro lenguaje de programación, ya que el sistema de compilación está completamente aislado de Orion &trade;IDE en línea (fuera del daemon del representador Markdown basado en [`node.js`](#), que es un sistema independiente en sí mismo) por un millón de razones de seguridad / diseño arquitectónico.  Si necesitas un teaser sobre las posibilidades, mira el [`build_external.pl`](#) script over en el repositorio de Orion @SunStarSys: ASF lo utilizó para todo tipo de cosas que no tenían ninguna necesidad apremiante de un sistema de gestión de dependencias.

- Sí, la trayectoria de popularidad de Perl rastrea irónicamente la de COBOL, o incluso Common Lisp, a pesar del dominio de Unix en el mercado de servidores; pero algunas cosas envejecen mejor que otras. El sólido (y único Perl) [`Hilo`](#) ingeniería de [`p5p`](#), en preparación para la llegada de Perl 7, es una buena noticia para los desarrolladores de mod_perl que aún se aferran a la visión original de Doug MacEachern.  Si te encuentras hasta las rodillas en más de 100 fuentes de LOC Perl para obtener lo que necesitas de nuestro actual sistema de construcción solo de Perl, hablemos &mdash;  Tal vez podamos colaborar en algo menos complejo para que usted pueda utilizar para construir su sitio.  Menos es más con Perl.

### ¿Por qué no con algo basado en JVM?

-  De esa manera, habida cuenta de mis 20 años de historia con la pila LAMP y de las contribuciones constructivas a la extensa comunidad de servidores web de Apache HTTPd.  Hable, pero de nuevo una empresa masiva con muchos problemas de ingeniería difíciles de resolver en el camino.

--------

## Índice

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
