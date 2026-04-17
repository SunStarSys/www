< DOCTYPE html PÚBLICO "-//W3C//DTD XHTML 1.0 Estricto//ES" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>ViewVC Ayuda: General</title>
  <link rel="stylesheet" href="help.css" type="text/css" />
</head>
<body>
  <table>
    <col class="menu" />
    <col />
    <tr>
      <td colspan="2">
	<h1>ViewVC Ayuda: General</h1>
      </td>
    </tr>
    <tr><td>
       <h3>Ayuda</h3>
       <strong>General</strong><br />
       <a href="help_dirview.html">Directorio&nbsp;Ver</a><br />
       <a href="help_log.html">Registro&nbsp;Ver</a><br />

<h3>Internet</h3>
       <a href="http://viewvc.org/index.html">Inicio</a><br />
       <a href="http://viewvc.org/upgrading.html">Actualizando</a><br />
       <a href="http://viewvc.org/contributing.html">Contribución</a><br />
       <a href="http://viewvc.org/license-1.html">Licencia</a><br />
    </td><td colspan="2">

<p><em>ViewVC</em> es una interfaz WWW para CVS y Subversion
  repositorios. Permite examinar los archivos y directorios de una
  repositorio al mostrar los metadatos del historial del repositorio: log
  mensajes, fechas de modificación, nombres de autor, números de revisión, copiar
  historia, etc. Proporciona varias vistas diferentes del repositorio
  datos para ayudarle a encontrar la información que está buscando:</p>

<ul>
    <li><a name="view-dir" href="help_dirview.html"><strong>Directorio
    Ver</strong></a> - Muestra una lista de archivos y subdirectorios en un
    directorio del repositorio, junto con metadatos como nombres de autor y
    entradas de log.</li>

<li><a name="view-log" href="help_log.html"><strong>Registro
    Ver</strong></a> - Muestra una lista de revisión por revisión de todos los
    cambios realizados en un archivo o directorio del repositorio, con
    metadatos y enlaces a vistas de cada revisión.</li>

<li><a name="view-markup"><strong>Vista de contenido de archivo (Marcado)
    Ver)</strong></a> - Muestra el contenido de un archivo en un determinado
    revisión, con información de revisión en la parte superior de la página. Archivo
    Las revisiones que son imágenes GIF, PNG o JPEG se muestran en línea en
    la página. Otros tipos de archivo se muestran como texto marcado. El margen comercial
    puede limitarse a convertir URL y direcciones de correo electrónico en enlaces, o
    configurado para mostrar el código fuente coloreado.</li>

<li><a name="view-checkout"><strong>Descarga de archivo (desprotección)
    Ver)</strong></a> - Recupera el contenido inalterado de un archivo
    revisión. Los exploradores pueden intentar mostrar el archivo o simplemente guardarlo en
    disco.</li>

<li><a name="view-annotate"><strong>Vista de anotación de archivo</strong></a> -
    Muestra el contenido de una revisión de archivo y lo desglosa línea por línea,
    que muestra el número de revisión donde se modificó por última vez, junto con
    con enlaces y otra información. <em>Esta vista está desactivada en algunos
    Configuraciones de ViewVC</em></li>

<li><a name="view-diff"><strong>Vista de diferencias de archivo</strong></a> - Espectáculos
    los cambios realizados entre dos revisiones de un archivo</li>

<li><a name="view-tarball"><strong>Vista de tarball de directorio</strong> -
    Recupera un archivo tar comprimido que contiene el contenido de un
    directorio.<em>Esta vista está desactivada en el valor por defecto ViewVC
    configuración.</em></li>

<li><a name="view-query"><strong>Vista de consulta de directorio</strong></a> -
    Muestra información sobre los cambios realizados en todos los subdirectorios y archivos
    en un directorio principal, ordenado y filtrado por criterios especificados.
    <em>Esta vista está desactivada en la configuración por defecto ViewVC.</em>
    </li>

<li><a name="view-rev"><strong>Vista de revisión</strong> - Espectáculos
    información sobre una revisión, incluido el mensaje de log, el autor y una lista
    de caminos cambiados. <em>Sólo para repositorios de Subversion.</em></li>

<li><a name="view-graph"><strong>Vista de gráfico</strong></a> - Muestra un
    Representación gráfica de un archivo's revisiones y bifurcaciones completadas
    con nombres de etiqueta y autor y enlaces a páginas de marcado y diferenciador.
    <em>Sólo para repositorios CVS y desactivados en el valor por defecto
    configuración.</em></li>
  </ul>

