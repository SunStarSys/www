<! DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strikt//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>ViewVC Hjälp: Allmänt</title>
  <link rel="stylesheet" href="help.css" type="text/css" />
</head>
<body>
  <table>
    <col class="menu" />
    <col />
    <tr>
      <td colspan="2">
	<h1>ViewVC Hjälp: Allmänt</h1>
      </td>
    </tr>
    <tr><td>
       <h3>Hjälp</h3>
       <strong>Allmänt</strong><br />
       <a href="help_dirview.html">Katalog&nbsp;Visa</a><br />
       <a href="help_log.html">Logg&nbsp;Visa</a><br />

<h3>Internet</h3>
       <a href="http://viewvc.org/index.html">Hem</a><br />
       <a href="http://viewvc.org/upgrading.html">Uppgraderar</a><br />
       <a href="http://viewvc.org/contributing.html">Bidragande</a><br />
       <a href="http://viewvc.org/license-1.html">Licens</a><br />
    </td><td colspan="2">

<p><em>ViewVC</em> är ett WWW-gränssnitt för CVS och Subversion
  datalager. Det låter dig bläddra bland filer och kataloger i en
  datalager när du visar metadata från datalagerhistoriken: logg
  meddelanden, ändringsdatum, namn på upphovsman, revisionsnummer, kopiera
  Historia och så vidare. Det finns flera olika vyer av datalagret
  data som hjälper dig att hitta den information du söker:</p>

<ul>
    <li><a name="view-dir" href="help_dirview.html"><strong>Katalog
    Visa</strong></a> - Visar en lista över filer och underkataloger i en
    katalog för datalagret, tillsammans med metadata som författarnamn och
    loggposter</li>

<li><a name="view-log" href="help_log.html"><strong>Logg
    Visa</strong></a> - Visar en revisionslista per revisionslista över alla
    ändringar som har gjorts i en fil eller katalog i databasen, med
    metadata och länkar till vyer för varje revision.</li>

<li><a name="view-markup"><strong>Vy över filinnehåll (märkning)
    Visa)</strong></a> - Visar innehållet i en fil på en viss
    revision, med revisionsinformation högst upp på sidan. Fil
    versioner som är GIF-, PNG- eller JPEG-bilder visas infogade på
    sidan. Andra filtyper visas som markerad text. Märkningen
    kan begränsas till att omvandla webbadresser och e-postadresser till länkar, eller
    konfigurerad för att visa färgad källkod.</li>

<li><a name="view-checkout"><strong>Filnedladdning (kassa)
    Visa)</strong></a> - Hämtar det oförändrade innehållet i en fil
    revidering. Webbläsare kan försöka visa filen, eller bara spara den till
    disk.</li>

<li><a name="view-annotate"><strong>Filanteckningsvy</strong></a> -
    Visar innehållet i en filrevision och bryter ned det rad för rad.
    visar revisionsnumret där var och en senast ändrades, tillsammans med
    med länkar och annan information. <em>Den här vyn är inaktiverad i vissa
    ViewVC-konfigurationer</em></li>

<li><a name="view-diff"><strong>Diff.vy för fil</strong></a> - Föreställningar
    ändringar som gjorts mellan två revisioner av en fil</li>

<li><a name="view-tarball"><strong>Katalogvy över tarball</strong> -
    Hämtar ett komprimerat tar-arkiv som innehåller innehållet i ett
    katalog.<em>Den här vyn är avaktiverad i standardvyn ViewVC
    konfiguration.</em></li>

<li><a name="view-query"><strong>Vy över katalogfråga</strong></a> -
    Visar information om ändringar som gjorts i alla underkataloger och filer
    under en överordnad katalog, sorterade och filtrerade efter angivna kriterier.
    <em>Den här vyn är avaktiverad i standardkonfigurationen av ViewVC.</em>
    </li>

<li><a name="view-rev"><strong>Revisionsvy</strong> - Föreställningar
    information om en revision, inklusive loggmeddelande, författare och en lista
    av ändrade vägar. <em>Endast för Subversion-datalager.</em></li>

