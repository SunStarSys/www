---
archived: ~
categories: ~
dependencies: '*.md.es api/index.md.es'
keywords: ~
published: ~
status: borrador
title: Política de privacidad de Orion
---

<div class="lg right">
	<img src="../images/sunstarstaronly.png"></img>
</div>

## Esquema

- NO COMPARTIR/VENDER DATOS DE CLIENTES.

- Cookies solo utilizadas para fines de seguridad / responsabilidad.

- Los únicos componentes de identidad de usuario que registramos son la dirección de correo electrónico de su cuenta de Google OpenID y la cuenta de usuario que utiliza para conectarse a cualquier sistema de Subversion que sustente Orion &trade; para el sitio en el que está realizando confirmaciones.  El sistema de registro realiza un seguimiento de estos junto con el Apache básico [`httpd`](#) juego de logs de respuesta de acceso, que incluye la dirección IP de conexión, el protocolo de solicitud con detalles de URL y los clientes anunciados [`Referente`](#) y  [`Agente de usuario`](#).

- {# lede #}Es un sistema de inclusión compatible con GDPR.  En la primera visita al Orión &trade; CMS / IDE, se le dirigirá a una página de google pidiéndole que autorice{# lede #} la aplicación <span class="text-white">SunStar Systems OIDC</span> para utilizar los detalles de la cuenta de Google proporcionados (principalmente información de perfil) &mdash;

--------

## Índice

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
