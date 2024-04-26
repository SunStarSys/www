---
acl: '@staff=rw, *=r'
archived: ~
categories: ~
dependencies: '*.md.es api/index.md.es'
keywords: seguridad,infosec,appsec,ipsec,devsecops,it,acl,svnauthz
published: ~
status: publicado
title: Seguridad Orion
---

[TOC]

## {# lede #}"La seguridad a través de la oscuridad no es mucha seguridad en absoluto".{# lede #}

Popular paraphasing de cerrajero americano [Alfred Charles Hobbs](https://en.wikipedia.org/wiki/Alfred_Charles_Hobbs) en 1851, que escogió fácilmente las cerraduras del Crystal Palace durante una exposición de Londres ese año.  Estamos totalmente de acuerdo, por lo que nuestros planes para nuestro motor de automatización de Oracle Cloud Infrastructure (OCI) son [disponible en GitHub](https://github.com/joesuf4/home/blob/wsl/.ocirc).

## Seguridad de la infraestructura de Orion

```mermaid
flowchart TB
classDef borderless stroke-width:0px
classDef darkBlue fill:#00008B, color:#fff
classDef brightBlue fill:#6082B6, color:#fff
classDef gray fill:#62524F, color:#fff
classDef gray2 fill:#4F625B, color:#fff

subgraph vcs[ ]
    A1[[Fort Lauderdale, FL]]
    B1[Air-Gapped Version Control Server]
end
class vcs,A1 gray

subgraph vpn-us-east[ ]
    A2[[Reston, VA]]
    B2[OCI Edge Servers]
end
class vpn-us-east,A2 darkBlue

subgraph vpn-us-west[ ]
    A3[[Phoenix, AZ]]
    B3[OCI Edge Servers]
end
class vpn-us-west,A3 darkBlue

subgraph vpn-de-central[ ]
    A4[[Frankfurt, Germany]]
    B4[OCI Edge Servers]
end
class vpn-de-central,A4 darkBlue

subgraph vpn-bz-west[ ]
    A5[[São Paolo, Brazil]]
    B5[OCI Edge Servers]
end
class vpn-bz-west,A5 darkBlue

subgraph vpn-au-west[ ]
    A6[[Sydney, Australia]]
    B6[OCI Edge Servers]
end
class vpn-au-west,A6 darkBlue

subgraph vpn-ap-west[ ]
    A7[[Hyderabad, India]]
	B7[OCI Edge Servers]
end
class vpn-ap-west,A7 darkBlue

subgraph vpn-ap-east[ ]
    A8[[Seoul, South Korea]]
    B8[OCI Edge Servers]
end
class vpn-ap-east,A8 darkBlue

class A1,A2,A3,A4,A5,A6,A7,A8 borderless

vcs==vpn==>A2==ssh/vpn==>B2
vcs==vpn==>A3==ssh/vpn==>B3
vcs==vpn==>A4==ssh/vpn==>B4
vcs==vpn==>A5==ssh/vpn==>B5
vcs==vpn==>A6==ssh/vpn==>B6
vcs==vpn==>A7==ssh/vpn==>B7
vcs==vpn==>A8==ssh/vpn==>B8
```
&nbsp;

Cifrado triple de FIPS 140-2 con MFA para servicios de reenvío por puerto inverso (HTTPS/SSH/IPsec).  Cinturón, tirantes y estribos!

----

&nbsp;

### Passwordless [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control) modelo, salpicada de [orrus](https://github.com/SunStarSys/orthrus) [otp-sha1](https://en.wikipedia.org/wiki/One-time_password).

No hay contraseñas fijas almacenadas en los servidores. Este *limita* la automatización sin cabeza del uso de sudo / RBAC, por una buena razón.  Sin embargo, hemos [herramientas](https://github.com/SunStarSys/pty).

### Ejecución en sandbox para compilaciones y scripts CGI

Implementamos compilaciones de zona "shared-nothing", con disponibilidad de red cero por defecto. Esto significa que las únicas cosas a las que un cliente puede acceder o modificar son sus propios activos, no los de cualquier otro cliente o cualquier otra ruta del sistema de la propia zona (además de [`/tmp`](#).

Ditto para secuencias de comandos CGI, que están completamente bloqueadas en términos de acceso de escritura a cualquier otra cosa que no sea [`/tmp`](#).

### Cifrado completo

- TLS 1.3 (+FS) AES(256) SHA(256) para conexiones HTTPS FIPS 140-3

- SSHv2 ED25519 Claves compatibles con FIPS 140-3/NIST para hosts cruzados [`lo`](#).

- IPsec/IKEv2/PFS AES(256) para VPN entre regiones

- AES(256) para cifrado ZFS

### Aspectos de confianza cero

La premisa básica de [arquitectura de confianza cero](https://csrc.nist.gov/publications/detail/sp/800-207/final) es evitar diseñar su seguridad de red en torno a la fisiología de la almeja: duro en el exterior, pero suave y suelto una vez que está en.  Así que no lo hacemos; cada puerto de red privilegiado significativo dentro de las diversas LAN de punto de presencia (POP) solo está expuesto a la interfaz de dispositivo de bucle de retorno de la máquina de metal desnudo. [`lo0`](#).

Esta infra está totalmente automatizada una vez que una región se pone en línea, pero eso es todo lo que podemos compartir públicamente sobre la arquitectura (equilibrar la transparencia Hobbsian con el mantra militar "barcos de hundimiento de labios sueltos" es más arte que ciencia).  Restur &mdash; más allá de romper el antispoofing [`lo0`](#).

Incluso si la cuenta de control maestra de OCI se ve comprometida, la **confidencialidad** y la **integridad** de todos los activos de cliente permanecen inviolables.  Todo lo que puede hacer un sombrero negro es hacer un lío con el sitio web del cliente **disponibilidad**. En particular, no pueden acceder a los registros de datos del servicio Subversion.  Podemos reconstruir toda la infraestructura de OCI desde cero en 48-72 horas una vez que se haya terminado el acceso de OCI de la manzana defectuosa.

-----

### Registro, supervisión y auditoría

Animamos a los clientes de Enterprise a crear una cuenta Splunk, y entregaremos weblogs casi en tiempo real a su cuenta desde cada POP global que necesite.  Los registros de errores de los scripts CGI del servidor también están disponibles para Splunk.

Supervisamos la disponibilidad del servicio de todos nuestros POP de OCI en todo el mundo y disparamos eventos de failover de alta disponibilidad (dominio de disponibilidad) o regionales si una interrupción del servidor dura más de 30 segundos.

La auditoría de ACL se puede realizar simplemente mediante la creación de un sitio web Subversion HEAD utilizando la licencia Apache. [Orion SSG](https://github.com/SunStarSys/orion/blob/master/test.sh) y examinar la creación resultante en el [`www/.acl`](#).

Los ganchos de confirmación del lado del servidor de Subversion también se pueden personalizar según sus preocupaciones de supervisión. Desde una simple aplicación de confirmación de correo hasta un acceso seguro a nuestro daemon svnpubsub, hay una serie de configuraciones personalizadas disponibles.

-----

## Seguridad de la aplicación Orion

```graphviz
digraph {
"@path::acl" -> "authz-svn.conf" [label="svn"];
"@path::acl" -> "/**/.htaccess" [label="httpd"];
};
```

&nbsp;

El modelo de seguridad de Orion se gestiona centralmente mediante la configuración contenida en [`@path::acl`](#) como constujo en [`lib/path.pm`](#).

Seguridad de SSO de ### OpenIDC

Las cookies de sesión son HttpOnly y están marcadas como seguras, por lo que los intentos de robo de sesiones de Javascript son efectivamente neutralizados por el editor en línea de Orion.

### Bcrypt para contraseñas de Subversion

Número ajustable de rondas (actualmente el valor predeterminado es 5).

### Protecciones de datos contaminadas

Todos nuestros tiempos de ejecución de Perl tienen activadas las comprobaciones de color obligatorias con el indicador -T; un protector de Perl potente y exclusivo contra exploits de shell remoto.

### Problemas de Wiki

La seguridad wiki implica varios factores:

1. Seguridad de interfaz de usuario/API

2. Seguridad de Middleware/Backend

3. Protecciones de recorrido de plantilla

4. Compatibilidad de ACL de Motor de Búsqueda

Profundizamos en estos temas como se relacionan con Orión a continuación.

#### Editor en línea

El editor en línea soporta una interfaz de usuario JSON simplemente definiendo la cabecera Accept de su agente de usuario para que prefiera la [`aplicación/json`](#).

**No hay ninguna interfaz de usuario/API administrativa** fuera del acceso directo a Subversion.

##### Las ACL de subversión controlan el acceso de lectura de copia de trabajo del servidor

Cada recurso de copia de trabajo disponible a través de la interfaz de usuario se comprueba con las ACL de Subversion antes de presentarlas al usuario.  De esta forma, nos aseguramos de que se impida el acceso de lectura a recursos no autorizados para los activos bajo control de versiones (también conocido como **todo**).

##### El acceso de confirmación se controla directamente con las ACL de Subversion

No se puede crear nada y visualizarlo posteriormente a través de la red sin una confirmación de Subversion autorizada correspondiente. El problema principal aquí es controlar qué información está disponible para las ediciones comprometidas y construidas de un autor de una página wiki.

Si permite el preprocesamiento de plantillas en las páginas de origen de rebaja, debe tener en cuenta cómo los argumentos de plantilla hacen que el contenido de otros archivos del árbol esté disponible como variables para el origen de la página editada.

A menudo, si se configura para hacerlo, la página editada puede declarar sus propios archivos de dependencia en los encabezados de la página, que es algo que debe pensar al sopesar los conjuntos de funciones contra los controles de seguridad en la arquitectura de información de su Wiki.

Si bien podemos ofrecer orientación y apoyo para satisfacer sus necesidades, depende de usted decidir cómo equilibrar las escalas para el wiki empresarial de su organización.

Consulte la siguiente sección sobre [Controles de inyección de dependencia/ACL](#h4-dependency-acl-injection-controls) para obtener más información y verifique este ejemplo en directo de la facilidad con la que las ACL se pueden configurar de forma centralizada en [`lib/acl.yml`]({{snippetA.pretty_uri}}).

[snippet:repo=SunStarSys/www:path=lib/acl.yml:branch=trunk:token=#acl:lang=yaml]

Los autores de contenido pueden configurar restricciones de página en la página [cabeceras]({{snippetB.pretty_uri}}).

[snippet:repo=SunStarSys/www:path=content/orion/security.md.en:branch=trunk:lines=1,4:lang=yaml]

Como nota adicional, los recursos protegidos no pueden ser copiados en una sucursal por personal no autorizado, incluso sin colocar ningún control de ACL adicional en la creación y modificación de la sucursal. En otras palabras, el sistema apoyará la experimentación de sucursales sin ningún control adicional de su parte para garantizar que los activos protegidos permanezcan protegidos durante todo el ciclo de vida natural de cada sucursal.

#### ¿Crear ACL del sistema?

El sistema de creación es omnipresente y omnisciente, pero podemos asegurarnos de que sus activos protegidos y creados solo sean visibles para los equipos que gestiona y controla en las ACL de Subversion.

El sistema de creación mostrará la lista de nombres de archivos que ha creado mediante el IDE del explorador tras una confirmación, pero esa lista solo se basa en el acceso de lectura de un usuario a los recursos que dependen de las acciones de adición, actualización o supresión de contenido del usuario en la confirmación.

Controles de recorrido de plantilla #####

Ver [sanitize_relative_path]({{snippetC.pretty_uri}}).

[snippet:repo=SunStarSys/orion:path=lib/SunStarSys/Util.pm:token=#ttc:lang=perl]

Este código aplica las siguientes reglas en esta sección.

###### incluir y ampliar etiquetas

Todos los archivos de destino están en una subcarpeta de la [`/plantillas/`](#).

###### etiqueta ssi

Todos los archivos de destino están en una subcarpeta de la [`/contenido/`](#).

Si la ruta de destino no está configurada en [`@path::patrones`](#) con una configuración coincidente que permite archivar o categorizar la ruta de destino en cuestión, la [`ssi`](#).

Esto se debe a [`ssi`](#).

#### Controles de inyección de dependencia/ACL

Controlado por [`lib/path.pm`](#).

##### lib/{path,view}.pm ACL de Subversión

Es aconsejable controlar el acceso de escritura a estos recursos, limitándolos a personas competentes en la base de código y autorizadas para implementar controles de seguridad para todo el conjunto de activos bajo control de versiones (también conocido como *todo*).

También es una buena idea incluir el [`@svnadmin`](#).

##### reglas generadas dinámicamente mediante &#64;

El sistema de creación toma nota de su [`lib/path.pm`](#).

##### controles personalizados sobre el uso de seed_file_deps() y  seed_file_acl() en lib/path.pm

Más allá de la importancia de estos símbolos para [`lib/path.pm`](#), también hay una opción en cómo y a qué archivos desea aplicarlos, durante una ejecución de bloque de código walk_content_tree ().  Después de todo, no es solo un archivo de configuración, sino una base de código, con todas las características completas de Turing. [`Perl`](#).

#### Sitio web construido y ACL de Subversion sincronizadas con &#64;

Protección automática para construcciones de ramas efímeras. No se requiere configuración adicional.

#### Controles incorporados del motor de búsqueda PCRE

Igual que la interfaz de usuario de uso general: realiza comprobaciones cruzadas con el servidor de Subversion desde la interfaz de usuario.

En el sitio activo, el motor de búsqueda hará exactamente lo mismo cuando habilite las búsquedas de Markdown (árbol de origen). De lo contrario, se ejecutarán solicitudes secundarias httpd a su sitio activo para probar si el usuario está autorizado para acceder a ese archivo activo (suponiendo que haya protegido con contraseña su motor de búsqueda para que tenga datos de usuario con los que trabajar).

### Políticas de seguridad de contenido

- [x]

Google y/o LinkedIn.

- [x]

Los datos deben ser entregados desde nuestros servidores.

- [x]

El contenido debe ser entregado desde nuestros servidores.

- [x]

El código Javascript debe ser entregado desde nuestros servidores.

- [x]

CSS debe ser entregado desde nuestros servidores.

- [x]

Actualmente solo PDF.

### Uso compartido de recursos de origen cruzado

- [x]

- [x] Los clientes empresariales pueden tratar a Orion como un [CMS sin cabecera](https://aws.amazon.com/what-is/headless-cms/) si desean crear su propia interfaz de usuario desde [JSON Subversion Porcelana](api/editor) o [Búsqueda de JSON](api/search).

### Dependencias de terceros

Dependencias notablemente breves y probadas en el tiempo; los principales componentes de los cuales se tratan en [Tecnología Orion](technology).

#### Lista de materiales de software (SBOM) disponible previa solicitud

[Contáctenos](/contact).

--------

## Índice

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
