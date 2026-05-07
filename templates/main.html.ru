<!DOCTYPE html>
<html lang="{{ lang|cut:"." }}"{% ifequal lang ".he" %} dir="rtl"{% endifequal %}{% ifequal lang ".ar" %} dir="rtl"{% endifequal %}>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="SunStar Systems">
    <meta name="author" content="Joe Schaefer">
    <meta name="keywords" content="{%for k in headers.keywords%}{{k}},{%endfor%}{{ facts.keywords }}">
    <meta name="theme-color" content="black">
        {% if path|starts_with:"/orion/" %}
	<meta property="og:image" content="/images/sunstar-orion-symbol-linear.png">
	{% else %}
	<meta property="og:image" content="/images/sunstarstaronly.png">
	{% endif %}
    <meta property="og:title" content="{{ headers.title|safe }} - {{ facts.title|safe }}">
    <meta property="og:description" content="{{content|lede|markdown|striptags}}">
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
    <link href="/editor.md/lib/codemirror/theme/midnight.css" rel="stylesheet" media="screen">
    <link href="/css/local.css" rel="stylesheet" media="screen">
    <link href="/favicon.png" rel="icon">
    <script src="/editor.md/js/jquery.min.js"></script>
	<script src="/js/bootstrap.min.js"></script>
	{% block header %}{% endblock %}
    {% block analytics %}
    {% include "analytics.html" %}
    {% endblock %}
</head>

<body>
<header style="border-bottom:solid #A9BDBD 1px; background-color: #8f99fb;" class="container-xxl navbar navbar-expand-lg fixed-top">
<div class="container-fluid">
<a class="navbar-brand" href="/index.html{{lang}}" id="logo">&nbsp;</a>
<style type="text/css">
  #logo {
     display: block;
     height: 37px;
	 width: 100px;
  {% if path|starts_with:"/orion/" %}
     background-image: url("/images/sunstar-orion-symbol-linear.png");
  {% else %}
     background-image: url("/images/sunstarlinear.png");
  {% endif %}
     background-size: 100% auto;
     background-repeat: no-repeat;
  }
</style>
  <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
  </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav">
          <li class="nav-item{% if path|starts_with:"/index.md" %}
            активный
            {% endif %}"><a class="nav-link text" href="/index.html{{lang}}">Главная</a></li>
          <li class="nav-item{% if path|starts_with:"/about.md" %}
            активный
            {% endif %}"><a class="nav-link text" href="/about.html{{lang}}">О нас</a></li>
			<li class="nav-item{% if path|starts_with:"/contact.md" %}
             активный
             {% endif %}"><a class="nav-link" href="/contact.html{{lang}}">Контакт</a></li>
          <li class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" id="products" data-bs-toggle="dropdown" role="button">Продукты... <span class="caret"></span></a>

<ul class="dropdown-menu me-auto mb-2 mb-lg-0 {% ifequal lang ".he" %}dropdown-menu-left right{% else %}{% ifequal lang ".ar" %}dropdown-menu-left right{% endifequal %}{% endifequal %}" role="menu"
			aria-labelledby="продукты">
              <li class="dropdown-item"><a class="nav-link text-dark" href="/orion/index.html{{ lang }}">Орион&trade; Платформа Jamstack Wiki</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark"
                href="/orion/plans.html{{ lang }}">Ценовые планы Orion</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" id="more" role="button" data-bs-toggle="dropdown">Больше... <span class="caret"></span></a>
            <ul class="dropdown-menu me-auto mb-2 mb-lg-0 {% ifequal lang ".he" %}dropdown-menu-left right{% else %}{% ifequal lang ".ar" %}dropdown-menu-left right{% endifequal %}{% endifequal %}" role="menu"
			aria-labelledby="больше">
              <li class="dropdown-item">
                <a class="nav-link text-dark" href="https://github.com/SunStarSys/www">Источник отделения</a>
              </li>
              <li class="dropdown-item divider"></li>
              <li class="dropdown-header text-dark">i18n</li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.en">Британские единицы</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.es">Испанский</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.de">немецкий</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.fr">Французский</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.ru">Русский</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.zh-TW">Китайский</a></li>
            <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.ko">Корейский</a></li>
             <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.ja">Японский</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.he">Иврит</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.ar">Арабский</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.sv">шведский</a></li>
              <li class="dropdown-item"><a class="nav-link text-dark" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.pt-BR">Португальский</a></li>
              <li class="dropdown-item divider"></li>
            <li class="dropdown-header text-white">Взаимодействия</li>
            <li class="dropdown-item"><a class="nav-link text-white" href="/clients">Клиенты</a></li>
            <li class="dropdown-item"><a class="nav-link text-white" href="https://www.iconoclasts.blog/joe/">Эссе</a></li>
            </ul>
          </li>
          <li class="nav-item{% if path|starts_with:"/powered-by.md" %}
            активный
            {% endif %}"><a class="nav-link" href="/powered-by.html{{lang}}">Создано...</a>
          </li>
        </ul>
	</div>
    <form id="search" action="/dynamic/search{% ifequal path|dirname "/" %}{% else %}{{ path|dirname }}{% endifequal %}/" class="d-flex form-inline right text-light" method=>
      <input type="hidden" name="lang" value="{{ lang }}" />
      <input type="hidden" name="markdown_search" value="1" />
      <input class="form-control me-2" type="text" name="regex"
        placeholder="Рекурсивный поиск PCRE" значение="{{ regex }}" />&nbsp;<button type="submit" name="submit" value="1" class="btn btn-outline-danger"><i class="fa fa-search"></i></button>
	</form>
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

<style type="text/css">
{% ifequal lang ".he" %} .right {float:left !important; text-align: right !important}{% else %}{% ifequal lang ".ar" %}.right {float:left !important; text-align: right !important}{% else %}.right {text-align: left !important}{% endifequal %}{% endifequal %}
{% ifequal lang ".he" %} div.breadcrumbs {float:left}{% endifequal %}{% ifequal lang ".ar" %}div.breadcrumbs {float:left}{% endifequal %}
</style>

<div class="container theme-showcase{% ifequal lang ".he" %} rtl{% endifequal %}{% ifequal lang ".ar" %} rtl{% endifequal %}"  id="content">
  {% block content %}
  <div class="breadcrumbs">
      {{ breadcrumbs|safe }}&nbsp;&nbsp;<a href="javascript:void(location.href='https://cms.sunstarsys.com/redirect?uri='+escape(location.href))">
        <img src="/images/edit.png" alt="Edit Icon" />
      </a>
  </div>
  <h1>{{ headers.title|safe }}</h1>
  <div class="container jumbotron">{{ content|markdown }}</div>
  {% endblock %}

<footer>{% block footer %}{{footer|safe}}{% endblock footer %}</footer>

<!--  <script src="/editor.md/js/raphael.min.js"></script>
  <script src="/editor.md/js/underscore.min.js"></script>
  <script src="/editor.md/js/flowchart.min.js"></script>
  <script src="/editor.md/js/jquery.flowchart.min.js"></script> -->
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
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })

if (typeof(editormd) === "undefined") {

mermaid.initialize({theme: "dark", startOnLoad: true, securityLevel: "loose"});
        $(".sequence-diagram").sequenceDiagram();
        for (const e of $("body").find(".graphviz").toArray()) {
            d3.select(e).graphviz({useWorker: false}).renderDot($(e).text());
            e.innerHTML = ""
        }
        $("body").find("pre").parent().addClass("editormd-preview-theme-dark");
        CodeMirror.colorize();
        $("body").find("code").attr("class", "cm-s-pastel-on-dark");
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
