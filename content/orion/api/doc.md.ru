---
categories: ~
dependencies: '*.md.ru'
keywords: разметка,csv,yaml
status: проверено=44038
title: Orion API – формат текстового документа
---

## Формат текстового документа (`markdown`, `YAML`, `CSV`)

{# lede #}На этой странице содержатся документы полей заголовка и результирующих артефактов данных{# lede #} произведенный [Создание API](build) при обработке таких текстовых файлов (как вложений страницы) через [`single_narrative`](build#-code-single_narrative-args-code-) просмотр.

[TOC]

-----

### `Markdown`

#### Заголовки

<div class="card border-primary mb-3">
  <div class="card-header">

##### `title`

</div>
  <div class="card-body">
    <div class="card-title">

Обязательное название документа.

</div>

<p class="card-text">

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `status`

</div>
  <div class="card-body">
    <div class="card-title">

Обязательный статус документа произвольного текста.

</div>

<p class="card-text">

Three such special status labels are explained below:

###### черновик

Состояние по умолчанию.

-----

###### подтверждено

Указывает, что контент проверен автором.  Будет выполнен откат до состояния «Черновик», если документ впоследствии будет изменен без повторной проверки.

-----

###### архивированный

Указывает, что документ завершен и игнорируется для будущей работы в `Orion CMS`. Не будет отображаться в списках будущих каталогов за пределами его архивного местоположения.  Местоположение архива будет отслеживать будущие изменения контента.

</p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `acl`

</div>
  <div class="card-body">
    <div class="card-title">

Дополнительной `SVN` средства контроля прав доступа к этому документу. С поддержкой автозавершения и проверкой группы в `Orion CMS` редактор.

</div>
<p class="card-text"></p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `dependencies`

</div>
  <div class="card-body">
    <div class="card-title">

Необязательный список разделенных запятыми `file globs` на что опирается созданный документ.

</div>
<p class="card-text"></p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `keywords`

</div>
  <div class="card-body">
    <div class="card-title">

Дополнительной `SEO`-дружественный список тегов с возможностью поиска через запятую.

</div>
<p class="card-text"></p>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `categories`

</div>
  <div class="card-body">
    <div class="card-title">

Необязательный список категорий классификации, разделенных запятыми, которые должны ссылаться на этот документ с постоянной связью.

</div>
<p class="card-text">

Добавка по своей природе (удаление категорий не приведет к исключению из списка этих бывших категорий).

</p>
</div>
</div>

#### Артефакты данных

н/д

#### :editormd-logo: Расширения GFM

<div class="card border-primary mb-3">
  <div class="card-header">

##### `[TOC]#sidebar`

</div>
  <div class="card-body">
    <div class="card-title">

Автоматическая таблица контекстов (необязательно) `id=sidebar` на корпусе `<div>`.
</div>
</div>
  <div class="card-body">
    <div class="card-title">

`#sidebar` обеспечивает динамическое поведение в левой боковой панели для экранов с шириной более 1900 пикселей.

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `[^name] Footnotes`

</div>
  <div class="card-body">
    <div class="card-title">

Автоматические сноски.

</div>
</div>
  <div class="card-body">
    <div class="card-title">

Двунаправленные связи между ссылочными сносками и их описаниями.

</div>
</div>
</div>
<div class="card border-primary mb-3">
  <div class="card-header">

##### `fenced block extensions`

</div>
  <div class="card-body">
    <div class="card-title">

`mermaid`

</div>

Схемы разметки @mermaidjs/русалки.

<div class="card-title">

`asy`

</div>

Асимптотная векторная графика `iframe` рендерер.

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### [`snippet`&#58;...]

</div>
  <div class="card-body">
    <div class="card-title">

Загружайте и внедряйте фрагменты кода из общедоступных репозиториев git, таких как GitHub.

</div>
</div>
</div>

-----

### `YAML`

#### Заголовки

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `title`

</div>
  <div class="card-body">
    <div class="card-title">

См. раздел «Уценка» выше.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `status`

</div>
  <div class="card-body">
    <div class="card-title">

См. раздел «Уценка» выше.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `acl`

</div>
  <div class="card-body">
    <div class="card-title">

См. раздел «Уценка» выше.

</div>
</div>
</div>

#### Артефакты данных

<div class="card border-primary mb-3">
  <div class="card-header">

##### `content`

</div>
  <div class="card-body">
    <div class="card-title">

`YAML::XS::Load` синтаксический анализ структуры данных

</div>
</div>
</div>

-----

### `CSV`

#### Заголовки

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `title`

</div>
  <div class="card-body">
    <div class="card-title">

См. раздел «Уценка» выше.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `status`

</div>
  <div class="card-body">
    <div class="card-title">

См. раздел «Уценка» выше.

</div>
</div>
</div>

<div class="card border-secondary mb-3">
  <div class="card-header">

##### `acl`

</div>
  <div class="card-body">
    <div class="card-title">

См. раздел «Уценка» выше.

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `headers`

</div>
  <div class="card-body">
    <div class="card-title">

Необязательно; истинное значение указывает, что этот документ имеет `CSV` строка заголовка в верхней части ее содержимого.

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `column_ids`

</div>
  <div class="card-body">
    <div class="card-title">

Необязательный список идентификаторов столбцов, разделенных запятыми `PDL`

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `datetime`

</div>
  <div class="card-body">
    <div class="card-title">

Дополнительной [`strptime(3)`](https://www.man7.org/linux/man-pages/man3/strptime.3.html) формат для `PDL` переработка

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `type`

</div>
  <div class="card-body">
    <div class="card-title">

Необязательно объявлено `PDL` типы данных столбцов

</div>
</div>
</div>

#### Артефакты данных

<div class="card border-primary mb-3">
  <div class="card-header">

##### `content`

</div>
  <div class="card-body">
    <div class="card-title">

`arrayref` любой из `arrayrefs` (нет) `csv` заголовков), или `hashrefs` (`csv` заголовки)

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `csv`

</div>
  <div class="card-body">
    <div class="card-title">

[`Text::CSV` ](https://metacpan.org/pod/Text::CSV) объект, используемый для производства выше

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `csv_headers`

</div>
  <div class="card-body">
    <div class="card-title">

`arrayref` оригинальных (без боеприпасов) заголовков

</div>
</div>
</div>

<div class="card border-primary mb-3">
  <div class="card-header">

##### `pdl`

</div>
  <div class="card-body">
    <div class="card-title">

Полный [`PDL`](https://metacpan.org/pod/PDL) объект, созданный конфигурацией заголовка

</div>
</div>
</div>

<!-- $Date$ $Author$ $Revision$ -->
