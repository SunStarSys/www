---
acl: '@staff=rw, *=r'
archived: ~
categories: ~
dependencies: '*.md.es api/index.md.es'
keywords: seguridad,infosec,appsec,ipsec,devsecops,it,acl,svnauthz
published: ~
status: publicado
title: Seguridad de Orion
---

<div class="right">

![candado](security.page/padlock).

</div>

[TOC]

## {# lede #}"La seguridad a través de la oscuridad no es mucha seguridad en absoluto."{# lede #}

Popular paraphasing de cerrajero americano [Alfred Charles Hobbs](https://en.wikipedia.org/wiki/Alfred_Charles_Hobbs) en 1851, que eligió fácilmente las cerraduras del Palacio de Cristal durante una exposición de Londres ese año.  Estamos totalmente de acuerdo, por lo que nuestros planes detallados para nuestro motor de automatización de Oracle Cloud Infrastructure (OCI) son [disponible en GitHub](https://github.com/joesuf4/home/blob/wsl/.ocirc).

## Seguridad de infraestructura de Orion

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

Cifrado triple compatible con FIPS 140-2 con MFA para servicios reenviados por puerto inverso (HTTPS/SSH/IPsec).  Cinturón, tirantes y estribos!

----

&nbsp;

### Sin contraseña [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control) modelo, salpicado de [orthrus](https://github.com/SunStarSys/orthrus) [otp-sha1](https://en.wikipedia.org/wiki/One-time_password) desafíos sudo

No hay contraseñas fijas almacenadas en los servidores. Esto *limita* la automatización sin cabeza de sudo / RBAC uso, por una buena razón.  Sin embargo, hemos [herramientas](https://github.com/SunStarSys/pty) eliminar el trabajo de responder a peticiones de datos de diversos tipos.

### Ejecución en sandbox para compilaciones y scripts CGI

Desplegamos "nada compartido" compilaciones de zonas, con un valor predeterminado de cero disponibilidad de red. Esto significa que las únicas cosas a las que un cliente puede acceder o modificar son sus propios activos, no los de cualquier otro cliente, o cualquier otra ruta del sistema en la propia zona (además de [`/tmp`](#)).  Además, solo los clientes empresariales y empresariales tienen acceso a Internet durante sus compilaciones, ya que están utilizando sus propias zonas Solaris *únicas* que se pueden adaptar exactamente a sus requisitos de compilación.

Ditto para scripts CGI, que están completamente bloqueados en términos de acceso de escritura a cualquier otra cosa que no sea [`/tmp`](#).

### Cifrado completo

- TLS 1.3 (+FS) AES(256) SHA(256) para conexiones HTTPS FIPS 140-3

- SSHv2 ED25519 Claves compatibles con FIPS 140-3 / NIST para host cruzado [`Lote`](#) reenvío de puerto inverso

- IPsec/IKEv2/PFS AES(256) para VPN interregional

- AES(256) para cifrado ZFS

### Aspectos de confianza cero

La premisa básica de [arquitectura de confianza cero](https://csrc.nist.gov/publications/detail/sp/800-207/final) es evitar diseñar la seguridad de su red en torno a la fisiología de la almeja: duro en el exterior, pero suave y suelto una vez que esté en.  Así que no'Cada puerto de red privilegiado dentro de las diversas LAN de Punto de Presencia (POP) solo está expuesto a la máquina bare-metal.'interfaz de dispositivo de bucle de retorno [`lo0`](#), y solo es significativo en el contexto de un puerto (inverso) reenviado a la conexión SSH *a ella*.

Utilizamos proxies TCP, no proxies HTTP y no backends de MSA, **por lo que el único host que ve el tráfico web de TLS no cifrado es el host que lo descifra**. Se aplican las mismas reglas al tráfico de Subversion &mdash; solo el tráfico cifrado de TLS directo de extremo a extremo al **punto final de servicio** ve los datos no cifrados en la transferencia.

Buena suerte con las **capas de MSA y capas de exposición de datos privados** con otros proveedores. El enemigo de "ingeniería no funcional" es la complejidad. Es mucho más fácil proporcionar promesas de seguridad significativas cuando su producto es un **monolito federado en lugar de un campo minado masivo MSA**, que es otro diferenciador contrario entre Orion y su campo de competidores.

Esta infraestructura está totalmente automatizada una vez que una región se pone en línea, pero que'Todo lo que podemos compartir públicamente sobre la arquitectura (equilibrando la transparencia de Hobbsian con el mantra militar) "barcos de fregadero de labios sueltos" Es más arte que ciencia).  Permanecer tranquilo &mdash; más allá de romper el antispoof [`lo0`](#) protección dentro de Solaris 11's (BSD) filtro de paquetes en sí, no hay medios significativos de obtener acceso a estos servicios, incluso para las cuentas de los clientes.

Incluso si la cuenta de control maestra de OCI se ve comprometida, la **confidencialidad** y la **integridad** de todos los activos de cliente siguen siendo inviolables.  Todo lo que un sombrero negro puede hacer es hacer un lío con el sitio web del cliente **disponibilidad**. En particular, no pueden acceder a los registros de datos del servicio Subversion.  Podemos reconstruir toda la infraestructura de OCI desde cero en 48-72 horas una vez que la manzana dañada'Se ha terminado el acceso a OCI.

-----

### Registro, Supervisión y Auditoría

Animamos a los clientes de Enterprise a crear una cuenta de Splunk, y entregaremos weblogs casi en tiempo real a su cuenta desde cada POP global que necesite.  Los registros de errores para los scripts CGI del servidor también están disponibles para Splunk.

Supervisamos la disponibilidad del servicio desde todos nuestros POP de OCI en todo el mundo y activamos eventos de alta disponibilidad (dominio de disponibilidad) o de failover regional si la interrupción del servidor dura más de 30 segundos.

La auditoría de ACL se puede realizar simplemente creando un sitio web'Subversion HEAD con licencia de Apache [Orion SSG](https://github.com/SunStarSys/orion/blob/master/test.sh) script y examinando la creación resultante en la [`www/.acl`](#) archivo en su directorio de finalización de compra, en cualquier momento que desee.  Normalmente, el proceso de creación tardará menos de 10-15 segundos en hardware moderno.

Los ganchos de confirmación del lado del servidor de Subversion también se pueden personalizar para sus preocupaciones de supervisión. Desde una simple aplicación de correo de confirmación hasta un acceso seguro a nuestro daemon svnpubsub, hay cualquier cantidad de configuraciones personalizadas disponibles.

-----

## Seguridad de la aplicación Orion

### [La SSR pública es un olor](https://queue.acm.org/detail.cfm?id=2721993).

### Gestión de ACL

```graphviz
digraph {
"@path::acl" -> "authz-svn.conf" [label="svn"];
"@path::acl" -> "/**/.htaccess" [label="httpd"];
};
```

&nbsp;

Orión'El modelo de seguridad de s se gestiona de forma centralizada mediante la configuración incluida en [`@path::acl`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/acl.yml) como se constata en [`lib/path.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm). Los archivos de configuración del servidor de desconexión se generan dinámicamente en cada cambio creado.

### OpenIDC Seguridad de SSO

Las cookies de sesión son HttpOnly y Secure marcadas, por lo que los intentos de robo de sesión de Javascript son neutralizados efectivamente por el editor en línea de Orion.

### Cifrar para contraseñas de subversión

Número ajustable de rondas (el valor por defecto actual es 5).

### Protecciones de datos contaminados

Todos nuestros tiempos de ejecución de Perl tienen verificaciones obligatorias de pintura habilitadas con la bandera -T; una poderosa y única protección de Perl contra exploits de shell remoto.

### Problemas de wiki

La seguridad Wiki implica varios factores:

1. Seguridad de IU/API

2. Middleware/Seguridad de backend

3. Protecciones de recorrido de plantilla

4. Compatibilidad con ACL del motor de búsqueda

A continuación profundizamos en estos temas relacionados con Orión.

#### Editor en línea

El editor en línea admite una interfaz de usuario de JSON simplemente configurando el agente de usuario's Aceptar cabecera para preferir el [`aplicación/json`](#) Tipo MIME, por lo que los controles de seguridad son los mismos para la interfaz de usuario y la API.

**No hay ninguna interfaz de usuario/API** administrativa fuera del acceso directo a Subversion.

##### Las ACL de subversión rigen el acceso de lectura de copia de trabajo del servidor

Cada recurso de copia de trabajo disponible a través de la interfaz de usuario se comprueba de forma cruzada con las ACL de Subversion antes de presentarlas al usuario.  De esta forma, nos aseguramos de que se impida el acceso de lectura a los recursos no autorizados para los activos bajo control de versiones (también conocido como **todo**).

##### El acceso de confirmación se controla directamente con las ACL de Subversion

No se puede crear nada y, posteriormente, verlo a través de la red sin la correspondiente confirmación de Subversion autorizada. El problema principal aquí es controlar qué información está disponible para un autor de página wiki'las ediciones confirmadas y creadas.

Si permite el preprocesamiento de plantillas en las páginas de origen de rebaja, debe ser consciente de cómo los argumentos de plantilla hacen que el contenido de otros archivos del árbol esté disponible como variables para el origen de la página editada.

A menudo, si se configura para hacerlo, la página editada puede declarar sus propios archivos de dependencia en los encabezados de la página, que es algo que pensar a medida que sopesa los conjuntos de funciones contra los controles de seguridad en su Wiki.'s Arquitectura de la Información.

Si bien podemos ofrecer orientación y apoyo para satisfacer sus necesidades,'Depende realmente de usted decidir cómo equilibrar las escalas para su organización'wiki empresarial.

Consulte la siguiente sección sobre [Controles de inyección de dependencia/ACL](#h4-dependency-acl-injection-controls) para obtener más detalles y ver este ejemplo en directo de lo fácil que es ACL's se puede configurar de forma centralizada en [`lib/acl.yml`]({{snippetA.pretty_uri}}):

[snippet:repo=SunStarSys/www:path=lib/acl.yml:branch=trunk:token=#acl:lang=yaml]

Los autores de contenido pueden configurar restricciones de página en la página's [cabeceras]({{snippetB.pretty_uri}}):

[snippet:repo=SunStarSys/www:path=content/orion/security.md.en:branch=trunk:lines=1,4:lang=yaml]

Como nota lateral, los recursos protegidos no pueden ser copiados en una rama por personal no autorizado, incluso sin colocar controles de ACL adicionales sobre la creación y modificación de la rama. En otras palabras, el sistema apoyará la experimentación de sucursales sin ningún control adicional de su parte para garantizar que los activos protegidos permanezcan protegidos en cada sucursal.'ciclo de vida natural.

#### ¿Crear ACL del sistema?

El sistema de construcción es todo lo que se ve y todo lo que se sabe, pero podemos asegurarnos de que sus activos creados y protegidos solo sean visibles para los equipos que gestiona y controla en las ACL de Subversion.

El sistema de creación mostrará la lista de nombres de archivo que creó a través del IDE del explorador tras una confirmación, pero esa lista solo se basa en un usuario'Acceso de lectura a los recursos dependientes del usuario's agregar, actualizar o suprimir acciones de contenido en la confirmación.

##### Controles de recorrido de plantilla

Ver [sanitize_relative_path]({{snippetC.pretty_uri}}):

[snippet:repo=SunStarSys/orion:path=lib/SunStarSys/Util.pm:token=#ttc:lang=perl]

Este código aplica las reglas que se indican a continuación en esta sección.

###### incluir y ampliar etiquetas

Todos los archivos de destino están en una subcarpeta de la [`/plantillas/`](#) carpeta, y se debe hacer referencia a ella como rutas de acceso absolutas con raíz en esa carpeta.

###### etiqueta ssi

Todos los archivos de destino están en una subcarpeta de la [`/contenido/`](#) carpeta, y se debe hacer referencia a ella como rutas de acceso absolutas con raíz en esa carpeta.

Si la ruta de destino no está configurada en [`@path::patrones`](#) con una configuración coincidente que permite que la ruta de destino en cuestión se archive o se categorice, la [`ssi`](#) la operación fallará.

Esto se debe a [`ssi`](#) el soporte es un requisito previo para esos juegos de funciones, para conservar su sitio's taget *permalinks*.

#### Controles de inyección de dependencia/ACL

Controlado por [`lib/path.pm`](#) importaciones.

##### lib/{ruta,ver}ACL de subversión .pm

Es'Es prudente controlar el acceso de escritura a estos recursos, limitándolos a personas tanto competentes en la base de código como autorizadas para implementar controles de seguridad para todo el conjunto de activos bajo control de versiones (también conocido como *todo*).

También es una buena idea incluir la [`@svnadmin`](#) grupo entre los que tienen acceso de lectura y escritura, pero'No es estrictamente necesario, incluso si necesita que restablezcamos manualmente sus ACL de Subversion.

##### Reglas generadas dinámicamente mediante &#64;ruta::acl

El sistema de creación toma nota de su [`lib/path.pm`](#) las importaciones (o ambas) de seed_file_deps() y seed_file_acl(), y trasladar esa opción en su procesamiento interno de los cambios de confirmación de Subversion que dan lugar a una creación incremental.

##### Controles personalizados en el uso de seed_file_deps() y seed_file_acl() en lib/path.pm

Más allá de la importancia de estos símbolos para [`lib/path.pm`](#), también hay una opción sobre cómo y a qué archivos desea aplicarlos durante la ejecución de un bloque de código walk_content_tree ().  Después de todo,'no solo un archivo de configuración, sino una base de código, con todas las características completas de [`Perl`](#) nosotros'¡Ven a conocer y apreciar!

#### ACL de Subversion y Sitio Web Creados'sincronizado con &#64;path::acl instantáneamente al confirmar

Protección automática para construcciones de sucursales efímeras. Se requiere ninguna configuración adicional.

#### Controles de acumulación del motor de búsqueda PCRE

Igual situación que la interfaz de usuario de uso general: realiza comprobaciones cruzadas con el servidor de Subversion desde la interfaz de usuario.

En el sitio en vivo, el motor de búsqueda hará lo mismo cuando habilite las búsquedas de Markdown (árbol de origen). De lo contrario, ejecutará subsolicitudes httpd en su sitio activo para probar si el usuario está autorizado para acceder a ese archivo activo (suponiendo que haya protegido con contraseña su motor de búsqueda para que tenga datos de usuario con los que trabajar).

### Políticas de seguridad de contenido

- [x] Restricciones de análisis

Google y/o LinkedIn.

- [x] Restricciones de datos

Los datos deben ser entregados desde nuestros servidores.

- [x] Restricciones de contenido

El contenido debe ser entregado desde nuestros servidores.

- [x] Restricciones de código

El código Javascript debe ser entregado desde nuestros servidores.

- [x] Restricciones de estilo

CSS debe ser entregado desde nuestros servidores.

- [x] Restricciones de plugin

PDF actual's solamente.

### Uso compartido de recursos entre orígenes

- [x] Todos los usuarios con una cuenta pueden consumir UI/API desde cualquier lugar utilizando sus credenciales de inicio de sesión.

- [x] Los clientes empresariales pueden tratar a Orion como un [CMS sin cabecera](https://aws.amazon.com/what-is/headless-cms/) si quieren crear su propia interfaz de usuario desde la [Porcelana de subversión JSON](api/editor) o [Búsqueda de JSON](api/search) API.

### Dependencias de terceros

Dependencias notablemente breves y probadas en el tiempo; cuyos componentes principales están cubiertos por la [Tecnología de Orion](technology) página.

#### Lista de materiales de software (SBOM) disponible previa solicitud

[Contáctenos](/contact) para más detalles.

--------

## Índice

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