<li><a name="view-graph"><strong>Diagramvy</strong></a> - Visar en
    grafisk representation av en fil's revisioner och grenar slutförda
    med tagg- och författarnamn och länkar till märksidor och diffsidor.
    <em>Endast för CVS-datalager och avaktiverad som standard
    konfiguration.</em></li>
  </ul>

<h3><a name="multiple-repositories">Flera datalager</a></h3>

<p>En enda installation av ViewVC används ofta för att ge tillgång till
  mer än ett datalager. I dessa installationer visar ViewVC en
  <em>Projektrot</em> nedrullningsbar ruta i det övre högra hörnet av varje
  genererad sida som ger snabb åtkomst till alla datalager.</p>

<h3><a name="sticky-revision-tag">Sticky revision och tagg</a></h3>

<p>Som standard visar ViewVC filer och kataloger och revisioner
  som för närvarande finns i databasen. Men det's också möjligt att bläddra
  innehållet i en databas vid en tidpunkt i historiken genom att välja
  år "fästing" (i CVS) eller en "klibbig revidering" (i Subversion) från
  formulär överst i katalogen och loggsidorna. De'Kallas även sticky
  För en gångs skull'De är utvalda när du navigerar till
  andra sidor, tills du återställer dem. När de'ändra inställning, katalog och logg
  sidor visar endast revisioner som föregår den angivna historiken. Inom
  CVS, när en tagg refererar till en gren eller en revision på en gren, endast
  revisioner från grenshistoriken visas, inklusive grenspunkter och
  tidigare revideringar.</p>

<h3><a name="dead-files">Döda filer</a></h3>

<p>I CVS-kataloglistor kan ViewVC (valfritt) visa döda filer.
  Döda filer är filer som tidigare fanns i en katalog men som för närvarande
  raderade, eller filer som bara inte't finns i den valda
  <a href="#sticky-revision-tag">fästing</a>. Döda filer kan inte
  visas i Subversion-datalager. Det enda sättet att se en borttagen fil i
  en Subversion-katalog är att navigera till en klibbig revision där
  Filen fanns tidigare.</p>

<h3><a name="artificial-tags">Konstgjorda taggar</a></h3>

<p>I CVS-datalager lägger ViewVC till artificiella taggar <em>Huvud</em> och
  <em>HUVUD</em> att tagga listor och acceptera dem i stället för revision
  siffror och riktiga taggnamn i alla URL:er. <em>HUVUD</em> fungerar som en gren
  tagg som pekar på standardgrenen, medan <em>Huvud</em> fungerar som en
  revisionstagg som pekar på den senaste revisionen på standardgrenen. Den
  standardgrenen är vanligtvis bara bagageutrymmet, men kan ställas in på en annan
  grenar inuti enskilda datalagerfiler. CVS kommer alltid att kolla
  revisioner från en fil'standardgren när ingen annan gren har angetts
  på kommandoraden.</p>

<h3><a name="more-information">Mer information</a></h3>

<p>Mer information om <em>ViewVC</em> är tillgänglig från
  <a href="http://viewvc.org/">viewvc.org</a>.
  Se länkarna nedan för guider till CVS och Subversion</p>

<h4>Dokumentation om CVS</h4>
  <blockquote>
    <p>
      <a href="http://cvsbook.red-bean.com/"><em>Öppen källkod
      Utveckling med CVS</em></a><br />
      <a href="http://www.loria.fr/~molli/cvs/doc/cvs_toc.html">CVS
      Användare's Guide</a><br />
      <a href="http://cellworks.washington.edu/pub/docs/cvs/tutorial/cvs_tutorial_1.html">Ytterligare CVS-handledning</a><br />
      <a href="http://www.csc.calpoly.edu/~dbutler/tutorials/winter96/cvs/">Ännu en CVS tutorial (lite gammal, men trevlig)</a><br />
      <a href="http://www.cs.utah.edu/dept/old/texinfo/cvs/FAQ.txt">En gammal men mycket användbar FAQ om CVS</a>
    </p>
  </blockquote>

<h4>Dokumentation om Subversion</h3>
  <blockquote>
    <p>
      <a href="http://svnbook.red-bean.com/"><em>Versionskontroll med
      Subversion</em></a><br />
    </p>
  </blockquote>

</td></tr></table>
  </body>
</html>