<h3><a name="multiple-repositories">Varios repositorios</a></h3>

<p>A menudo se utiliza una única instalación de ViewVC para proporcionar acceso a
  más de un repositorio. En estas instalaciones, ViewVC muestra un
  <em>Raíz del proyecto</em> cuadro desplegable en la esquina superior derecha de cada
  página generada para permitir un acceso rápido a cualquier repositorio.</p>

<h3><a name="sticky-revision-tag">Revisión adhesiva y etiqueta</a></h3>

<p>Por defecto, ViewVC mostrará los archivos, directorios y revisiones
  que existen actualmente en el repositorio. Pero'también es posible examinar
  el contenido de un repositorio en un punto de su historia pasada eligiendo
  a "etiqueta adhesiva" (en CVS) o a "revisión pegajosa" (en subversión) de la
  formularios en la parte superior de las páginas de directorio y log. Ellos'llamado pegajoso
  porque una vez que're elegido, se quedan cuando navegas a
  otras páginas, hasta que las restablezcas. Cuando'volver a definir, directorio y log
  Las páginas sólo muestran las revisiones que preceden al punto especificado en el historial. En
  CVS, cuando una etiqueta hace referencia a una rama o a una revisión de una rama, solo
  Se muestran las revisiones del historial de sucursales, incluidos los puntos de sucursal y
  sus revisiones anteriores.</p>

<h3><a name="dead-files">Archivos muertos</a></h3>

<p>En las listas de directorios CVS, ViewVC puede mostrar opcionalmente archivos inactivos.
  Los archivos inactivos son archivos que solían estar en un directorio pero que actualmente están
  borrados o archivos que simplemente no't existe en la selección actual
  <a href="#sticky-revision-tag">etiqueta adhesiva</a>. Los archivos inactivos no pueden
  se muestra en los repositorios de Subversion. La única manera de ver un archivo eliminado en
  un directorio Subversion es navegar a una revisión permanente donde
  archivo existía anteriormente.</p>

<h3><a name="artificial-tags">Etiquetas artificiales</a></h3>

<p>En los repositorios CVS, ViewVC agrega etiquetas artificiales <em>CABEZA</em> y
  <em>Principal</em> para etiquetar listados y aceptarlos en lugar de revisión
  números y nombres de etiquetas reales en todas las URL. <em>Principal</em> actúa como una rama
  etiqueta que apunta a la rama por defecto, mientras <em>CABEZA</em> actúa como un
  etiqueta de revisión que apunta a la última revisión en la rama por defecto. El
  la rama por defecto suele ser solo el tronco, pero se puede definir en otro
  bifurcaciones dentro de archivos de repositorio individuales. CVS siempre comprobará
  revisiones de un archivo's rama por defecto cuando no se especifica ninguna otra rama
  en la línea de comandos.</p>

<h3><a name="more-information">Más información</a></h3>

<p>Más información sobre <em>ViewVC</em> está disponible desde
  <a href="http://viewvc.org/">viewvc.org</a>.
  Consulte los enlaces a continuación para obtener guías de CVS y Subversion</p>

<h4>Documentación sobre CVS</h4>
  <blockquote>
    <p>
      <a href="http://cvsbook.red-bean.com/"><em>Código abierto
      Desarrollo con CVS</em></a><br />
      <a href="http://www.loria.fr/~molli/cvs/doc/cvs_toc.html">CVS
      Usuario's Guía</a><br />
      <a href="http://cellworks.washington.edu/pub/docs/cvs/tutorial/cvs_tutorial_1.html">Otro tutorial de CVS</a><br />
      <a href="http://www.csc.calpoly.edu/~dbutler/tutorials/winter96/cvs/">Otro tutorial de CVS (un poco viejo, pero agradable)</a><br />
      <a href="http://www.cs.utah.edu/dept/old/texinfo/cvs/FAQ.txt">Preguntas frecuentes antiguas pero muy útiles sobre CVS</a>
    </p>
  </blockquote>

<h4>Documentación sobre Subversion</h3>
  <blockquote>
    <p>
      <a href="http://svnbook.red-bean.com/"><em>Control de versiones con
      Subversión</em></a><br />
    </p>
  </blockquote>

</td></tr></table>
  </body>
</html>
