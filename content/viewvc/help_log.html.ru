<! DOCTYPE html Публичный "-//W3C//DTD XHTML 1.0 Строгая//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>ViewVC Справка: представление журнала</title>
  <link rel="stylesheet" href="help.css" type="text/css" />
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
</head>
<body>
  <table>
    <col class="menu" />
    <col />
    <tr>
      <td colspan="2">
	<h1>ViewVC Справка: представление журнала</h1>
      </td>
    </tr>
    <tr><td>
       <h3>Справка</h3>
       <a href="help_rootview.html">Общие</a><br />
       <a href="help_dirview.html">Каталог&nbsp;Представление</a><br />
       <strong>Журнал&nbsp;Представление</strong><br />

<h3>Интернет</h3>
       <a href="http://viewvc.org/index.html">Главная</a><br />
       <a href="http://viewvc.org/upgrading.html">Обновление</a><br />
       <a href="http://viewvc.org/contributing.html">Вклад</a><br />
       <a href="http://viewvc.org/license-1.html">Лицензия</a><br />
    </td><td colspan="2">
    <p>
      В представлении журнала отображается история версий выбранного источника
      файл или каталог. Для каждой редакции следующая информация:
      displayed:

<ul>
        <li>Номер версии. В репозиториях Subversion это
            ссылка на <a href="help_rootview.html#view-rev">версия
            просмотр</a></li>
        <li>Для файлов, ссылки на
        <a href="help_rootview.html#view-markup">просмотр</a>,
        <a href="help_rootview.html#view-checkout">скачать</a>, и
        <a href="help_rootview.html#view-annotate">примечание</a> тот
          ревизия. Для каталогов ссылка на
        <a href="help_dirview.html">содержимое каталога списка</a></li>
        <li>Ссылка для выбора версии для различий (см. ниже)</li>
        <li>Дата и возраст изменения</li>
        <li>Автор модификации</li>
        <li>Отделение CVS (обычно) <em>ГЛАВНАЯ</em>, если не на ветке)</li>
        <li>Возможно, список тегов CVS, привязанных к ревизии (если таковые имеются)</li>
        <li>Размер изменения, измеренного в добавленных и удаленных строках
            код. (только CVS)</li>
        <li>Размер файла в байтах на момент пересмотра
            (Только версия)</li>
        <li>Ссылки для просмотра отличаются от предыдущей версии или, возможно, от
            произвольная выбранная редакция (если таковая имеется, см. выше)</li>
        <li>Если редакция является результатом копии, то путь и редакция
            скопировано из</li>
        <li>Если версия предшествует копированию или переименованию, путь к
            время пересмотра</li>
        <li>И последнее, но не менее важное, сообщение журнала фиксации, которое должно указывать
            о причинах изменения.</li>
      </ul>
    <p>
      В нижней части страницы вы найдете форму, которая позволяет
      запрашивать различия между произвольными изменениями.
    </p>
  </td></tr></table>
  </body>
</html>
