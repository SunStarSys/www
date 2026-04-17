<! DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strikt//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>ViewVC Hjälp: Katalogvy</title>
  <link rel="stylesheet" href="help.css" type="text/css" />
</head>
<body>
  <table>
    <col class="menu" />
    <col />
    <tr>
      <td colspan="2">
	<h1>ViewVC Hjälp: Katalogvy</h1>
      </td>
    </tr>
    <tr><td>
       <h3>Hjälp</h3>
       <a href="help_rootview.html">Allmänt</a><br />
       <strong>Katalog&nbsp;Visa</strong><br />
       <a href="help_log.html">Logg&nbsp;Visa</a><br />

<h3>Internet</h3>
       <a href="http://viewvc.org/index.html">Hem</a><br />
       <a href="http://viewvc.org/upgrading.html">Uppgraderar</a><br />
       <a href="http://viewvc.org/contributing.html">Bidragande</a><br />
       <a href="http://viewvc.org/license-1.html">Licens</a><br />
    </td><td colspan="2">

<p>Kataloglistvyn bör vara en bekant syn för alla
    datoranvändare. Den visar sökvägen till den aktuella katalogen som visas
    högst upp på sidan. Nedan finns en tabell som sammanfattar
    kataloginnehåll, och sedan kommer faktiskt innehåll, en sorterbar lista över
    alla filer och underkataloger i den aktuella katalogen.</p>

<p><a name="summary"></a>Översiktstabellen består av några eller alla
    av följande rader:</p>
    <ul>
      <li><a name="summary-files-shown"><strong>Visade filer</strong></a>
      - Antal filer som visas i kataloglistan. Detta kan vara mindre
      än det faktiska antalet filer i katalogen, om
      <a href="#option-search">reguljär uttryckssökning</a> är på plats,
      dölja filer som inte't uppfylla sökkriterierna. I CVS-katalogen
      listor, den här raden kommer också att ha en länk för att växla visning av
      <a href="help_rootview.html#dead-files">döda filer</a>, om några är
      närvarande</li>

<li><a name="summary-revision"><strong>Katalog
      Revision</strong></a> - Endast för Subversion-kataloger.
      Visas som "Antal" där det första numret är det senaste
      datalagerrevision där katalogen (eller en sökväg under den)
      har ändrats. Den andra siffran är bara den senaste databasen
      revidering. Båda siffrorna är länkar till
      <a href="help_rootview.html#view-rev">revisionsvyer</a></li>

<li><a name="summary-sticky-revision-tag"><strong>Klistrad
     Revision/tagg</strong></a> - visar nuvarande
     <a href="help_rootview.html#sticky-revision-tag">klibbig revidering eller
     tagg</a> och innehåller formulärfält för att ställa in eller rensa den.</li>

<li><a name="summary-search"><strong>Aktuell sökning</strong></a> -
     Om en <a href="#option-search">reguljär uttryckssökning</a> är på plats,
     visar söksträngen.</li>

<li><a name="summary-query"><strong>Fråga</strong></a> - ger
     en länk till en <a href="help_rootview.html#view-query">frågeformulär</a>
     för katalogen</li>
   </ul>

<p><a name="list"></a>Den faktiska kataloglistan är en tabell med
  filnamn och katalognamn i en kolumn och information om
  de senaste versionerna där varje fil eller katalog ändrades i
  andra kolumner. Du kan klicka på kolumnrubriker för att sortera katalogen
  poster i ordning efter en kolumn och klickade igen för att omvända sorteringen
  beställning.</p>

<p>
  <!-- If using directory.ezt template -->
  Filnamn är länkar till <a href="help_log.html">loggvyer</a>
  visar en lista över revisioner där en fil har ändrats. Revision
  siffror är länkar till antingen
  <a href="help_rootview.html#view-markup">visa</a>
  eller <a href="help_rootview.html#view-checkout">hämta</a> en fil
  (beroende på filtyp). Länkarna är omvända för kataloger.
  Katalogrevisionsnumren är länkar till <a href="help_log.html">logg
  vyer</a>, medan katalognamn är länkar som visar innehållet i dessa
  kataloger.

<!-- If using dir_alt.ezt template -->
  <!--
  Fil- och katalognamn är länkar för att hämta deras innehåll.
  Fillänkar kan vara antingen
  <a href="help_rootview.html#view-markup">visa</a>
  eller <a href="help_rootview.html#view-download">hämta</a> länkar
  beroende på filtyp. Kataloglänkar går till katalogen
  listor. Revideringsnummer är länkar till <a href="help_log.html">logg
  vyer</a> visar listor över revisioner där en fil eller katalog fanns
  ändrad.
  -->

I CVS-datalager med <a
  href="help_rootview.html#view-diagram">diagramvy</a> aktiverad, där
  kommer att vara små ikoner bredvid filnamn som är länkar till revision
  diagram</p>

<p>Beroende på hur ViewVC har konfigurerats kan det finnas fler alternativ
  längst ned på katalogsidorna:</p>

<ul>
    <li><a name="option-search"><strong>Reguljärt uttryck
    söka</strong></a> - Om alternativet är aktiverat visas ett formulärfält som accepterar
    en söksträng (a
    <a href="http://doc.python.org/lib/re-syntax.html">regelbundet python
    uttryck</a>). En gång skickat, endast filer som har minst
    en förekomst av uttrycket visas i kataloglistor.
    </li>
    <li><a name="option-tarball"><strong>Tarball ladda ner</strong></a> -
    Om alternativet är aktiverat visas en länk för att ladda ned ett gzippat tar-arkiv för
    katalogens innehåll.</li>
  </ul>

</td></tr></table>
  </body>
</html>
