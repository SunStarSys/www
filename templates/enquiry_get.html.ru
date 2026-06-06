<h3>Запросы по продажам Orion</h3>
<br>
<form method="POST" action="/dynamic/enquiry" class="form">

<label for="name">Ваше имя</label>
  <input name="name" id="name" class="form-control" required />

<label for="email">Ваш адрес электронной почты</label>
  <input type="email" name="email" id="email" class="form-control" required />

<label for="username">Имя предпочтительного пользователя</label>
  <input pattern="^\w+$" name="username" id="username" class="form-control" required />

<label for="site">Целевой веб-сайт</label>
  <input name="site" id="site" type="url" class="form-control" />

<input type="checkbox" id="confluence" name="confluence" checked /> &nbsp; <label for="confluence">Требуется миграция влияния?</label>

<label>Предпочтительный план ориентации</label>
  <input type="radio" id="planFB" name="plan" value="Free Blog" /> &nbsp; <label for="planFB">Бесплатный блог</label>
  <input type="radio" id="planPP" name="plan" value="Professional" checked /> &nbsp; <label for="planPP">Профессиональный план</label>
  <input type="radio" id="planBP" name="plan" value="Business" /> &nbsp; <label for="planBP">Бизнес-план</label>
  <input type="radio" id="planEP" name="plan" value="Enterprise" /> &nbsp; <label for="planEP">План предприятия</label>
  <input type="radio" id="planSI" name="plan" value="Server" /> &nbsp; <label for="planSI">Установка сервера Orion</label>

<label for="subject">Тема</label>
  <input name="subject" id="subject" class="form-control" value="Orion " pattern="Orion.*" required />

<input name="demo" id="demo" type="checkbox" /> &nbsp; <label for="demo">Запланировать демонстрацию</label>

<input type="hidden" name="lang" value="{{ lang }}" />

<input type="hidden" name="nonce" value="{{ nonce }}" />

<button name="submit" class="btn btn-outline-secondary" value=1 >Отправить</button>

<br><br>

<label for="editor">Сообщение для продаж</label>

<div id="editor-content">
    <textarea id="editor"></textarea>
  </div>
</form>

<link href="/editor.md/css/editormd.min.css" rel="stylesheet" media="screen">

<script src="/js/jquery.min.js"></script>
<script type="text/javascript">
var IN_GLOBAL_SCOPE=true;
</script>
<script type="module" src="/editor.md/editormd.js"></script>

<script type="text/javascript">
  var editor_content;
  var icon_class ={% ifequal path|dirname "/orion" %}"simple"{% else %}"mini"{% endifequal %};
  $(function() {
      editor_content = editormd("editor-content", {
          toolbarIcons: icon_class,
          watch: {% ifequal path|dirname "/orion" %}true,{% else %}false,{% endifequal %}
	  height: "400px",{% if path|starts_with:"/orion" %}{% else %}
      width: "400px",{% endif %}
      autoFocus: false,
      name: "content",
          mode: "gfm+django+stex",
          path : "/editor.md/lib/",
	  theme : "solarized",
	  previewTheme : "solarized",
	  editorTheme : "solarized",
          emoji: true,
 	  tocm : true,                  // Using [TOCM]
          tex : true,                   // 开启科学公式TeX语言支持，默认关闭
	  flowChart : false,             // 开启流程图支持，默认关闭
          sequenceDiagram: false,
          mermaid: true,
          graphviz: true,
	  htmlDecode : true,
	  taskList: true,
	  codeFold: true,
	  searchReplace: true,
	  onfullscreen     : function() {
              this.settings.toolbarIcons = "full";
              this.setToolbar();
	      this.editor.css({
		  "border-radius": 0,
		  "z-index": 120,
		  "margin-top": 60,
	      });
	  },
	  onfullscreenExit : function() {
              this.settings.toolbarIcons = icon_class;
              this.setToolbar();
	      this.editor.css({
		  zIndex : 10,
		  border : "none",
		  "border-radius" : 5,
		  "margin-top": 0,
	      });
	      this.resize();
	  }

}, editormd);
  });
  document.cookie = "nonce2={{nonce}} path=/;";
</script>
<script type="module" src="/editor.md/languages/{{ lang|cut:"." }}.js"></script>

<style type="text/css">
/*-------------------------------------------
	Animations
-------------------------------------------*/
@-webkit-keyframes FADEY {
  0%   { opacity: 0; }
  100% { opacity: 1; }
}

.theme-showcase {
	-webkit-animation-name: FADEY;
	-webkit-animation-duration: 1s;
	-webkit-animation-timing-function: ease-in-out;
	-webkit-animation-iteration-count: 1;
}

html { scroll-behavior: smooth; }
</style>
