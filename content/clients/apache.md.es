---
archived: ~
categories: ~
keywords: qpsmtpd,Apache::Qpsmtpd,earlytalker,Apache CMS
published: ~
status: ~
title: La Fundación de Software Apache
---

![La ASF](http://www.apache.org/images/feather.png).

[La Fundación de Software Apache](http://www.apache.org/).

Cuando empecé a trabajar en Apache en 2006, el problema más apremiante era la sobrecarga de los servicios de correo entrante.  La organización se estaba ahogando en el spam, y con 1,5 millones de conexiones entrantes por día superaba la entrega saliente de la organización y abrumaba el software.  Mi primera tarea fue resolver esta situación, así que lo que se me ocurrió fue un enfoque doble: la primera actualización `qpsmtpd` para `Apache::Qpsmtpd`, el `mod_perl` variante experimental que convierte `httpd`

`Apache::Qpsmtpd` necesitaba unos parches para que fuera adecuado para el servicio de empresa, que proporcionaba.  Eso se hizo cargo de las preocupaciones inmediatas que giran en torno a la carga aplastante en el servicio, pero si las tendencias de crecimiento continuas significaría inversiones continuas en más
y un mejor hardware y software, principalmente para dar servicio a todo el crecimiento de la conexión de spam. Incluso hemos intentado un esfuerzo abortado para desplegar `eceleridad`, que en el equipo de Apple no era lo suficientemente estable como para migrar a en 2006.  `Eceleración` (ahora conocido como `Momento` desde [Sistemas de mensajes](http://www.messagesystems.com).

Entra en la segunda parte de mi enfoque: un intento de disuadir a los spammers de golpear los servidores de correo de The ASF en primer lugar.  Que implicaba la aplicación de parches `qpsmtpd`s `maduro` plugin para ejecutar en `DATOS` fase, combinada con la aceleración del retraso a 20 segundos, una cantidad alta pero tolerable para todos los agentes de entrega de mensajes compatibles con RFC.  Fue un delicado equilibrio ya que los niveles de spam subieron a 2 millones y luego a 2,5 millones por día, debido a que la `maduro` retrasar el aumento de los niveles de simultaneidad 4-5 veces por encima de los niveles "normales" y el spam continuó creciendo. Estábamos presionando `httpd`s `MaxClients` configuración durante ese período, incluso hasta el punto de tener que compilar `httpd`

Normalmente `maduro` se ejecuta antes de que se entregue el banner, que es subóptimo cuando su plugin principal para tratar con spammers gira en torno a las listas negras de dns.  En ejecución `maduro` tan tarde como sea posible en `SMTP` sesión significó que otros plugins anti-spam de acción más rápida podrían eliminar la conexión tan pronto como sea posible, antes de que los retrasos comenzaran a iniciarse y vincularse `httpd` niños.  También los spammers pagan este precio de retraso por cada mensaje enviado cuando `maduro` se ejecuta en `DATOS`

Durante 8 años, el impacto ecológico de mi `maduro`

Más allá de las tareas rutinarias que enfrenta cada administrador del sistema, mi otro logro principal en la ASF fue la creación de la `CMS de Apache`. Las razones y fundamentos de ello fueron [documentado](http://www.apache.org/dev/cms), pero es importante tener en cuenta que este software se desarrolló rápidamente durante un período de 3 meses antes de ser presionado en producción para el sitio web de <http://www.apache.org/>.  Ha alcanzado una popularidad dentro de The ASF más allá de mis expectativas más salvajes: más de 100 proyectos actualmente confían en él para sus necesidades de sitio web.  Se reduce a sitios pequeños pero intrincados como [Apache Thrift](http://thrift.apache.org/), al mismo tiempo que se amplía para satisfacer las necesidades de un sitio web de 5 GB como [OpenOffice.org](http://www.openoffice.org/).

Disfruté la mayor parte de mi tiempo sirviendo a las necesidades de la comunidad Apache, pero después de 8 años era hora de un cambio.  Siempre miraré con cariño los muchos recuerdos y amigos que hice mientras estaba allí, y le deseo a Apache todo lo mejor en el futuro.
