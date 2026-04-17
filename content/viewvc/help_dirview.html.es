< DOCTYPE html PÚBLICO "-//W3C//DTD XHTML 1.0 Estricto//ES" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>ViewVC Ayuda: Vista de Directorio</title>
  <link rel="stylesheet" href="help.css" type="text/css" />
</head>
<body>
  <table>
    <col class="menu" />
    <col />
    <tr>
      <td colspan="2">
	<h1>ViewVC Ayuda: Vista de Directorio</h1>
      </td>
    </tr>
    <tr><td>
       <h3>Ayuda</h3>
       <a href="help_rootview.html">General</a><br />
       <strong>Directorio&nbsp;Ver</strong><br />
       <a href="help_log.html">Registro&nbsp;Ver</a><br />

<h3>Internet</h3>
       <a href="http://viewvc.org/index.html">Inicio</a><br />
       <a href="http://viewvc.org/upgrading.html">Actualizando</a><br />
       <a href="http://viewvc.org/contributing.html">Contribución</a><br />
       <a href="http://viewvc.org/license-1.html">Licencia</a><br />
    </td><td colspan="2">

<p>La vista de lista de directorios debe ser familiar para cualquier
    usuario informático. Muestra la ruta del directorio actual que se está visualizando
    Al principio de la página. A continuación se muestra una tabla que resume la
    contenido del directorio y, a continuación, el contenido real, una lista ordenable de
    Todos los archivos y subdirectorios dentro del directorio actual.</p>

<p><a name="summary"></a>La tabla de resumen está formada por algunos o todos
    de las siguientes filas:</p>
    <ul>
      <li><a name="summary-files-shown"><strong>Archivos mostrados</strong></a>
      - Número de archivos que se muestran en la lista de directorios. Esto podría ser menos
      que el número real de archivos en el directorio si
      <a href="#option-search">búsqueda de expresiones regulares</a> está en vigor,
      ocultar archivos que no't cumplen los criterios de búsqueda. En el directorio CVS
      listados, esta fila también tendrá un enlace para alternar la visualización de
      <a href="help_rootview.html#dead-files">archivos muertos</a>, si existen
      presente.</li>

<li><a name="summary-revision"><strong>Directorio
      Revisión</strong></a> - Solo para directorios Subversion.
      Se muestra como "Nº de nº" donde el primer número es el más reciente
      revisión del repositorio donde se encuentra el directorio (o una ruta debajo de él)
      se modificó. El segundo número es solo el último repositorio
      revisión. Ambos números están vinculados a
      <a href="help_rootview.html#view-rev">vistas de revisión</a></li>

<li><a name="summary-sticky-revision-tag"><strong>Nexo
     Revisión/Etiqueta</strong></a> - muestra la actual
     <a href="help_rootview.html#sticky-revision-tag">revisión permanente o
     etiqueta</a> y contiene campos de formulario para definirlos o borrarlos.</li>

<li><a name="summary-search"><strong>Búsqueda actual</strong></a> -
     Si <a href="#option-search">búsqueda de expresiones regulares</a> está en vigor,
     muestra la cadena de búsqueda.</li>

<li><a name="summary-query"><strong>Consulta</strong></a> - Proporciona
     un vínculo a un <a href="help_rootview.html#view-query">formulario de consulta</a>
     para el directorio</li>
   </ul>

<p><a name="list"></a>La lista de directorios real es una tabla con
  nombres de archivo y nombres de directorio en una columna e información sobre
  revisiones más recientes en las que cada archivo o directorio se modificó en la
  otras columnas. Se puede hacer clic en las cabeceras de columna para ordenar el directorio
  entradas en orden por columna y se vuelve a hacer clic para revertir la ordenación
  orden.</p>

<p>
  <!-- If using directory.ezt template -->
  Los nombres de archivo son enlaces a <a href="help_log.html">vistas de log</a>
  que muestra una lista de revisiones en las que se modificó un archivo. Revisión
  números son vínculos con cualquiera de
  <a href="help_rootview.html#view-markup">vista</a>
  o <a href="help_rootview.html#view-checkout">descargar</a> un archivo
  (según su tipo de archivo). Los enlaces se invierten para los directorios.
  Los números de revisión del directorio son enlaces a <a href="help_log.html">registro
  vistas</a>, mientras que los nombres de directorio son enlaces que muestran el contenido de esos
  directorios.

<!-- If using dir_alt.ezt template -->
  <!--
  Los nombres de archivos y directorios son enlaces para recuperar su contenido.
  Los enlaces de archivo pueden ser
  <a href="help_rootview.html#view-markup">vista</a>
  o <a href="help_rootview.html#view-download">descargar</a> enlaces
  dependiendo del tipo de archivo. Los enlaces de directorio van al directorio
  listados. Los números de revisión son enlaces a <a href="help_log.html">registro
  vistas</a> que muestra listas de revisiones en las que un archivo o directorio estaba
  modificado.
  -->

Además, en los repositorios de CVS con la <a
  href="Gráfico help_rootview.html#view">vista de gráfico</a> habilitado, allí
  serán pequeños iconos junto a los nombres de archivo que son enlaces a revisión
  gráficos.</p>

<p>Según cómo se configure ViewVC, puede haber más opciones
  en la parte inferior de las páginas del directorio:</p>

<ul>
    <li><a name="option-search"><strong>Expresión regular
    búsqueda</strong></a> - Si se activa, se mostrará un campo de formulario que acepta
    una cadena de búsqueda (a
    <a href="http://doc.python.org/lib/re-syntax.html">regular de Python
    expresión</a>). Una vez enviados, solo los archivos que tienen al menos
    una aparición de la expresión se mostrará en las listas de directorios.
    </li>
    <li><a name="option-tarball"><strong>Tarball descargar</strong></a> -
    Si se activa, se mostrará un enlace para descargar un archivo tar comprimido de
    el contenido del directorio.</li>
  </ul>

</td></tr></table>
  </body>
</html>
