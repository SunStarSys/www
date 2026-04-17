---
archived: ~
categories: ~
dependencies: '*.md.es api/index.md.es'
keywords: ~
published: ~
status: borrador
title: Referencia de Orion
---

<div class="float-lg-right">
	<img src="../images/sunstarstaronly.png">
</div>

## Demostración en directo

Para una demostración de Orión &trade;

Si eso es demasiado molesto para usted, este sitio web se aloja en Orion &trade;, y {# lede #}esos iconos de lápiz rosa [<img src="../images/edit.png" style="width:20px">](javascript:location.href='https://cms.sunstarsys.com/redirect?uri='+location.href) en la parte superior derecha junto a las migas de pan le dará una demostración en vivo{# lede #}

## Marcador recomendado

Asegúrese de instalar el marcador en la barra de herramientas de su navegador abriendo una pantalla de diálogo "Nuevo marcador" desde el menú de su navegador y escribiendo lo siguiente en el campo Ubicación/URL:

```javascript
	javascript:void(location.href='https://cms.sunstarsys.com/redirect?uri='+escape(location.href))
```

Sin este bookmarklet instalado no podrá navegar por el sitio en vivo y editar instantáneamente páginas en Orion &trade;

Para utilizar el bookmarklet simplemente vaya a su sitio de producción en vivo (NO en Orion) &trade;

## Guía de introducción

<div class="embed-responsive embed-responsive-16by9">
	 	<iframe class="embed-responsive-item" style="max-width:560;max-height:315" src="https://www.youtube.com/embed/4-KiEDFbzl4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	</div>
	<p style="height:20px">&nbsp;</p>

## IoC API de compilación

[snippet:lang=perl:repo=SunStarSys/orion:path=README.md:token=#api]

No de procesos de vinculación

Para los primeros en adoptar, Orion &trade;

1. Proporcionarnos la URL de las fuentes de su sitio en Subversion.

2. Proporcionarnos la dirección de correo electrónico (rol o lista de correo) para discutir los problemas de desarrollo y mantenimiento del sitio, y garantizar que la dirección sea [SRS](https://en.wikipedia.org/wiki/Sender_Rewriting_Scheme).

3. Suscríbete a tus servidores web de producción `svnwcsub` daemon a nuestro público `svnpubsub`

4. Háganos saber si desea que se envíen diferencias de contenido de las compilaciones y a qué dirección de correo electrónico desea que se envíen.

## Diseño de directorio de origen

- tronco/
	- cgi-bin/
	- contenido/
	- plantillas/
	- lib/
		- path.pm
		- view.pm
- ramas/


Consulte <https://vcs.sunstarsys.com/repos/svn/public/cms-sites/www.sunstarsys.com/> para obtener un ejemplo activo.

## Contenido dinámico

### Ejemplo de script para volver a generar una página de origen con contenido cambiante, incluso cuando los orígenes no lo hacen.

La idea básica es que algunas de sus páginas de origen de alto perfil se construyen con contenido "dinámico" (construir incorpora fragmentos siempre cambiantes de otros sitios en línea, como cascadas de Jira o hilos de listas de correo actuales).

Un buen ejemplo de esto es la sección "Últimas noticias" de [Página de inicio de ASF](https://www.apache.org/), y aquí está la forma detrás de las escenas que funciona, con un poco de magia shell + svn + cron como se ejemplifica aquí (tomar el archivo fuente de la compilación dinámica como `Archivo $`

```shell
% cp $file $file.tmp
% svn rm $file
% mv $file.tmp $file
% svn add $file
% svn commit -m "rebuild $file"
```

Incorpore esto en un pequeño script de shell que usará sus credenciales svn almacenadas en caché en su propio PC, y haga que cron lo ejecute para usted en un horario fijo (basado en su servidor web frontend / TTL de la caché HTTP de CDN).  No hay necesidad de herramientas del lado del servidor de nuestro lado; usted tiene el control total de su propia seguridad de contraseña, programación y destinos de página dinámica.  Si está utilizando su propio servicio de Subversion habilitado para svnpubsub, ninguna de esas transacciones involucra directamente a nuestro hardware. Su confirmación disparará nuestro cliente svnwcsub, siempre escuchando su servidor svnpubsub, para crear y desplegar esos cambios bajo demanda &mdash;

No de excepciones

Por determinar

No de búsquedas

Por determinar

No de confirmaciones rápidas

Por determinar

## Agregar recurso

Por determinar

--------

## Índice

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
