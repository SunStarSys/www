< DOCTYPE html PÚBLICO "-//W3C//DTD XHTML 1.0 Estricto//ES" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>ViewVC Ayuda: Vista de Log</title>
  <link rel="stylesheet" href="help.css" type="text/css" />
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
</head>
<body>
  <table>
    <col class="menu" />
    <col />
    <tr>
      <td colspan="2">
	<h1>ViewVC Ayuda: Vista de Log</h1>
      </td>
    </tr>
    <tr><td>
       <h3>Ayuda</h3>
       <a href="help_rootview.html">General</a><br />
       <a href="help_dirview.html">Directorio&nbsp;Ver</a><br />
       <strong>Registro&nbsp;Ver</strong><br />

<h3>Internet</h3>
       <a href="http://viewvc.org/index.html">Inicio</a><br />
       <a href="http://viewvc.org/upgrading.html">Actualizando</a><br />
       <a href="http://viewvc.org/contributing.html">Contribución</a><br />
       <a href="http://viewvc.org/license-1.html">Licencia</a><br />
    </td><td colspan="2">
    <p>
      La vista de log muestra el historial de revisiones del origen seleccionado
      archivo o directorio. Para cada revisión, la siguiente información es
      displayed:

<ul>
        <li>Número de revisión. En los repositorios de Subversion, esto es
            enlace al <a href="help_rootview.html#view-rev">revisión
            vista</a></li>
        <li>Para archivos, enlaces a
        <a href="help_rootview.html#view-markup">vista</a>,
        <a href="help_rootview.html#view-checkout">descargar</a>y
        <a href="help_rootview.html#view-annotate">anotar</a> el
          revisión. Para directorios, un enlace a
        <a href="help_dirview.html">mostrar contenido del directorio</a></li>
        <li>Un enlace para seleccionar la revisión para las diferencias (consulte a continuación)</li>
        <li>Fecha y edad del cambio</li>
        <li>El autor de la modificación</li>
        <li>La rama CVS (generalmente <em>Principal</em>, si no en una sucursal)</li>
        <li>Posiblemente una lista de etiquetas CVS enlazadas a la revisión (si las hay)</li>
        <li>El tamaño del cambio medido en líneas añadidas y eliminadas de
            código. (sólo CVS)</li>
        <li>Tamaño del archivo en bytes en el momento de la revisión
            (Solo subversión)</li>
        <li>Enlaces para ver diferencias con la revisión anterior o posiblemente con
            una revisión seleccionada arbitraria (si la hay, véase más arriba)</li>
        <li>Si la revisión es el resultado de una copia, la ruta y la revisión
            copiado de</li>
        <li>Si la revisión precede a una copia o cambia el nombre, la ruta en la
            hora de la revisión</li>
        <li>Y por último, pero no menos importante, el mensaje de log de confirmación que debe indicar
            sobre la razón del cambio.</li>
      </ul>
    <p>
      En la parte inferior de la página encontrará un formulario que permite
      para solicitar diferencias entre revisiones arbitrarias.
    </p>
  </td></tr></table>
  </body>
</html>
