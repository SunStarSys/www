{% extends "main.html"|append:lang %}
{% block content %}
<div class="page-header">
	<div class="breadcrumbs">{{ breadcrumbs|safe }}
		<a href="javascript:void(location.href='https://cms.sunstarsys.com/redirect?uri='+escape(location.href)+';action=edit')"><img src="/images/edit.png"></a>
	</div>
    <h1>{{ headers.title }}</h1>
</div>
<div class="jumbotron">
   {% filter markdown %}
   ### Empresas con las que hemos contratado con éxito en el pasado.
   {% endfilter %}
   {{ content|markdown }}
</div>

{% endblock %}
