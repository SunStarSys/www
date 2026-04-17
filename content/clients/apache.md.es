---
archived: ~
categories: ~
keywords: qpsmtpd,Apache::Qpsmtpd, Earlytalker, CMS deApache
published: ~
status: ~
title: La Fundación del Software Apache
---

![La ASF](apache.page/feather2.png).

[La Fundación del Software Apache](http://www.apache.org/) (La ASF) es una organización benéfica pública 501(c)(3) dedicada a la promoción y desarrollo de software de código abierto.  En los 8 años que serví como Administrador del Sistema (contratado) para la ASF, la fundación se triplicó tanto en tamaño como en alcance.  Pasamos de un medio gabinete de máquinas en 2006 a más de 4 gabinetes por valor en 2014, y estábamos comenzando el proceso de expansión en la nube.

Cuando empecé a trabajar en Apache en 2006, el problema más urgente fue la sobrecarga de los servicios de correo entrante.  La organización se estaba ahogando en el spam, y a 1,5 millones de conexiones entrantes por día estaba superando la entrega saliente de la organización y abrumando el software.  Mi primera tarea fue resolver esta situación, así que lo que se me ocurrió fue un enfoque doble: la primera actualización `qpsmtpd` a `Apache::Qpsmtpd`, el `mod_perl` variante experimental que convierte `httpd` en un servidor de correo entrante.

`Apache::Qpsmtpd` necesitaba algunos parches para que fuera adecuado para el servicio empresarial, que proporcioné.  Eso se hizo cargo de las preocupaciones inmediatas que giran en torno a la carga aplastante en el servicio, pero si las tendencias de crecimiento continuas significaría inversiones continuas en más
y un mejor hardware y software, principalmente para dar servicio a todo el crecimiento de la conexión de spam. Incluso intentamos un esfuerzo abortado para desplegar `aceleración`, que en el equipo de Apple no era lo suficientemente estable como para migrar a en 2006.  `Eceleridad` (ahora conocido como `Momento` desde [Sistemas de mensajes](http://www.messagesystems.com)) es una pieza de software bellamente diseñada, con un impresionante equilibrio de bucles de eventos, hilos de trabajadores y puntos de extensión, pero finalmente exagerado para la ASF.  Las soluciones de código abierto eran "suficientemente buenas".

Entra en la segunda parte de mi enfoque: un intento de disuadir a los spammers de golpear los servidores de correo de The ASF en primer lugar.  Eso implicaba aplicar parches `qpsmtpd`s `Earlytalker` plugin para ejecutar en el `DATOS` fase, combinada con aumentar el retraso a 20 segundos, una cantidad alta pero tolerable para todos los agentes de entrega de mensajes que cumplen con la RFC.  Fue un delicado equilibrio ya que los niveles de spam aumentaron a 2 millones y luego a 2,5 millones por día, porque el `Earlytalker` retrasar el aumento de los niveles de concurrencia de 4 a 5 veces por encima de los niveles "normales" y el spam continuó creciendo. Estábamos empujando `httpd`s `MaxClients` configuración durante ese período, incluso hasta el punto de tener que compilar `httpd` para elevar el límite compilado, pero después de unos meses comenzamos a ver mejoras mensurables.

Normalmente `Earlytalker` Se ejecuta antes de que se entregue el banner, que es subóptimo cuando su complemento principal para tratar con spammers gira en torno a las listas negras de dns.  En ejecución `Earlytalker` lo más tarde posible en el `SMTP` sesión significó que otros plugins anti-spam de acción más rápida podrían borrar la conexión lo antes posible, antes de que los retrasos comenzaran a entrar y atarse `httpd` niños.  También los spammers pagan este precio de retraso por cada mensaje enviado cuando `Earlytalker` se ejecuta en `DATOS` fase, no sólo en el inicio de una conexión que es lo que sucede cuando se ejecuta antes del banner.  En otras palabras, no hay otra manera de evitarlo que enviando una larga lista de destinatarios que puede desencadenar otras herramientas anti-spam.

A lo largo de 8 años, el impacto ecológico de mi `Earlytalker` Los ajustes fueron claros: habíamos reducido el número de conexiones de correo no deseado de entrada diarias **diez veces**, hasta alrededor de 150K por día, repartidas en dos servidores.  Los spammers simplemente **excluían** el envío de mensajes a apache.org, que era la mejor solución anti-spam posible.

Más allá de las tareas rutinarias que enfrenta cada Administrador del Sistema, mi otro logro principal en The ASF fue la creación de `CMS de apache`. Las razones y razones detrás de ello fueron [documentado](http://www.apache.org/dev/cms), pero es importante tener en cuenta que este software se desarrolló rápidamente durante un período de 3 meses antes de ser presionado en producción para el sitio web de <http://www.apache.org/>.  Ha alcanzado una popularidad dentro de La ASF más allá de mis expectativas más salvajes: más de 100 proyectos actualmente dependen de ella para sus necesidades de sitio web.  Se reduce a sitios pequeños pero intrincados como [Apache Thrift](http://thrift.apache.org/), al tiempo que se amplía para satisfacer las necesidades de un sitio web de 5 GB como [OpenOffice.org](http://www.openoffice.org/).

Disfruté de la mayor parte de mi tiempo sirviendo a las necesidades de la comunidad de Apache, pero después de 8 años fue hora de un cambio.  Siempre miraré con cariño los muchos recuerdos y amigos que hice mientras estaba allí, y le deseo a Apache todo lo mejor en el futuro.

<!-- $Date$ $Author$ $Revision$ -->
