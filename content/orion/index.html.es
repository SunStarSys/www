{% extends "main.html" %}

{% block content %}
<div class="breadcrumbs">
	{{ breadcrumbs|safe }}
	<a href="javascript:void(location.href='https://cms.sunstarsys.com/redirect?uri='+escape(location.href)+';action=edit')">
		<img src="/images/edit.png" />
	</a>
</div>
<h1>{{ headers.title }}</h1>

<div class="jumbotron">
{% filter markdown %}
<h2>SunStar Systems Orion</h2>
<div class="row">
<div class="col-lg-5">
<span class="text-success"><em>The Original Markdown JAM Stack.</em></span>&trade;

El &nbsp; <span class="text-white">SunStar Systems Orion</span> &nbsp; es un
<ul>
<li>en línea,</li>
<li>compatible con dispositivos móviles,</li>
<li>rentable,</li>
<li>rendimiento máximo,</li>
</ul>
<span class="text-white">Sistema de administración de contenido (Orion)</span> y <span class="text-white">Entorno de desarrollo integrado (IDE)</span> para **crear, administrar y entregar contenido estático del sitio web**, potencialmente con algunos [CGI](https://en.wikipedia.org/wiki/Common_Gateway_Interface) / [SSI](https://en.wikipedia.org/wiki/Server_Side_Includes) u otro servidor -características complementarias de contenido dinámico incorporadas.

Para obtener información sobre precios, consulte nuestros [Planes Orion](plans).

<h3>Aquí está el discurso, responsable de la toma de decisiones ejecutivas...</h3>
Lo que diferencia a este producto de nuestros competidores es la [Tecnología Orion](technology), y cómo nos permite mantener costos operativos muy bajos al mismo tiempo que proporciona controles editoriales superiores y funciones innovadoras. Pasamos los ahorros de costos a nuestros **clientes**, con solo recargos marginales por recursos adicionales del proveedor de la nube. [Llámanos](/contact), **especialmente** si eres
<ul>
<li>un <span class="text-white">tomador de decisiones del sector de defensa/gobierno de TI</span> con FedRAMP/[NIST 800-207](https://www.nist.gov/publications/zero-trust-architecture) necesidades de cumplimiento, o requisitos de control de acceso detallados en el repositorio de control de versiones de su sitio,</li>
<li>un <span class="text-white">ejecutivo de marketing</span> que desea una plataforma empresarial innovadora para administrar los activos de su sitio web corporativo,</li>
<li>una <span class="text-white">empresa de tecnología/líder de agencia de sitios web</span> con una gran cantidad de documentación de productos en línea o sitios de clientes (que potencialmente ofrecen descargas binarias) para seleccionar,</li>
<li>un <span class="text-white">arquitecto de alta disponibilidad basado en principios</span> cansado de lidiar con puntos únicos de falla inherentes a las pilas LAMP basadas en SQL,</li>
<li>o realmente cualquier persona de negocios insatisfecha con la estructura de costos de cualquier cosa de Orion, incluidas las ofertas gratuitas que reducen el tiempo y la energía de su personal.</li>
</ul>

*No hay bloqueo de proveedor involucrado con nuestra oferta*. Pero no confíe solo en nuestra palabra, vea por sí mismo lo que normalmente implica en términos de personalización del sistema de compilación visitando

[nuestro árbol de librerías de origen viewvc](https://vcs.sunstarsys.com/viewvc/public/Orion-sites/www.sunstarsys.com/trunk/lib/).

Menos de <span class="text-info">100 LOC</span> para proporcionar la lógica de creación de este sitio web, e incluye una gestión de dependencias sofisticada y memorizada para la generación automática de un [SiteMap](/sitemap) multilingüe y todos los índices de directorio (como [esta parte](#Detalles) de esta página en particular). Incluso colocamos el [Generador de sitios estáticos para la compilación en GitHub](https://github.com/SunStarSys/Orion) bajo la Licencia Apache 2.0.

</div>

<div class="col-lg-7">
	<div class="embed-responsive embed-responsive-16by9">
	 	<iframe class="embed-responsive-item" style="max-width:560;max-height:315" src="https://www.youtube.com/embed/96m8G9jCiyA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	</div>
	<div style="height:20px">&nbsp;</div>

<h3>He aquí por qué, desarrollador de pila completa/bloguero público/gurú de DevOps...</h3>
¿Quieres un sitio web que sea **seguro por defecto**? ¿Fácil de actualizar y administrar, al tiempo que oculta la complejidad de un sistema de control de versiones subyacente, pero le brinda todo su poder cuando realmente lo necesita? Publicación instantánea cuando lo desee; construcciones de sucursales por etapas y sin problemas y promociones granulares personalizables para su sitio de producción, según se adapte al flujo de trabajo preferido de su equipo.

Si está cansado de las opciones de licencias por puesto y ciclo de CPU que lo agobian cada vez que necesita corregir un error tipográfico, [comuníquese con nosotros](/contact). Si usted es un domador de leones equipado con expresiones regulares durante décadas de contenido HTML heredado acumulado, o simplemente alguien insatisfecho con las otras opciones en el mercado y cómo funcionan a escala, tenemos algo realmente especial para ofrecerle.

Nunca tener que lidiar directamente con un sistema de control de versiones, o incluso con un generador de sitios estáticos, en su propia computadora personal depende de usted. El IDE en línea está diseñado y listo para su **flujo de trabajo solo del navegador** siempre que lo esté. En un abrir y cerrar de ojos, incluso la interfaz móvil (navegador) lo hará, *al instante*.

Los árboles fuente de varios gigabytes simplemente no son rival para él &mdash; la duración completa de la creación del sitio se mide en *segundos*, no en horas y minutos. El sistema admite fácilmente más de [`1 GB/s`](features) mientras procesa sus fuentes para compilaciones completas del sitio, pero dada su <span class="text-white">administración de dependencias única y pendiente de patente</span> funcionalidad , casi nunca necesita recurrir a ellos:

<span class="text-success"><em>Solo construimos lo que usted necesita construir.</em></span>&trade;

Esta tecnología fue inventada por primera vez a fines de 2011 por miembros del equipo de infraestructura de Apache. La frase "[JAM Stack](https://jamstack.wtf)" fue acuñada años más tarde por un grupo que desconocía nuestro estado de la técnica en este espacio. Pero el [registro público](http://web.archive.org/web/20120112045033/http://www.apache.org/dev/Orion) es muy claro, y esta nueva oferta de SunStar Systems es testimonio de ello. legado original y sus verdaderos orígenes de código abierto.

<h4>¿Quieres darle una vuelta rápida para ver lo rápido y fácil que es?</h4>
Este sitio web es autohospedado; todos esos cuadrados de lápiz de color rosa intenso [<img src="../images/edit.png" style="width:20px">](https://cms.sunstarsys.com/redirect?uri=https://www.sunstarsys.com/index) en la parte superior derecha están en vivo. ¡Siéntete libre de hurgar y experimentar con cualquier cosa que veas! Lo único que no puede hacer es comprometerse y ver cómo se crean e implementan los cambios; eso está restringido a nuestro personal por razones obvias.

Nuestra red global de punto de presencia (POP) garantiza conexiones de baja latencia tanto al Orion como a los sitios web de entrega final que alojamos. Actualmente estamos en cuatro continentes y tenemos presencia en las dos costas de los EE. UU. Y nos estamos expandiendo rápidamente, ¡el próximo en el Este de Asia!

<h3>Es hora de un cambio radical en la forma en que administra y entrega su sitio a su público objetivo.</h3>
Vaya a su propio ritmo, use tantos empleados / vistas previas / ediciones / confirmaciones / sucursales como desee, y solo pague por lo que *realmente usa* en nuestra infraestructura.

Consulte nuestros [Planes Orion](plans) para conocer las ofertas actuales.

</div>
</div>

### Cuadrícula de comparación de características

<br />

| Característica | Sistemas SunStar | Netlify+Gatsby | GitHub+Hugo |
|:-----------|:-------------:|:------------:|:-----------:|
| IDE Orion | <span class="text-success">&check;</span> | <span class="text-warning">&check;</span> | <span class="text-info">?</span> |
| CI/CD | <span class="text-success">&check;</span> | <span class="text-warning">&check;</span> | |
| Infraestructura FedRAMP + TLS compatible con FIPS | <span class="text-success">&check;</span> | | |
| Flujo de trabajo en el navegador (compatible con dispositivos móviles) | <span class="text-success">&check;</span> | | |
| Construcciones incrementales | <span class="text-success">&check;</span> | <span class="text-warning">&check;</span> | |
| Construcciones ilimitadas de sucursales | <span class="text-success">&check;</span> | <span class="text-warning">&check;</span> | <span class="text-warning">&check; (para repositorios públicos)</span> |
| Compilaciones programadas solo de contenido dinámico | <span class="text-success">&check;</span> | | |
| Flujo de trabajo sencillo para colaboradores externos | <span class="text-success">&check;</span> | <span class="text-warning">&check;</span> | <span class="text-warning">&check;</span> |
| Vistas previas ilimitadas | <span class="text-success">&check;</span> | <span class="text-warning">Solo para empresas ($$)</span> | <span class="text-warning">&check;</span> |
| Construcciones ilimitadas | <span class="text-success">&check;</span> | <span class="text-warning">Solo para empresas ($$)</span> | <span class="text-warning">&check; (para repositorios públicos)</span> |
| Asientos Ilimitados | <span class="text-success">Solo empresas</span> | | <span class="text-warning">&check; (para repositorios públicos)</span> |
| Alojamiento de sitios web | <span class="text-success">&check;</span> | <span class="text-warning">&check;</span> | |
| Soporte de registro SSI / CGI / mod_perl | <span class="text-success">&check;</span> | | |
| ACL de grano fino en Source Repo | <span class="text-success">&check;</span> | | |
| +1 GB/s Construcciones completas del sitio | <span class="text-success">&check;</span> | | |
| Construcciones simultáneas de 8-64 vías | <span class="text-success">&check;</span> | <span class="text-warning">Solo para empresas ($$)</span> | |
| TCO &lt; $5000/año para Enterprise | <span class="text-success">&check;</span> | | |
| SLA integral del 99,99 % para empresas | <span class="text-success">&check;</span> | | |
| Integración sin servidor | ¡Próximamente a través de OCI! | <span class="text-warning">&check;</span> | |
| Elección del lenguaje de programación de compilación | ¡Próximamente, en breve, pronto! | | <span class="text-warning">&check;</span> |

<br />

### Información al consumidor sobre ofertas de SLA relacionadas con JAM Stack que puede encontrar en otros lugares...

Los consumidores informados siempre deben **preguntar** qué componentes de JAM Stack están cubiertos por SLA u obtener una garantía por escrito de que su SLA brinda una cobertura general para toda la pila, *incluidas las partes de infraestructura de compilación y Orion/IDE*. Es posible que se sorprenda con las respuestas: incluso GitHub tiene serias interrupciones de varias horas de vez en cuando, en las que muchos competidores basan todas sus ofertas. Dichos servicios con SLA nominales del **99,99 %**, que es menos de una hora al año de total tiempo de inactividad, claramente tiene algunas explicaciones que hacer, si tiene la impresión de que su paquete de servicio completo está bajo SLA. *No lo es*, solo estamos siendo sinceros contigo al respecto.

Lo que ofrecemos en cambio es un mejor esfuerzo para mantener nuestro servicio Subversion en línea **24x7x365**, con un enfoque principal en el horario comercial de EE. UU. Continental y con un objetivo competitivo de tener nuestro [SLI](https://en.wikipedia .org/wiki/Service_level_indicator) se lee favorablemente en comparación con el resto del mercado (incluido el propio GitHub, cuyos SLA giran en torno a los objetivos de tiempo de respuesta, no a la duración real de los incidentes de tiempo de inactividad). Los SLA son un ingrediente importante, por lo que los clientes empresariales disfrutarán de nuestro completo **99,99 %**, que cubre **todo** menos el propio servicio de Subversion. Nadie ofrece contratos SLA de disponibilidad general para su infraestructura de servicio de control de versiones; y debe tener cuidado al hacer negocios con alguien que lo hace en el mercado actual.

### Un vistazo bajo el capó...

El Orion hace todo esto interactuando con nuestro servicio Subversion habilitado para [svnpubsub](https://svn.apache.org/repos/asf/subversion/trunk/tools/server-side/svnpubsub/). El Orion construye automáticamente cada cambio confirmado utilizando un ultrarrápido [`node.js`](https://nodejs.org/) + [`Perl 7`](https://www.perl.com/article/anounce-perl-7/) sistema de compilación basado en el [Principio de Hollywood](https://deviq.com/hollywood-principle/): llama a los módulos Perl proporcionados por el cliente para hacer lo que el cliente necesite. (No se preocupe, hay plantillas de diseño básicas disponibles que harán todo el trabajo pesado por usted). También hace un esfuerzo adicional y distribuye instantáneamente los conjuntos de cambios para la compilación, **atómicamente**, a nuestro CDN perimetral. servidores web en nuestra red POP.

[Cumplimiento de REST](https://www.codecademy.com/articles/what-is-rest) tiene sus beneficios para los usuarios de Orion. Les gustará el hecho de que el botón <span class="text-white">Atrás</span> de su navegador no interrumpa el servicio; de hecho, es un componente esencial de la función <span class="text-white">Revertir</span>. En una situación de ruptura de sitio de emergencia, volver a la página de resultados del envío de <span class="text-white">Commit</span> incorrecto les brindará la capacidad de revertir la fusión <span class="text-white">que </span> cambio aplicado erróneo &mdash; con el clic de un botón &mdash; y reconstruir el sitio de nuevo a un buen estado conocido.

Actualmente proporcionamos un sistema de plantilla básico basado en <span class="text-white">Django</span> derivado de un [`Dotiac::DTL`](http://dotiac.sourceforge.net/cgi-bin/index.pl) módulo de CPAN. Próximamente se brindará soporte para un sistema de compilación de Python 3. El [sistema de compilación Orion](https://github.com/SunStarSys/Orion), junto con una gran colección de módulos de soporte para aprovechar dentro de ese árbol, está disponible en GitHub.


### Detalles

{% endfilter %}

{{ content|markdown}}
<hr />
<br />
<h2>Algunas capturas de pantalla representativas:</h2>
<br />
<h3>Vista IDE con Farsi (UTF-8).</h3>
<center><img src="../images/ide-fa.png" style="width:800px"></center>
<br/>
<h3>Vista del editor IDE.</h3>
<center><img src="../images/ide-editor.png" style="width:800px"></center>
<br/>
<h3>Vista del editor IDE (español).</h3>
<center><img src="../images/ide-es.png" style="width:800px"></center>
<br/>
<h3>Construcción completa del sitio IDE.</h3>
<center><img src="../images/ide-build.png" style="width:800px"></center>
<br />
<h3>Construcción típica del sitio IDE.</h3>
<center><img src="../images/ide-file-build.png" style="width:800px"></center>
<br />
<h3><a href="https://cms.sunstarsys.com/redirect?uri=https://www.sunstarsys.com/;action=search;regex=mailto:">Búsqueda IDE</a> <small>(esos enlaces en <span style="color:#e83e8c">rosa intenso</span> lo llevarán directamente a una pantalla de edición, con el cursor colocado exactamente de acuerdo con el texto coincidente)</small>.</h3>
<center><img src="../images/ide-search.png" style="width:800px"></center>
</div>

<style type="text/css">
/*-------------------------------------------
	Animations
-------------------------------------------*/
@-webkit-keyframes FADEY {
  0%   { opacity: 0; }
  100% { opacity: 1; }
}

.theme-showcase {
	-webkit-animation-name: FADEY;
	-webkit-animation-duration: 1s;
	-webkit-animation-timing-function: ease-in-out;
	-webkit-animation-iteration-count: 1;
}
</style>
{% endblock %}
