<h3>Consultas de ventas de Orion</h3>
<br>
<form action="/dynamic/enquiry" class="form" method="POST">

<label for="name">Su nombre</label>
  <input class="form-control" id="name" name="name" required />

<label for="email">Su dirección de correo electrónico</label>
  <input class="form-control" id="email" name="email" required type="email" />

<label for="username">Nombre de usuario preferido</label>
  <input class="form-control" id="username" name="username" pattern="^\w+$" required />
>
  <label for="site">Sitio web de destino</label>
  <input class="form-control" id="site" name="site" type="url" />

<input checked id="confluence" name="confluence" type="checkbox" /> &nbsp; <label for="confluence">¿Se requiere migración de confluencia?</label>

<label>Plan de Orión preferido</label>
  <input id="planFB" name="plan" type="radio" value="Free Blog" /> &nbsp; <label for="planFB">Blog gratuito</label>
  <input checked id="planPP" name="plan" type="radio" value="Professional" /> &nbsp; <label for="planPP">Plan profesional</label>
  <input id="planBP" name="plan" type="radio" value="Business" /> &nbsp; <label for="planBP">Plan de negocio</label>
  <input id="planEP" name="plan" type="radio" value="Enterprise" /> &nbsp; <label for="planEP">Plan empresarial</label>
  <input id="planSI" name="plan" type="radio" value="Server" /> &nbsp; <label for="planSI">Instalación del servidor Orion</label>

<label for="subject">Asunto</label>
  <input class="form-control" id="subject" name="subject" pattern="Orion.*" required value="Orion " />

<input name="lang" type="hidden" value="{{ lang }}" />
  <button class="btn btn-outline-success-emphasis" name="submit" value="1">Enviar</button>

<br><br>

<label for="editor">Mensaje para ventas</label>

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
	  height: "400px",
	  name: "content",
          mode: "gfm+django+stex",
          path : "/editor.md/lib/",
	  theme : "solarized",
	  previewTheme : "solarized",
	  editorTheme : "solarized",
          emoji: true,
 	  tocm : true,                  // Using [TOCM]
          tex : true,                   // 开启科学公式TeX语言支持，默认关闭
	  flowChart : true,             // 开启流程图支持，默认关闭
          sequenceDiagram: true,
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
      setTimeout(()=>{$(window).scrollTop(0)}, 500);
  });
  document.cookie = "nonce={{nonce}} path=/;";
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
