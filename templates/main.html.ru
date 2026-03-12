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
          <!-- Derived work from Dennis Moskowitz'оригинальное изображение википедии: CC-BySA v4.0 -->
	{% else %}
          <img src="/images/sunstarlinear.png" alt="SunStar Linear"/>
        {% endifequal %}
        </div>
      </div>

<div class="navbar-collapse collapse" id="navbarResponsive">
        <ul class="navbar-nav">
          <li class="nav-item{% ifequal path "/index.html"|append:lang %}
            активный
            {% endifequal %}"><a class="nav-link text" href="/">Главная</a></li>
          <li class="nav-item{% ifequal path "/about.html"|append:lang %}
            активный
            {% endifequal %}"><a class="nav-link text" href="/about">О нас</a></li>
          <li class="nav-item{% ifequal path "/contact.html"|append:lang %}
             активный
             {% endifequal %}"><a class="nav-link" href="/contact">Контакт</a></li>
          <li class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Продукты... <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li class="dropdown-item{% ifequal path "/orion/index.html"|append:lang %}
                активный
                {% endifequal %}"><a class="nav-link text-white" href="/orion/index.html{{ lang }}">Орион&trade; #Jamstack Вики-платформа</a></li>
              <li class="dropdown-item{% ifequal path "/orion/plans.html"|append:lang %}
                активный
                {% endifequal %}"><a class="nav-link text-white"
                href="/orion/plans.html{{ lang }}">Ценовые планы Orion</a></li>
            </ul>
          </li>
          <li class="nav-item{% ifequal path "/open-source.html"|append:lang %}
            активный
																{% endifequal %}"><a class="nav-link" href="/open-source">Открытый исходный код</a></li>

<li class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Подробнее... <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li class="dropdown-item">
                <a class="nav-link text-white" href="https://vcs.sunstarsys.com/repos/svn/public/cms-sites/www.sunstarsys.com/trunk/">Источник отделения</a>
              </li>
              <li class="dropdown-item divider"></li>
              <li class="dropdown-header text-white">i18n</li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.en">Британские единицы</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.es">Испанский</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.de">немецкий</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.fr">Французский</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.ru">Русский</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.zh-TW">Китайский</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.he">Иврит</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="{{path|dirname|append:"/"}}{{path|basename:0}}.html.sv">шведский</a></li>

<li class="dropdown-item divider"></li>
              <li class="dropdown-header text-white">Взаимодействия</li>
              <li class="dropdown-item"><a class="nav-link text-white" href="/clients">Клиенты</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="https://www.iconoclasts.blog/joe/">Эссе</a></li>
              <li class="dropdown-item divider"></li>
              <li class="dropdown-header text-white">Таксономии</li>
              <li class="dropdown-item"><a class="nav-link text-white" href="/categories">Категории</a></li>
              <li class="dropdown-item"><a class="nav-link text-white" href="/archives">Архивы</a></li>
            </ul>
          </li>

<li class="nav-item{% ifequal path "/powered-by.html"|append:lang %}
            активный
            {% endifequal %}"><a class="nav-link" href="/powered-by">При поддержке...</a>
          </li>
        </ul>
      </div>
      <div class="row right" id='search'>
        <form action="/dynamic/search{% ifequal path|dirname "/" %}{% else %}{{ path|dirname }}{% endifequal %}/" class="form-inline right" method="GET">
          <input type="hidden" name="lang" value="{{ lang }}" />
          <input class="form-control" type="text" name="regex"
               placeholder="ПОДРОБНЕЕ
 Рекурсивный поиск" значение="{{ regex }}" />&nbsp;<button type="submit" name="submit" value="1" class="btn btn-outline-danger">
	    Поиск
          </button>&nbsp;
          <input class="form-control form-check-input" type="checkbox" name="markdown_search"
          id="поиск разметки" значение="1" проверено /><label for="markdown-search"><small>Снижение цен</small></label>
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
    if (type(editormd) === "не определено") {
        
        mermaid.initialize({тема: "неотчетливый", startOnLoad: true, securityLevel: "широкий"});
        $(".sequence-диаграмма").sequenceDiagram();
        для (количество e $("тело").найти("Русский").toArray()) {
            d3.select(e).graphviz(){useWorker: ложь}).renderDot($(e).text());
            e.innerHTML = ""
        }
        $("тело").найти("до").parent().addClass("editormd-preview-тема-темный");
        CodeMirror.colorize();
    }
    если (document.cookie.indexOf("gdpr_analytics=1") == -1 &amp;&amp;
    document.cookie.indexOf("gdpr_decline=1") == -1) {
        для (содержит h1 из document.getElementsByTagName("h1")) {
            вар. html = `<div id="analytics"><br><div class="card border-warning">
<div class="card-header">
  <h3 class="card-title text-dark">Этот сайт использует файлы cookie для аналитики.</h4>
</div>
<div class="card-body">
<p class="card-text">
<small class="text-dark">Выберите предпочитаемый тип аналитики:</small><br>
  <button type="button" class="btn btn-outline-warning text-white" data-bs-dismiss="alert"
  onClick="document.cookie='gdpr_analytics=1; path=/; max-age=8640000';
  $('#analytics').css('показывать', 'нет'истина"«Я согласен.</button> &nbsp;
  <button type="button" class="btn btn-outline-danger text-dark" data-bs-dismiss="alert"
  onClick="document.cookie='gdpr_decline=1; path=/; max-age=864000';
  $('#analytics').css('показывать', 'нет'истина">I
  Отклонить.</button><br><small class="text-dark">Если вы решите
  Мы больше не будем просить о следующих 10 днях.</small>
</p>
</div>
</div>
</div>`;
            h1.insertAdjacentHTML('перед', html);
        }
    }
    else if (document.cookie.indexOf("gdpr_decline=1") == -1) {
        document.cookie = 'gdpr_analytics=1; path=/; max-age=8640000';
    }
  </script>

<script async type="module">
    если (document.cookie.indexOf("can_search") >= 0 &amp;&amp; Notification.permission !== "отрицательный") {
		vr разрешение = Notification.permission;
		if (разрешение !==) "предоставлено") {
            Notification.requestPermission().then(result) => {
              permission = результат;
            });
        }
        если (разрешение === "предоставлено") {
		   пересмотр;
           var m = document.cookie.match(/last=()[0-9]+)/);
           если (м)
			 revision = м[1];
           ответ const = ожидает извлечения("/dynamic/search/?regex=notify="+ревизия+";язык={{lang}};markdown_search=1;as_json=1",
                           {учетные данные: 'одноимённый'});
           попытка {
              const json = ожидает response.json();
              для (содержит e из json.log) {
                  вр. сообщение = e[3] + "\n";
                  для [ключ, вал] из Object.entries(e[1])) {
                      сообщение += val.action + " " + key.replace(/^.*\//, "") + "\n";
				  }
				  var n = новое уведомление (e)[2],
     			    {
					  body: сообщение,
					  tag: e[0],
					  icon: "/фавикон",
					  image: "/images/sunstarstaronly",
				    }
			  	  );
			      n.addEventListener("щелкнуть", () => {window.open("https://{{website}}/dynamic/search/?regex=diff="+e[0]+";язык={{lang}};markdown_search=1") }, { захват: true });
			  }
		   }
           поймать (e) {
             // оповещение(e);
		   }
        }
	}
  </script>
  {% block javascript %}{% endblock %}
</div>
</body>
</html>
