<!DOCTYPE html>
<html lang="{{ lang|cut:"." }}">
<head>
    <meta charset="utf-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1" name="viewport">
    <meta content="SunStar Systems" name="description">
    <meta content="Joe Schaefer" name="author">
    <meta content="{%for k in headers.keywords%}{{k}},{%endfor%}{{ facts.keywords }}" name="keywords">
    <meta content="black" name="theme-color">
        {% ifequal path|dirname "/orion" %}
	<meta content="/images/sunstar-orion-symbol-linear.png" property="og:image">
	{% else %}
	<meta content="/images/sunstarstaronly.png" property="og:image">
	{% endifequal %}
    <title>{% block title %}{{ facts.title|safe }} - {{ headers.title|safe }}{% endblock %}</title>
	{% if permalink %}
	<link href="https://{{website}}{{path|dirname}}/{{path|basename:0}}.html{{lang}}" rel="bookmark">
	{% endif %}
    <link href="/css/bootstrap.min.css" media="screen" rel="stylesheet">
    <link href="/css/code.css" media="screen" rel="stylesheet">
    <link href="/css/katex.min.css" media="screen" rel="stylesheet">
    <link href="/css/mermaid.min.css" media="screen" rel="stylesheet">
    <link href="/fontawesome/css/all.min.css" media="screen" rel="stylesheet">
    <link href="/editor.md/css/editormd.min.css" media="screen" rel="stylesheet">
    <link href="/editor.md/lib/codemirror/codemirror.min.css" media="screen" rel="stylesheet">
    <link href="/editor.md/lib/codemirror/theme/pastel-on-dark.css" media="screen" rel="stylesheet">
    <link href="/editor.md/lib/codemirror/theme/solarized.css" media="screen" rel="stylesheet">
    <link href="/css/local.css" media="screen" rel="stylesheet">
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
        <button aria-expanded="false" aria-label="Навигация" class="navbar-toggler" data-target="#navbarResponsive" data-toggle="collapse" type="button">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="navbar-brand">
	{% ifequal path|dirname "/orion" %}
	  <img alt="SunStar Символ Ориона линейный" src="/images/sunstar-orion-symbol-linear.png">
          <!-- Derived work from Dennis Moskowitz's original wikipedia image: CC-BySA v4.0 -->
	{% else %}
          <img alt="SunStar Линейный" src="/images/sunstarlinear.png" />
        {% endifequal %}
        </div>
      </div>

<div class="navbar-collapse collapse" id="navbarResponsive">
        <ul class="navbar-nav">
          <li class="nav-item{% ifequal path "/index.html"|append:lang %}
            active
            {% endifequal %}"><a class="nav-link text" href="/">Домашняя</a></li>
          <li class="nav-item{% ifequal path "/about.html"|append:lang %}
            active
            {% endifequal %}"><a class="nav-link text" href="/about">О программе</a></li>
          <li class="nav-item{% ifequal path "/contact.html"|append:lang %}
             active
             {% endifequal %}"><a class="nav-link" href="/contact">Контакт</a></li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Продукты... <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li class="dropdown-item{% ifequal path "/orion/index.html"|append:lang %}
                active
                {% endifequal %}"><a class="nav-link text-white" href="/orion/index.html{{ lang }}">Орион&trade; Корпоративная вики-страница</a></li>
              <li class="dropdown-item{% ifequal path "/orion/plans.html"|append:lang %}
                active
                {% endifequal %}"><a class=«nav-link текст-белый»
                href="/orion/plans.html{{ lang }}»>Ценовые планы Orion</a></li>
            </ul>
          </li>
          <li class="nav-item{% ifequal path "/open-source.html"|append:lang %}
            active
																{% endifequal %}"><a class="nav-link" href="/open-source">Открытый исходный код</a></li>

<li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Дополнительно.. <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li class="dropdown-item">
                <a class="nav-link text-white" href="https://vcs.sunstarsys.com/viewvc/public/cms-sites/www.sunstarsys.com/trunk/">Источник сайта</a>
              </li>
              <li class="dropdown-item divider"></li>
              <li class="dropdown-header text-white">Карты сайтов</li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname}}/{{path|basename:0}}.html.en">Английский</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname}}/{{path|basename:0}}.html.es">Испанский</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname}}/{{path|basename:0}}.html.de">Немецкий</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname}}/{{path|basename:0}}.html.fr">Французский</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname}}/{{path|basename:0}}.html.ru">Русский</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname}}/{{path|basename:0}}.html.zh-TW">Китайский</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname}}/{{path|basename:0}}.html.he">Иврит</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname}}/{{path|basename:0}}.html.sv">шведский</a></li>

<li class="dropdown-item divider"></li>
              <li class="dropdown-header text-white">Взаимодействие</li>
              <li class="dropdown-item"><a class="nav-link text-white" href="/clients">Клиенты</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="https://www.iconoclasts.blog/joe/">Эссе</a></li>
              <li class="dropdown-item divider"></li>
              <li class="dropdown-header text-white">Таксономии</li>
              <li class="dropdown-item"><a class="nav-link text-white" href="/categories">Категории</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="/archives">Архивы</a></li>
            </ul>
          </li>

