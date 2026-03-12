<!DOCTYPE html>
<html lang="{{ lang|cut:"." }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="SunStar Systems">
    <meta name="author" content="Joe Schaefer">
    <meta name="keywords" content="{%for k in headers.keywords%}{{k}},{%endfor%}{{ facts.keywords }}">
    <meta name="theme-color" content="black">
        {% ifequal path|dirname "/orion" %}
	<meta property="og:image" content="/images/sunstar-orion-symbol-linear.png">
	{% else %}
	<meta property="og:image" content="/images/sunstarstaronly.png">
	{% endifequal %}
    <title>{% block title %}{{ facts.title|safe }} - {{ headers.title|safe }}{% endblock %}</title>
	{% if permalink %}
	<link rel="bookmark" href="https://{{website}}{{path|dirname|append:"/"}}{{path|basename:0}}.html{{lang}}">
	{% endif %}
    <link href="/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="/css/code.css" rel="stylesheet" media="screen">
    <link href="/css/katex.min.css" rel="stylesheet" media="screen">
    <link href="/css/mermaid.min.css" rel="stylesheet" media="screen">
    <link href="/fontawesome/css/all.min.css" rel="stylesheet" media="screen">
    <link href="/editor.md/css/editormd.min.css" rel="stylesheet" media="screen">
    <link href="/editor.md/lib/codemirror/codemirror.min.css" rel="stylesheet" media="screen">
    <link href="/editor.md/lib/codemirror/theme/pastel-on-dark.css" rel="stylesheet" media="screen">
    <link href="/editor.md/lib/codemirror/theme/solarized.css" rel="stylesheet" media="screen">
    <link href="/css/local.css" rel="stylesheet" media="screen">
    <link href="/favicon.png" rel="icon">
    <script src="/editor.md/js/jquery.min.js"></script>
    {% block header %}{% endblock %}
    {% block analytics %}
    {% include "analytics.html" %}
    {% endblock %}
</head>

<body>
<header>
  <div class="navbar navbar-expand-lg fixed-top bg-light navbar-light">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="navbar-brand">
	{% ifequal path|dirname "/orion" %}
	  <img src="/images/sunstar-orion-symbol-linear.png" alt="SunStar Orion Symbol Linear">
          <!-- Derived work from Dennis Moskowitz's ursprungliga Wikipedia-bild: CC-BySA v4.0 -->
	{% else %}
          <img src="/images/sunstarlinear.png" alt="SunStar Linear"/>
        {% endifequal %}
        </div>
      </div>

<div class="navbar-collapse collapse" id="navbarResponsive">
        <ul class="navbar-nav">
          <li class="nav-item{% ifequal path "/index.html"|append:lang %}
            deltagande
            {% endifequal %}"><a class="nav-link text" href="/">Hem</a></li>
          <li class="nav-item{% ifequal path "/about.html"|append:lang %}
            deltagande
            {% endifequal %}"><a class="nav-link text" href="/about">Om</a></li>
          <li class="nav-item{% ifequal path "/contact.html"|append:lang %}
             deltagande
             {% endifequal %}"><a class="nav-link" href="/contact">Kontakt</a></li>
          <li class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Produkter... <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li class="dropdown-item{% ifequal path "/orion/index.html"|append:lang %}
                deltagande
                {% endifequal %}"><a class="nav-link text-white" href="/orion/index.html{{ lang }}">Orion&trade; #Jamstack Wiki-plattform</a></li>
              <li class="dropdown-item{% ifequal path "/orion/plans.html"|append:lang %}
                deltagande
                {% endifequal %}"><a class="nav-link text-white"
                href="/orion/plans.html{{ lang }}">Prisplaner för Orion</a></li>
            </ul>
          </li>
          <li class="nav-item{% ifequal path "/open-source.html"|append:lang %}
            deltagande
																{% endifequal %}"><a class="nav-link" href="/open-source">Öppen källkod</a></li>

<li class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Mer... <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li class="dropdown-item">
                <a class="nav-link text-white" href="https://vcs.sunstarsys.com/repos/svn/public/cms-sites/www.sunstarsys.com/trunk/">Platskälla</a>
              </li>
              <li class="dropdown-item divider"></li>
              <li class="dropdown-header text-white">i18n</li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.en">Engelska</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.es">Spanska</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.de">Tyska</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.fr">Franska</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.ru">Ryska</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.zh-TW">kinesiska</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.he">Hebreiska</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.sv">Svenska</a></li>

<li class="dropdown-item divider"></li>
              <li class="dropdown-header text-white">Engagemang</li>
              <li class="dropdown-item"><a class="nav-link text-white" href="/clients">Kunder</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="https://www.iconoclasts.blog/joe/">Essäer</a></li>
              <li class="dropdown-item divider"></li>
              <li class="dropdown-header text-white">Taxonomier</li>
              <li class="dropdown-item"><a class="nav-link text-white" href="/categories">Kategorier</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="/archives">Arkiv</a></li>
            </ul>
          </li>

<li class="nav-item{% ifequal path "/powered-by.html"|append:lang %}
            deltagande
            {% endifequal %}"><a class="nav-link" href="/powered-by">Drivs av...</a>
          </li>
        </ul>
      </div>
      <div class="row right" id='search'>
        <form action="/dynamic/search{% ifequal path|dirname "/" %}{% else %}{{ path|dirname
            }}{% endifequal %}/" klass="höger form-inline" metod="Hämta">
          <input type="hidden" name="lang" value="{{ lang }}" />
          <input class="form-control" type="text" name="regex"
               placeholder="PCRE
 Rekursiv sökning" värde="{{ regex }}" />&nbsp;<button type="submit" name="submit" value="1" class="btn btn-outline-danger">
	    Sök
          </button>&nbsp;
          <input class="form-control form-check-input" type="checkbox" name="markdown_search"
          id="nedsättningssökning" värde="1" kontrollerad /><label for="markdown-search"><small>Nedsättning</small></label>
        </form>
      </div>
    </div>
  </div>
