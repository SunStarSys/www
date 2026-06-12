---
categories: ~
dependencies: '*.md.ru'
keywords: REST,API,Джанго
status: проверено=42929
title: Orion API – библиотека шаблонов Django
---

<div class="right">

![SunStar Системы](../../images/sunstarstaronly)

</div>

{# lede #}В этом документе рассматриваются теги **Django Template Library (DTL)**, подключаемые модули и API фильтров{# lede #}.

[TOC]#sidebar

## Django 1.0 Теги

-----

### `autoescape`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/autoescape.pm:token==head1,=cut:lang=perl]

-----

### `block`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/block.pm:token==head1,=cut:lang=perl]

-----

### `comment`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/comment.pm:token==head1,=cut:lang=perl]

-----

### `debug`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/debug.pm:token==head1,=cut:lang=perl]

-----

### `extends`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/extends.pm:token==head1,=cut:lang=perl]

-----

### `filter`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/filter.pm:token==head1,=cut:lang=perl]

-----

### `firstof`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/firstof.pm:token==head1,=cut:lang=perl]

-----

### `for`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/for.pm:token==head1,=cut:lang=perl]

-----

### `ifchanged`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/ifchanged.pm:token==head1,=cut:lang=perl]

-----

### `ifequal`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/ifequal.pm:token==head1,=cut:lang=perl]

-----

### `ifnotequal`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/ifnotequal.pm:token==head1,=cut:lang=perl]

-----

### `if`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/if.pm:token==head1,=cut:lang=perl]

-----

### `include`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/include.pm:token==head1,=cut:lang=perl]

-----

### `load`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/load.pm:token==head1,=cut:lang=perl]

-----

### `now`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/now.pm:token==head1,=cut:lang=perl]

-----

### `regroup`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/regroup.pm:token==head1,=cut:lang=perl]

-----

### `spaceless`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/spaceless.pm:token==head1,=cut:lang=perl]

-----

### `ssi`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/ssi.pm:token==head1,=cut:lang=perl]

-----

### `templatetag`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/templatetag.pm:token==head1,=cut:lang=perl]

-----

### `url`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/url.pm:token==head1,=cut:lang=perl]

-----

### `widthratio`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Tag/widthratio.pm:token==head1,=cut:lang=perl]

-----

## Загруженные подключаемые модули Django

### `markup`
[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Addon/markup.pm:token==head1,=cut:lang=perl]

-----

### `json`

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Addon/json.pm:token==head1,=cut:lang=perl]

-----

## API фильтра Django 1.0

[snippet:repo=SunStarsys/orion:path=lib/Dotiac/DTL/Filter.pm:token==head1,=cut:lang=perl]

-----

## Добавление API фильтра Orion

#### `append`

Принимает один аргумент и добавляет его значение к отфильтрованным входным данным.  Аргументом может быть имя переменной или строка в кавычках; этот фильтр будет умным `/` Персонажи объединяются в `append`.

-----

#### `cuts`

Подобно `cut`, но аргумент принимается в качестве *подстроки* для элиды, вместо списка символов.

-----

#### `lede`

Извлекает текст между &#123;# `lede` #&#125; блоки в отфильтрованной строке ввода.

-----

#### `ssi`

Рекурсивная оценка всех Django `ssi` теги в отфильтрованной строке ввода.

-----

#### `starts_with`

Тесты на соответствие префиксу.

-----

#### `dirname`

Возвращает традиционный `UNIX dirname` пути в отфильтрованной строке ввода.

-----

#### `parse_filename`

Интерфейс для [`SunStarSys::Util::parse_filename`](build#-code-parse_filename-path-code-). Ключевое различие заключается в том, что первые два возвращаемых значения этой подпрограммы заменяются, и все расширения пути разбиты (с `.` префикс) в отдельные аргументы, позволяющий этому фильтру принимать строку аргумента, представляющую список индексов в результирующий массив. В качестве особого случая аргумент заканчивается `..` будет соединять *all* проанализированные расширения до конца результирующей строки.

-----

#### `basename`

Возвращает традиционный `UNIX basename` пути в отфильтрованной строке ввода. Передача аргумента `0` к этому фильтру приведет к удалению всех расширений файлов из результирующей строки.

-----

#### `tex2md`

Преобразования $$\LaTeX$$ Источники в Markdown+$$\KaTeX$$ источники. Экспериментальный.

-----

#### `md2tex`

Обратное преобразование качества продукции `tex2md`.

-----

#### `vcs_date`

Принимает a `lang` аргумент для предоставления локального представления дня, месяца и года последнего изменения, представленного `$Date` Ключевое слово Subversion в отфильтрованной строке ввода (которое обычно является полным) `content` текущего ресурса).

-----

#### `vcs_time`

Представляет числовое смещение часов, минут, секунд и часового пояса последнего изменения, представленного `$Date` Ключевое слово Subversion в отфильтрованной строке ввода.

-----

#### `vcs_author`

Представляет a `safe` `HTML` представление пользователя, обновившего контент в последнее время, согласно ключевому слову Subversion `$Author` ключевое слово в отфильтрованной строке ввода.  Принимает необязательный `lang` аргумент для представления для конкретной локали.

-----

#### `vcs_revision`

Представляет числовой номер версии последнего изменения контента, записанного `$Revision` ключевое слово в отфильтрованной строке ввода.

-----

#### `strip_prefix`

Удаляет префикс (путь), переданный в качестве аргумента этому фильтру, из отфильтрованной входной строки (пути). В качестве префикса по умолчанию принимается регулярное выражение `\S+/content/` иначе.

-----

#### `selectattr`

Поиск первого соответствующего атрибута тега html с переданным именем атрибута в качестве аргумента для этого фильтра.

-----

#### `shuffle`

Перемешайте массив.

-----

#### `split`

Разбивает входную строку на массив на основе шаблона, переданного в качестве аргумента.

-----

#### `img`

Захватите первое изображение HTML5/Markdown из отфильтрованного содержимого.

-----

#### `pdl_*`

Полный [`PDL`](https://metacpan.org/pod/PDL) API.  Передача этого фильтра в качестве аргумента массивная ссылка приведет к удалению массивной ссылки, чтобы ее элементы могли передаваться непосредственно в `pdl_` метод с префиксом, который вызывает этот фильтр.

-----

#### `grep`

Совпадает с привычной утилитой UNIX/Perl; в качестве аргумента передается регулярное выражение, при этом не`PCRE`-сопоставление источников.

-----

#### `fenced`

Извлечение массива из `GFM` огражденный код блокируется из источника; вы передаете ему имя / тип блоков кода, которые вы хотите.

<!-- $Date$ $Author$ $Revision$ -->
