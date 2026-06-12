---
categories: ~
dependencies: '*.md.ru'
keywords: ОТДЫХ,АПИ
status: проверено=44187
title: API Orion – сборка
---

<div class="right">

![SunStar Системы](../../images/sunstarstaronly)

</div>
<ul class="nav nav-tabs" role="tablist">
  <li class="nav-item" role="presentation">
    <a class="nav-link" data-bs-toggle="tab" href="#stats" aria-selected="false" role="tab" tabindex="-1">Статистика</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link active" data-bs-toggle="tab" href="#docs" aria-selected="true" role="tab">Документация</a>
  </li>
</ul>
</div>
<div class="tab-content">
<div class="tab-pane fade active show" id="docs" role="tabpanel">

&nbsp;

[TOC]#sidebar

## Система сборки

{# lede #}Этот документ охватывает API **Build System**{# lede #}.

В основном, система сборки управляется двумя модулями Perl, поставляемыми пользователем: [`lib/path.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm) и [`lib/view.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/view.pm).

Первая задача состоит в том, чтобы сделать три вещи:

0. тяжесть [`lib/facts.yml`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/facts.yml) и [`lib/acl.yml`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/acl.yml),
1. изготавливать `@path::patterns`, и
2. условно ходить `content/` дерево для семян `%path::dependencies` и `@path::acls` из метаданных заголовка файла разметки/ямла.

Задача последнего состоит в том, чтобы обеспечить вызываемый `view`на основе `$method`s для соответствующих записей в `@path::patterns` (в качестве строкового имени метода во втором слоте каждой записи ссылки массива), вызываемого [создание сценариев]({{snippetA.pretty_uri}}):

[snippet:repo=SunStarSys/orion:path=build_site.pl:token=#api:lang=perl]

&nbsp;

Многие виды должны быть сложены как "фильтры" для предварительной обработки (или заключительной обработки) аспектов файла в `$path` Это новый, как внешний код. `snippets` или `asymptote`-огороженные блоки разметки. Вы можете увидеть пример этого [здесь](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm#L52).

&nbsp;

----

&nbsp;

### [`SunStarSys::View`](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm) &mdash; базовый класс для `lib/view.pm`

&nbsp;

<div class="card border-primary mb-3">
  <div class="card-header">

#### `single_narrative(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Самый популярный (и сложный) вид

</div>

<p class="card-text">

Это представление включает автоматическую обработку файлов, расположенных внутри `$path`каталог вложений. Другими словами, если `$path = "/foo.md.en"`, затем файлы, хранящиеся в  `/foo.page/` каталог, связанный с ".ru" расширение языка будет включено в шаблон адресных аргументов для этого `$path` независимо от `preprocess` параметр аргумента &mdash; который, если это правда, также сделает этот материал доступным по самому содержанию **страницы**.

Mandatory Arguments:

- `template`
- `path`
- `lang`

Optional Argmuents:

- `deps` &mdash; переопределяет обычный `fetch_deps` переработка

- `quick_deps` &mdash; внутренняя настройка оптимизации обработки депс; наилучшее левое неустановка

- `preprocess` &mdash; включает обработку шаблонов внутри `$path` самого контента,

- `archive_root` &mdash; файлы в "архивированный" статус: "скопировано" и отслеживаются по подпапкам года/месяца в этом расположении с корнем контента через `ssi`,

- `category_root` &mdash; элементы в "категории" заголовок является "скопировано" в соответствующие имена папок категорий в этом расположении с корнем содержимого через `ssi`.

</p>
  </div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `news_page(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Для (многоописательных) агрегированных страниц

</div>

<p class="card-text">

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `sitemap(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Для создания страниц index.html и sitemap.html

</div>

<p class="card-text">

Индекс зависимостей, зависящий от локали.

Mandatory Arguments:

- `path`
- `lang`

Optional Arguments:

- `quick_deps`
- `nested`
- `preprocess`

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `asymptote(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Сборки и кэширование [`Asymptote`](https://asymptote.sourceforge.io/) трехкодовые блоки для векторной графики с поддержкой HTML5-WebGL

</div>
<p class="card-text">

Mandatory Arguments:

- `view`
- `lang`
- `path`

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `skip(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Не стройте их вообще.

</div>
<p class="card-text">

Вместо этого создайте связанные сгенерированные исходные файлы (например, `.bib\$lang` $$\mapsto$$ `\$base.page/bibliography.yml\$lang`), который должен быть построен на вторичном запуске системы сборки.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `yml2ext(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Преобразование файлов YAML, как правило, в JSON.

</div>
<p class="card-text">

Optional Arguments:

- `ext` по умолчанию `json`
- `filter` по умолчанию `json_raw`
- `template` переопределения `filter` выражение по умолчанию

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `csv2ext(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Преобразование файлов CSV, как правило, в JSON.

</div>
<p class="card-text">

Optional Arguments:

- `ext` по умолчанию `json`
- `filter` по умолчанию `json_raw`
- `template` переопределения `filter` выражение по умолчанию

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

#### `fetch_deps($path, $data, $quick)`

</div>
  <div class="card-body">
    <div class="card-title">

Рефакторы `$data` hashref аргумента как упорядоченная по метке времени ссылка массива 2-элементных ссылок массива.

</div>
<p class="card-text">

Первая запись в каждой 2-элементной ссылке массива – это имя пути к файлу, второй элемент – результирующий `read_text_file` hashref для этого имени пути.

Возвращает список полученных новых исходных файлов, если `$quick > 2`.

Mandatory Arguments:

- `path`
- `data` - вход в виде хэшрефа; хранит результирующий массив значений по возврату
- `quick` - по умолчанию 2

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

#### `breadcrumbs($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Возвращает список навигационных цепочек HTML для `$path`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `memoize(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Кэширование сборки; в основном используется с `fetch_deps` и `quick_deps > 2`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `comment(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Создание `SSI`-включаемый `HTML5` фрагмент для комментария к странице.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

#### `next_view(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Утилита для последовательной обработки `$args{view}`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `ssi(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Рекурсивные оценки `ssi` теги.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `offline(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Выполняет `next_view` в автономном режиме.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `snippet(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

[Обработка внешнего кода](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Value/Snippet.pm#L12-L13) [линии фрагментов](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/View.pm#L806), обычно импортируя их исходные местоположения на GitHub в блоки разметки, зависящие от языка программирования. [Пример здесь](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/content/joe/perl7-sealed-lexicals.md.en#L135).

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `reconstruct(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Повторные обработки `Template` директивы в построенном контенте от `next_view`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `trim_local_links(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Удаляет расширения файлов из локальных ссылок.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `normalize_links(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Нормализует локальные ссылки (`./` и `../`).

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `langify_template(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Добавление `$args{lang}` по `$args{template}`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `titleize_links(%args)`

</div>
  <div class="card-body">
    <div class="card-title">

Добавляет строку заголовка для ссылок разметки. Обычно используется при `offline` просмотр, чтобы избежать получения заголовков с удаленных сайтов, что может значительно перетащить время сборки страницы.

</div>
<p class="card-text">
</p>
</div>
</div>

&nbsp;

----

### [`SunStarSys::Util`](https://github.com/SunStarSys/orion/blob/master/lib/SunStarSys/Util.pm) &mdash; библиотека служебных программ для `lib/path.pm` и `lib/view.pm`

&nbsp;

<div class="card border-primary mb-3">
  <div class="card-header">

#### `read_text_file($file, $out, $content_lines)`

</div>
  <div class="card-body">
    <div class="card-title">

Универсальный текстовый процессор Orion

</div>
<p class="card-text">

Синтаксический анализ headers+content файла в кодировке UTF-8 `$file` и хранит результаты в хэшрефе `$out`. `$content_lines` (необязательно) максимальное число строк контента для чтения.

Возвращает фактическое число прочитанных строк (включая заголовки).

`$file` может быть ссылкой на необработанную строку, представляющую полное содержимое файла.  Результаты в `$out` Все равно будет кодироваться UTF-8.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `copy_if_newer($src, $dest)`

</div>
  <div class="card-body">
    <div class="card-title">

Копии `$src` по `$dest` если отметка времени первого изменения является более новой, чем отметка последнего.

</div>
<p class="card-text">

При копировании дополнительно gzip-сжатие `$dest` файл, если это текстовый файл, и добавляет ".gz" Расширение имени.  `GZIP` сжатие можно отключить, установив `$ENV{NO_COPY_COMPRESS}=1`.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `get_lock($lockfile)`

</div>
  <div class="card-body">
    <div class="card-title">

Обеспечивает исключительную (f) блокировку (для текущего процесса UNIX) `$lockfile`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `shuffle(\@deck)`

</div>
  <div class="card-body">
    <div class="card-title">

На месте случайный (Рыбак-Йейтс) перетасовки `@deck`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `sort_tables($content)`

</div>
  <div class="card-body">
    <div class="card-title">

Сортировка таблиц снижения цен в `$content` согласно спецификации столбца каждой таблицы.

</div>
<p class="card-text">

Для каждой таблицы можно отсортировать только один столбец (необязательно) по числам `n`, по убыванию `v` или по возрастанию `^` заказ.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `fixup_code($prefix, $type, @_)`

</div>
  <div class="card-body">
    <div class="card-title">

Полосы `$prefix` из каждого спора в &#64;\_.

</div>
<p class="card-text">

Цель `$type` аргумент специфичен для реализации, но в основном используется для `editor.md "mode"` для обработки этого контента в &#64;_.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `unload_package($pkg)`

</div>
  <div class="card-body">
    <div class="card-title">

Агрессивные выгрузки `Perl` пакет (листьев) `$pkg` из таблицы символов (`STASH`).

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `purge_from_inc(@paths)`

</div>
  <div class="card-body">
    <div class="card-title">

Удаляет `@paths` из `@INC`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `touch(@_)`

</div>
  <div class="card-body">
    <div class="card-title">

Связывает все файлы в `@_`. Если аргументы не переданы, используется `$_`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `normalize_svn_path(@_)`

</div>
  <div class="card-body">
    <div class="card-title">

Нормализация всех путей в `@_` для безопасного использования в качестве необработанных аргументов `SVN::Client` Команды.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `sanitize_relative_path(@_)`

</div>
  <div class="card-body">
    <div class="card-title">

Защищает пути в `@_` для использования в качестве чистых относительных путей `Dotiac::DTL` Команды, относящиеся к пути (шаблон Django).

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `parse_filename($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Оболочка вокруг `File::Basename::fileparse`. Без аргументов, использует `$_` как имя файла для разбора.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `walk_content_tree($code)`

</div>
  <div class="card-body">
    <div class="card-title">

Условные прогулки `./content` древо системы сборки; сначала нормализация `$_` как формальный субпуть с корнем содержимого, а затем вызов `$code->()` на каждом предмете в лесу.

</div>
<p class="text-body">

Для большинства зданий прогулка никогда не бывает &mdash; вместо этого сборка опирается на кэшированные данные из предыдущих сборок.

Единственный способ заставить прогулку – это установить `$path::use_cache` для ложного значения в пользовательских модулях. В противном случае это поведение квалифицированно управляется [технология инкрементальной сборки](https://iconoclasts.blog/joe/dependencies).

Возвращает 1, если прогулка действительно продолжалась, вместо того, чтобы полагаться на кэшированные данные. В противном случае возвращается значение false.

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `archived($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Флаги каждый `Status: archived` `$path` (в зависимости от языка). Использование `$_` если не переданы аргументы.

</div>
<p class="card-text">

Архивирование файлов Markdown – это естественный способ рассказать Orion "перестать обращать внимание на постоянное расположение этого файла", если он не будет обновлен повторно, в этом случае местоположение архива будет обновлено. В частности, архивные файлы не появляются в списках каталогов в самой CMS Orion; вам нужно перейти к самой активной странице, чтобы снова редактировать ее в Интернете.

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `seed_file_deps($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Безопасные обновления `%path::dependencies` для этого `$path`, исходя из его `dependencies` верхний колонтитул `glob(s)`.

</div>
<p class="card-text">

По умолчанию используется `$_` как путь, если не пройдены аргументы.

</p>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `seed_file_acl($path)`

</div>
  <div class="card-body">
    <div class="card-title">

Безопасные обновления `@path::acl` для этого `$path`, исходя из его `acl` спецификация заголовка.

</div>
<p class="card-text">

По умолчанию используется `$_` как путь, если не пройдены аргументы.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `Load`

</div>
  <div class="card-body">
    <div class="card-title">

Совпадает с `YAML::XS::Load`.

</div>
<p class="card-text">
</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

#### `Dump`

</div>
  <div class="card-body">
    <div class="card-title">

Совпадает с `YAML::XS::Dump`.

</div>
<p class="card-text">
</p>
</div>
</div>
  </div>

<div class="tab-pane fade" id="stats" role="tabpanel">
    <script src="/editor.md/js/chart.umd.js"></script>
    <canvas id="myChart" width="100%" height="800px"></canvas>
</div>
</div>

<script async="" type="module">
  var ctx = document.getElementById("myChart").getContext("2d");
  const response = await fetch("/dynamic/search/?regex=build%3D;lang={{lang}};as_json=1;markdown_search=1");
  if (response.ok) {
    const json = await response.json();
	const data = json.duration;
    const values = data.map(x => x[1]);
    var total = 0;
    for (var i=0; i < values.length; ++i)
        total += +values[i];
    const labels = data.map(x => "r" + x[0] + ":" + x[2] + ":" + x[3] + ":" + x[4]);
    var myChart = new Chart(
      ctx,
      {
          type: "bar",
          data: {
              labels: labels.reverse(),
              datasets: [{
                  label: "Build Duration (s)",
                  data: values.reverse(),
                  backgroundColor: "#8f99fb",
              }],
          },
          options: {
              indexAxis: "y",
              plugins: {
                  title: {
                      display: true,
                      text: (total / 60).toFixed(0) + " build minutes this month (average build duration is " + (total / values.length).toFixed(0) + " s)",
                  }
              },
              onClick: (e, elts, chart) => {
                  if (elts) {
                      const idx = elts[0].index;
                      const revision = labels[idx].split(/:/)[0];
                      document.location = "/dynamic/search/?regex=build=" + revision + ";lang={{lang}};markdown_search=1";
                  }
              },
          },
      });
  }
</script>

<!-- $Date$ $Author$ $Revision$ -->
