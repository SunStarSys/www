---
categories: ~
dependencies: '*.md.es api/index.md.es'
keywords: ~
status: borrador
title: Referencia de Orion
---

<div class="lg right">
	<img src="../images/sunstarstaronly.png">
</div>

## Demostración en directo

Para una demostración de Orión &trade;IDE, visite <https://www.openoffice.org/> para un sitio masivo, o <https://thrift.apache.org/> para obtener una intrincada, y haga clic en el marcador anterior para ver un prototipo en vivo en acción.

Si eso es demasiado molesto para usted, este sitio web se aloja automáticamente en Orion &trade;y {# lede #}esos iconos de lápiz rojo oscuro [<span class="text-danger-emphasis">:fa-file-edit:</span>](javascript:location.href='https://cms.sunstarsys.com/redirect?uri='+location.href) en la parte superior derecha junto a las migas de pan le dará una demostración en vivo{# lede #} de cómo funciona el sistema (sin acceso de confirmación/creación, que está bloqueado únicamente para el personal).

## Bookmarklet recomendado

Por favor, asegúrese de instalar el marcador en la barra de herramientas de su navegador abriendo un "Nuevo marcador" Pantalla de diálogo del menú del explorador y escribiendo lo siguiente en el campo Ubicación/URL:

```javascript
	javascript:void(location.href='https://cms.sunstarsys.com/redirect?uri='+escape(location.href))
```

Sin este bookmarklet instalado no podrás navegar por el sitio en directo y editar páginas al instante en Orion &trade; haciendo clic en el bookmarklet.

Para usar el marcador simplemente navegue a su sitio de producción en vivo (NO en Orion) &trade;!), busque la página que desea editar y haga clic en el marcador. Usted será llevado a una página dentro de este Orion que le permite editar el contenido.

## Guía de introducción

<div class="embed-responsive embed-responsive-16by9">
	 	<iframe class="embed-responsive-item" style="max-width:560;max-height:315" src="https://www.youtube.com/embed/4-KiEDFbzl4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	</div>
	<p style="height:20px">&nbsp;</p>

## IoC API de compilación

[snippet:lang=perl:repo=SunStarSys/orion:path=README.md:token=#api]

## Proceso de vinculación

1. Proporcionarnos las fuentes de su sitio que se pueden construir a través de nuestro @SunStarSys / orion SSG.

2. Proporcionarnos la dirección de correo electrónico (rol, o lista de correo) para analizar los problemas de desarrollo y mantenimiento del sitio, y garantizar que la dirección sea [SRS](https://en.wikipedia.org/wiki/Sender_Rewriting_Scheme)-compatible en términos de facilidades de moderación.

## Diseño de directorio de origen

- tronco/
	- cgi-bin/
	- contenido/
	- plantillas/
	- lib/
		- path.pm
		- view.pm
- sucursales/
	.. cada rama sigue el diseño del tronco por encima ...

Ver <https://github.com/SunStarSys/www.iconoclasts.blog/tree/trunk> para un ejemplo vivo.

## Contenido dinámico

### Script de ejemplo para volver a generar una página de origen con el cambio de contenido, incluso cuando los orígenes no lo hacen.

La idea básica es que algunas de sus páginas de origen de alto perfil construyen con "dinámica" contenido (build incorpora fragmentos en constante cambio de otros sitios en línea, como cascadas de Jira o hilos de listas de correo actuales).

Un buen ejemplo de ello es "Últimas noticias" sección de [Página de inicio de ASF](https://www.apache.org/), y aquí está la forma detrás de escena en que funciona, con un poco de magia shell+svn+cron como se ejemplifica aquí (tome el archivo de origen de la compilación dinámica como `$file` abajo):

```shell
% cp $file $file.tmp
% svn rm $file
% mv $file.tmp $file
% svn add $file
% svn commit -m "rebuild $file"
```

Incorpore esto en un pequeño script de shell que usará sus credenciales svn almacenadas en caché en su propio PC y haga que cron lo ejecute por usted en un horario fijo (basado en su TTL de TTL de caché HTTP de servidor web / CDN de frontend).  Sin necesidad de herramientas del lado del servidor; usted tiene control total de su propia seguridad de contraseña, programación y destinos de página dinámica.  Si utiliza su propio servicio Subversion habilitado para svnpubsub, ninguna de esas transacciones involucra directamente a nuestro hardware. Su confirmación activará nuestro cliente svnwcsub, siempre escuchando su servidor svnpubsub, para crear e implementar esos cambios bajo demanda &mdash; pronto.

## Excepciones

Por determinar

## Buscar

Por determinar

## Confirmación rápida

Por determinar

## Agregar recurso

Por determinar

--------

## Índice

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