</header>

{% block alert %}
  {% if alert %}
  <div class="alert alert-dismissible alert-info container">
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    {{ alert|markdown }}
  </div>
  {% endif %}
{% endblock %}

<div class="container theme-showcase" id="content">
  {% block content %}
  <div class="breadcrumbs">
      {{ breadcrumbs|safe }}&nbsp;&nbsp;<a href="javascript:void(location.href='https://cms.sunstarsys.com/redirect?uri='+escape(location.href))">
        <img src="/images/edit.png" alt="Edit Icon" />
      </a>
  </div>
  <h1>{{ headers.title|safe }}</h1>
  <div class="jumbotron">{{ content|markdown }}</div>
  {% endblock %}

<footer>{% block footer %}{% endblock footer %}</footer>

<script src="/editor.md/js/bootstrap.bundle.min.js"></script>
  <script src="/editor.md/js/raphael.min.js"></script>
  <script src="/editor.md/js/underscore.min.js"></script>
  <script src="/editor.md/js/flowchart.min.js"></script>
  <!-- <script src="/editor.md/js/jquery.flowchart.min.js"></script> -->
  <script src="/editor.md/js/sequence-diagram.min.js"></script>
  <script src="/editor.md/js/d3.min.js"></script>
  <script src="/editor.md/js/wasm/index.min.js"></script>
  <script src="/editor.md/js/d3-graphviz.js"></script>
  <script src="/editor.md/lib/mermaid.min.js"></script>

<script src="/editor.md/lib/codemirror/codemirror.min.js"></script>
  <script src="/editor.md/lib/codemirror/addons.min.js"></script>
  <script src="/editor.md/lib/codemirror/modes.min.js"></script>
  <script defer src="/editor.md/lib/copy-tex.js"></script>

<script blocking="render" async type="text/javascript">
    if (typeof(editormd) === "odefinierad") {
        
        mermaid.initialize({tema: "mörk", startOnLoad: sant, securityLevel: "utlevad"});
        $(".sekvensdiagram").sequenceDiagram();
        för (const e of $("kropp").find("grafviz").toArray()) {
            d3.select(e).graphviz({useWorker: falskt}).renderDot($(e).text());
            e.innerHTML = ""
        }
        $("kropp").find("före").parent().addClass("editormd-preview-theme-dark");
        CodeMirror.colorize();
    }
    om (document.cookie.indexOf("gdpr_analytics=1") == -1 &amp;&amp;
    document.cookie.indexOf("gdpr_decline=1") == -1) {
        för (konst h1 av document.getElementsByTagName("h1")) {
            Var html = `<div id="analytics"><br><div class="card border-warning">
<div class="card-header">
  <h3 class="card-title text-dark">Den här webbplatsen använder cookies för analys.</h4>
</div>
<div class="card-body">
<p class="card-text">
<small class="text-dark">Välj din analyspreferens:</small><br>
  <button type="button" class="btn btn-outline-warning text-white" data-bs-dismiss="alert"
  onClick="document.cookie='gdpr_analytics=1; sökväg=/; maxålder=8640000';
  $('#analytics').css('visa', 'inget');sant">Jag samtycker.</button> &nbsp;
  <button type="button" class="btn btn-outline-danger text-dark" data-bs-dismiss="alert"
  onClick="document.cookie='gdpr_decline=1; sökväg=/; maxålder=864000';
  $('#analytics').css('visa', 'inget');sant">I
  Avslå.</button><br><small class="text-dark">Om du väljer att
  Avböj, vi kommer inte att fråga igen för de kommande 10 dagarna.</small>
</p>
</div>
</div>
</div>`;
            h1.insertAdjacentHTML('försenad', html);
        }
    }
    annars om (document.cookie.indexOf("gdpr_decline=1") == -1) {
        document.cookie = 'gdpr_analytics=1; sökväg=/; maxålder=8640000';
    }
  </script>

<script async type="module">
    om (document.cookie.indexOf("can_search") >= 0 &amp;&amp; Notification.permission !== "nekad") {
		var-behörighet = Notification.permission;
		om (behörighet !== "beviljad") {
            Notification.requestPermission().then(((resultat) => {
              permission = resultat;
            });
        }
        Om (behörighet === "beviljad") {
		   Revidering.
           var m = document.cookie.match(/last=([0-9]+)/);
           om (m)
			 revision = m[1];
           konst svar = väntar på hämtning("/dynamic/search/?regex=notify="+revision+";språk={{lang}};markdown_search=1;as_json=1",
                           {inloggningsuppgifter: 'samma ursprung'});
           försöka {
              konst json = vänta på response.json();
              för (st e av json.log) {
                  var meddelande = e[3] + "\n";
                  för (konstnär [nyckel, val] av Object.entries(e)[1])) {
                      Meddelande += val.action + " " + key.replace(/^.*\//, "") + "\n";
				  }
				  var n = nytt meddelande (e)[2],
     			    {
					  body: meddelande,
					  tag: e[0],
					  icon: "/favikon",
					  image: "/images/sunstarstaronly",
				    }
			  	  );
			      n.addEventListener("klicka", () => {window.open("https://{{website}}/dynamic/search/?regex=diff="+e[0]+";språk={{lang}};markdown_search=1") }, { capture: sant });
			  }
		   }
           fångst (e) {
             // varning(e);
		   }
        }
	}
  </script>
  {% block javascript %}{% endblock %}
</div>
</body>
</html>