<li class="nav-item{% ifequal path "/powered-by.html"|append:lang %}
            active
            {% endifequal %}"><a class="nav-link" href="/powered-by">На базе...</a>
          </li>
        </ul>
      </div>
      <div class="row right" id='search'>
        <form action="/dynamic/search{% ifequal path|dirname "/" %}{% else %}{{ path|dirname
            }}{% endifequal %}/" class="form-inline right" method="GET">
          <input name="lang" type="hidden" value="{{ lang }}" />
          <input class=form-control type=text name=regex
               placeholder=PCRE
 рекурсивный поиск value={{ regex }}" />&nbsp;<button class="btn btn-outline-danger" name="submit" type="submit" value="1">
	    Поиск
          </button>&nbsp;
          <input class=form-control form-check-input type=checkbox name=markdown_search
          id=markdown-search value=1 {% if markdown_search %}отмечено{% endif %}/><label for="markdown-search"><small>Снижение цен</small></label>
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
        <img alt="Значок изменения" src="/images/edit.png" />
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
  <script src="/editor.md/js/jquery.flowchart.min.js"></script>
  <script src="/editor.md/js/sequence-diagram.min.js"></script>
  <script src="/editor.md/js/d3.min.js"></script>
  <script src="/editor.md/js/wasm/index.min.js"></script>
  <script src="/editor.md/js/d3-graphviz.js"></script>
  <script src="/editor.md/js/mermaid.min.js"></script>
  <script src="/editor.md/js/mermaid-mindmap.min.js"></script>
  <script src="/editor.md/lib/codemirror/codemirror.min.js"></script>
  <script src="/editor.md/lib/codemirror/addons.min.js"></script>
  <script src="/editor.md/lib/codemirror/modes.min.js"></script>
  <script defer src="/editor.md/lib/copy-tex.js"></script>

<script blocking="render" async type="text/javascript">
    if (typeof(editormd) === "undefined") {
        mermaid.registerExternalDiagrams([window["mermaid-mindmap"]]);
        mermaid.initialize({theme: "dark", startOnLoad: true, securityLevel: "loose"});
        $(".flowchart").flowChart();
        $(".sequence-diagram").sequenceDiagram();
        for (const e of $("body").find(".graphviz").toArray()) {
            d3.select(e).graphviz({useWorker: false}).renderDot($(e).text());
            e.innerHTML = ""
        }
        $("body").find("pre").parent().addClass("editormd-preview-theme-dark");
        CodeMirror.colorize();
    }
    if (document.cookie.indexOf("gdpr_analytics=1") == -1 &&
    document.cookie.indexOf("gdpr_decline=1") == -1) {
        for (const h1 of document.getElementsByTagName("h1")) {
            var html = `<div id="analytics"><br><div class="card border-warning">
<div class="card-header">
  <h3 class="card-title text-dark">This Site Uses Cookies for Analytics.</h4>
</div>
<div class="card-body">
<p class="card-text">
<small class="text-dark">Please choose your Analytics preference:</small><br>
  <button type="button" class="btn btn-outline-warning text-white" data-bs-dismiss="alert"
  onClick="document.cookie='gdpr_analytics=1; path=/; max-age=8640000';
  $('#analytics').css('display', 'none');true">I Consent.</button> &nbsp;
  <button type="button" class="btn btn-outline-danger text-dark" data-bs-dismiss="alert"
  onClick="document.cookie='gdpr_decline=1; path=/; max-age=864000';
  $('#analytics').css('display', 'none');true">I
  Decline.</button><br><small class="text-dark">Should you elect to
  Decline, we will not ask again for the next 10 days.</small>
</p>
</div>
</div>
</div>`;
            h1.insertAdjacentHTML('beforeend', html);
        }
    }
    else if (document.cookie.indexOf("gdpr_decline=1") == -1) {
        document.cookie = 'gdpr_analytics=1; path=/; max-age=8640000';
    }
  </script>

<script async type="module">
    if (document.cookie.indexOf("can_search") >= 0 && Notification.permission !== "denied") {
		var permission = Notification.permission;
		if (permission !== "granted") {
            Notification.requestPermission().then((result) => {
              permission = result;
            });
        }
        if (permission === "granted") {
		   var revision;
           var m = document.cookie.match(/last=([0-9]+)/);
           if (m)
			 revision = m[1];
           const response = await fetch("/dynamic/search/?regex=notify="+revision+";lang={{lang}};markdown_search=1;as_json=1",
                           {credentials: 'same-origin'});
           try {
              const json = await response.json();
              for (const e of json.log) {
                  var msg = e[3] + "\n";
                  for (const [key, val] of Object.entries(e[1])) {
                      msg += val.action + " " + key.replace(/^.*\//, "") + "\n";
				  }
				  var n = new Notification(e[2],
     			    {
					  body: msg,
					  tag: e[0],
					  icon: "/favicon",
					  image: "/images/sunstarstaronly",
				    }
			  	  );
			      n.addEventListener("click", () => {window.open("https://{{website}}/dynamic/search/?regex=diff="+e[0]+";lang={{lang}};markdown_search=1") }, { capture: true });
			  }
		   }
           catch (e) {
             // alert(e);
		   }
        }
	}
  </script>
  {% block javascript %}{% endblock %}
</div>
</body>
</html>
