---
categories: borrador
dependencies: '*.md.es api/index.md.es'
keywords: ~
status: ~
title: Política de privacidad de Orion
---

<div class="float-lg-right">
	<img src="../images/sunstarstaronly.png"></img>
</div>

## Esquema

- NO COMPARTIR/VENDER DATOS DE CLIENTES.

- Cookies solo utilizadas para fines de seguridad / responsabilidad.

- Los únicos componentes de Identidad de Usuario que registramos son la dirección de correo electrónico de su cuenta de Google OpenID y la cuenta de usuario que utiliza para conectarse a cualquier sistema de Subversion que sustente Orion TM para el sitio al que está realizando Compromisos.  El sistema de registro realiza un seguimiento de estos junto con el Apache básico [`httpd`](#) juego de logs de respuesta de acceso, que incluye la dirección IP de conexión, el protocolo de solicitud con detalles de URL y el cliente anunciados [`Referer`](#) y  [`User-Agent`](#)

- {# lede #}Es un sistema de inclusión compatible con GDPR.  En la primera visita al Orion TM CMS / IDE, se le dirigirá a una página de google que le pide que autorice{# lede #}

--------

## Índice

{% for d in deps %}
- [{{d.1.headers.title|safe}}](<!-- ### -->) &mdash; {{d.0}}...
{{d.1.content|lede}}

<!-- $Date$ $Author$ $Revision$ -->
