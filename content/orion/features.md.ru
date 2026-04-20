---
categories: ~
dependencies: '*.md.ru api/index.md.ru'
keywords: jamstack,markdown,ermaid,graphviz,editor.md,ide,node.js,oracle,cloud,cdn,http/2,confluence,slab,notation
status: черновик
title: Особенности Orion
---

<div class="row">
	<div class="col-lg-3">
		<div class="embed-responsive embed-responsive-16by9">
		<iframe loading="lazy" class="embed-responsive-item" src="https://www.youtube.com/embed/xr67QX6aMqU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
	</div>
	<div class="col-lg-3">
		<div class="embed-responsive embed-responsive-16by9">
	 		<iframe loading="lazy" class="embed-responsive-item" style="margin-bottom:20px;max-width:560;max-height:315" src="https://www.youtube.com/embed/uhKLwl3HgMI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
	</div>
	<div class="col-lg-3">
		<div class="embed-responsive embed-responsive-16by9">
	 		<iframe loading="lazy" class="embed-responsive-item" style="margin-bottom:20px;max-width:560;max-height:315" src="https://www.youtube.com/embed/aNwnmwIngrM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
	</div>
	<div class="col-lg-3">
		<div class="embed-responsive embed-responsive-16by9">
	 		<iframe loading="lazy" class="embed-responsive-item" style="margin-bottom:20px;max-width:560;max-height:315" src="https://www.youtube.com/embed/gf19vVF-G9E" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
	</div>
</div>
<p>
&nbsp;
</p>

## Быстрая инфраструктура системы

- 50 мс или менее задержки RTT для большинства населения мира, с расширенным охватом в Африке / на Ближнем Востоке в 2026 году

- в 2 раза быстрее HTTP/2 мультиплексированные сроки доставки страниц (из коробки, для *всех* клиентов), чем у конкурентов

<div class="embed-responsive embed-responsive-16by9">
	 		<iframe loading="lazy" class="embed-responsive-item" style="margin-bottom:20px;max-width:560;max-height:315" src="https://www.youtube.com/embed/z8QveI4CHT8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

- 300 МБ/с для многогигабайтных исходных деревьев

- NVMe или более быстрое создание инфраструктуры хранения данных

- Solaris 11.4 для обеспечения стабильности ZFS при поддержке полной поддержки клиентов Oracle

- node.js для рендеринга разметки с кластеризацией ЦП

- 8-64 параллельные сборки

- Быстрое резервирование теперь задается по умолчанию для большинства обстоятельств

- IDE на основе Apache httpd 2.4:

- HTTP/2

- событие mpm

- mod_perl с ithreads

- mod_apreq2

- TLS 1.3

- Пользовательский [`СВН::Клиент`](#) модуль с поддержкой ithread для пулов по запросам

## Многоязычный

- английский

- Испанский

- немецкий

- французский

- Бразильский португальский

- Русский

- Китайский

- Корейский

- японский

- арабский

- Иврит

- шведский

## Улучшенная поддержка рассылок и создания клонов

- Защита от DMARC

- Использует SRS и Reply-To для совместимости с ezmlm

- Все пользователи проходят аутентификацию через сервис OpenID-Connect

## Любопытный утенок теперь элегантный лебедь

<br>

<div class="col-lg-3">
	<div class="embed-responsive embed-responsive-16by9">
	<iframe loading="lazy" class="embed-responsive-item" src="https://www.youtube.com/embed/JNWybe63G3s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	</div>
</div>

<br>

- Bootstrap 4+ для легкого семантического стиля CSS и быстрой адаптации.

- Editor.md удивительно: используя относительный [`источник`](#) URL-адреса, связанные изображения будут отображаться на панели предварительного просмотра редактора.

## Согласованная рендеринг GitHub-Flavored Markdown (GFM) с Editor.md :editormd-logo-1x: и Django Templating

- [x x] **ВЫСИВЫГ:** {# lede #}Один и тот же механизм рендеринга кода Java в браузере и в сценарии сборки markdown.js (на основе node.js){# lede #} обеспечивает 100% структурную согласованность между окном предварительного просмотра Markdown Editor.md и производственной площадкой.
- [x x] Теперь полностью поддерживаются заголовки YAML в исходных файлах (разметках).

- [x x] Собственная поддержка d3-graphviz.js:

```graphviz
digraph {
a -> b;
a -> c [color=red];
}
```
&nbsp;
----
&nbsp;

- [x x] Родной @mermaid-js/mermaid v10.7.0 с поддержкой карты ума:

```mermaid
graph TD
    A[Рождество]
 -->|Получить деньги| B(Покупки)
    B --> C{Позвольте мне подумать}
    C -->|Один| D[fa:fa-laptop Ноутбук]
    C -->|Два| E[fa:fa-mobile iPhone]
    C -->|Три| F[fa:fa-car Автомобиль]
```
----
```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Алиса->>Джон: Здравствуйте, Джон, как вы?
    loop Healthcheck
        Джон->>Джон: Борьба с ипохондрией
    end
    Note right of John: Рациональные мысли<br/>преобладать...
    John-->>Алиса: Отлично!
    Джон->>Боб: А как насчет тебя?
    Bob-->>Джон: Jolly Good!
```
----
```mermaid
erDiagram
    CUSTOMER }|..|{ DELIVERY-ADDRESS : has
    CUSTOMER ||--o{ ORDER : places
    CUSTOMER ||--o{ INVOICE : "liable for"
    DELIVERY-ADDRESS ||--o{ ORDER : receives
    INVOICE ||--|{ ORDER : covers
    ORDER ||--|{ ORDER-ITEM : includes
    PRODUCT-CATEGORY ||--|{ PRODUCT : contains
    PRODUCT ||--o{ ORDER-ITEM : "ordered in"
```
----
```mermaid
stateDiagram-v2
    [*] --> Осталось
    Всё --> [*]
    Всё --> Перемещение
    Перемещение --> Всё
    Перемещение --> Падение
    Падение --> [*]
```
----
```mermaid
gantt
    title A Gantt Diagram
    dateFormat  YYYY-MM-DD
    section Section
    Задача        :a1, 2014-01-01, 30d
    Другая задача     :after a1  , 20d
    section Another
    Задача с      :2014-01-12  , 12d
    другая задача      : 24d
```
----
```mermaid
pie title Commits to orion on GitHub
	"Воскресенье" : 4
	"Понедельник" : 5
	"вторник" : 7
  "Среда" : 3
```
----
```mermaid
classDiagram
    Animal <|-- Duck
    Animal <|-- Fish
    Animal <|-- Zebra
    Animal : +int age
    Animal : +String gender
    Animal: +isMammal()
    Animal: +mate()
    class Duck{
      +String beakColor
      +swim()
      +quack()
    }
    class Fish{
      -int sizeInFeet
      -canEat()
    }
    class Zebra{
      +bool is_wild
      +run()
    }
```
----
```mermaid
gitGraph
    commit
    commit
    branch develop
    checkout develop
    commit
    commit
    checkout main
    merge develop
    commit
    commit
```
----
```mermaid
%%{init:{"theme":"default"}}%%
graph TB
    sq[Квадратная форма] --> ci((Форма круга))

subgraph A
        od>Нечетная форма]-- Две линии<br/>комментарий к границе --> рожать
        di{Ромб с <br/> грейдер} -.-> ro(Округление<br>квадратный<br>форма)
        di==>ro2(Rounded квадратная форма)
    end

%% Notice that no text in shape are added here instead that is appended further down
    e --> od3>Действительно длинный текст с разрывом строки<br>в нечетной форме]

%% Comments after double percent signs
    e((Внутренний / круг<br>и некоторые странные <br>специальные символы)) --> f(,.?!+-*ز)

cyr[кириллица]-->cyr2((Начало формы круга));

classDef green fill:#9f6,stroke:#333,stroke-width:2px;
     classDef orange fill:#f96,stroke:#333,stroke-width:4px;
     class sq,e green
     class di orange
```
----
```mermaid
mindmap
  root((ментальная карта))
    Происхождение
      Длинная история
      ::icon(fa fa-book)
      Популяризация
        Британский автор психологии Тони Бузан
    Исследования
      По эффективности<br/>и особенности
      При автоматическом создании
        Использование
            Творческие методы
            Стратегическое планирование
            Отображение аргумента
    Инструменты
      Ручка и бумага
      Русалка
```
----
```mermaid
journey
    title Мой рабочий день
    section Перейти к работе
      Чай: 5: Я
      Наверх: 3: Я
      1: Я, кошка
    section На главную
      Спуск по лестнице: 5: Я
      Сядьте: 3: Я
```
----
```mermaid
flowchart TB
classDef borderless stroke-width:0px
classDef darkBlue fill:#00008B, color:#fff
classDef brightBlue fill:#6082B6, color:#fff
classDef gray fill:#62524F, color:#fff
classDef gray2 fill:#4F625B, color:#fff

subgraph publicUser[ ]
    A1[[Общий пользователь<br/> Через REST API]]
    B1[Бэкенд-сервисы/<br/>фронт-сервисы]
end
class publicUser,A1 gray

subgraph authorizedUser[ ]
    A2[[Авторизованный пользователь<br/> Через REST API]]
    B2[Бэкенд-сервисы/<br/>фронт-сервисы]
end
class authorizedUser,A2 darkBlue

subgraph booksSystem[ ]
    A3[[Книжная система]]
    B3[Позволяет взаимодействовать с записями книг]
end
class booksSystem,A3 brightBlue

publicUser--Чтение записей с помощью-->booksSystem
authorizedUser--Чтение и запись записей с использованием-->booksSystem

subgraph authorizationSystem[ ]
    A4[[Система авторизации]]
    B4[Авторизация доступа к ресурсам]
end

subgraph publisher1System[ ]
    A5[[Система издателя 1]]
    B5[Сведения о книгах, опубликованных ими]
end
subgraph publisher2System[ ]
    A6[[Система издателя 2]]
    B6[Сведения о книгах, опубликованных ими]
end
class authorizationSystem,A4,publisher1System,A5,publisher2System,A6 gray2

booksSystem--Доступ к сведениям об авторизации с помощью-->authorizationSystem
booksSystem--Доступ к сведениям об издателе с использованием-->publisher1System
booksSystem--Доступ к сведениям об издателе с использованием-->publisher2System

class A1,A2,A3,A4,A5,A6,B1,B2,B3,B4,B5,B6 borderless

click A3 "https://github.com/csymapp/mermaid-c4-model/blob/master/containerDiagram.md" "booksSystem"
```

&nbsp;
----
&nbsp;

- [x x] Markmap.js Посмотреть поддержку

- [x x] Дон Кнутс [$$\TeX$$](https://www.iconoclasts.blog/joe/triple-products.pdf) / Академия Кан [$$\KaTeX$$](https://en.wikipedia.org/wiki/KaTeX) поддержка математики, физики и химии:

```math
\ce{ Zn^2+ <=>[\ce{+ 2OH-}][\ce{+ 2H+}]$\underset{\text{amphoteric hydroxide}}{\ce{Zn(OH)2 v}}$<=>C[+2OH-][{+ 2H+}]$\underset{\text{tetrahydroxozincate}}{\ce{[Zn(OH)4]^2-}}$ }
```

- [x x] Синхронное, двунаправленное создание $$\LaTeX$$ Исходные файлы в Markdown+$$\KaTeX$$ Файлы.

- [x x] Навье-Стокс в системе обозначений Эйнштейна [БОЛЬ](https://en.wikipedia.org/wiki/Abstract_index_notation))

```math
\begin{aligned}
\pdv{\rho}{t}+\pdv{(\rho u_i)}{x_i} &= 0 \\
      \pdv{(\rho u_i)}{t}+\pdv{(\rho u_i u_j)}{x_j} &= -\pdv{p}{x_i}+\pdv{\tau_{ij}}{x_j}+\rho f_i \\
      \pdv{(\rho e)}{t}+\pdv{(\rho e+p)u_i}{x_i} &= \pdv{(\tau_{ij} u_j)}{x_i}+\rho f_i u_i+\pdv{(\dot{q}_i)}{x_i}+r \\
\end{aligned}
```

- [x x] Навье-Стокс в классической нотации

```math
\begin{aligned}
\pdv{\rho}{t}+\vec{\nabla}\cdot(\rho\vec{u}) &= 0 \\
      \pdv{(\rho \vec{u})}{t}+\vec{\nabla}\cdot\rho\vec{u}\otimes\vec{u} &= -\vec{\nabla p}+\vec{\nabla}\cdot\bar{\bar{\tau}}+\rho\vec{f} \\
      \pdv{(\rho e)}{t}+\vec{\nabla}\cdot(\rho e+p)\vec{u} &= \vec{\nabla}\cdot(\bar{\bar{\tau}}\cdot\vec{u})+\rho\vec{f}\cdot\vec{u}+\vec{\nabla}\cdot\vec{\dot{q}}+r
\end{aligned}
```

----

- [x x] Электрический!

Редактор будет автодополнять и автоотступать; имеет полноэкранный режим, а также поддержку нескольких других режимов создания контента, доступных для его подсветки синтаксиса CodeMirror 5.

## Полная поддержка построения филиалов

- [x x] Больше нет промежуточного хранения/публикации: заменено ветвью по ресурсам <span class="text-white">Промоакция</span>.
- [x x] <span class="text-white">Откат</span> и <span class="text-white">Синхронизация</span> Объединение полностью поддерживается.

## Поисковая система Live Source Tree

<br>

<div class="row">
	<div class="col-lg-3">
		<div class="embed-responsive embed-responsive-16by9">
		<iframe loading="lazy" class="embed-responsive-item" src="https://www.youtube.com/embed/dftUs2Oqy-Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
	</div>
	<div class="col-lg-3">
		<div class="embed-responsive embed-responsive-16by9">
		<iframe loading="lazy" class="embed-responsive-item" src="https://www.youtube.com/embed/TvgKXkoVsAU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
	</div>
</div>

<br>

- [x x] На основе совместимого регулярного выражения Perl (PCRE).
- [x x] Глобальная функция поиска и замены (уникальная поддержка PCRE); поддерживает захват регулярных выражений.
- [ ] PDF поиск скоро.
- [ ] Скоро появится поддержка GraphQL/AI. Безопасность выглядит весело!

## Неограниченное количество вложений страницы с произвольными MIME-типами

## Безопасные, многопоточные комментарии на каждой странице

## Автоматизированные переводы разметки на естественном языке

## Интерактивная математическая векторная графика с @vectorgraphics/asymptote

- [x x] Подсветка синтаксиса для асимптота
- [x x] CMS быстро выйдет из строя на непередаваемых блоках кода Asymptote
- [x x] WebGL включен, многопоточный вывод HTML

```asy
// tubular trefoil knot -*- asy -*-

import tube;
import graph3;
import palette;

size(0, 8cm);
currentlight=White;
real redPortion = 143 / 256;
real greenPortion = 153 / 256;
real bluePortion = 251 / 156;
pen periwinklePen =  redPortion *red + greenPortion* green + bluePortion *blue;
currentlight.background = periwinklePen;
currentprojection=perspective(1,1,1,up=-Y);

int e=1;
real x(real t) {return cos(t)+2*cos(2t);}
real y(real t) {return sin(t)-2*sin(2t);}
real z(real t) {return 2*e*sin(3t);}

path3 p=scale3(2)*graph(x,y,z,0,2pi,50,operator ..)&cycle;

pen[] pens=Gradient(6,red,blue,purple);
pens.push(yellow);
for (int i=pens.length-2; i >= 0 ; --i)
  pens.push(pens[i]);

path sec=scale(0.25)*texpath("$\pi$")[0];

coloredpath colorsec=coloredpath(sec, pens,colortype=coloredNodes);

draw(tube(p,colorsec),render(merge=true));
```

&nbsp;

----

&nbsp;

## Дельты из <span class='text-info'>CMS Apache</span> Возможности

- Доступна только система сборки на базе Perl.

- Новый редактор Markdown [`пометка/gfm`](#) На основе, поэтому парсер более современный.  Последний релиз поддерживает slug Спецификация a'la оригинальный питон на основе анализатора.

- GFM использует другой разделитель для блоков кода.

- [`extpaths.txt`](#) больше не поддерживается: отдельным лицам из каждого проекта будет предоставлен доступ для записи к дереву производственного веб-сайта в наших репозиториях для загрузки материалов, созданных извне (javadocs, артефакты выпуска программного обеспечения и т.д.)

----

## Индекс

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

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
	-webkit-animation-duration: 2s;
	-webkit-animation-timing-function: ease-in-out;
	-webkit-animation-iteration-count: 1;
}
</style>

<!-- $Date$ $Author$ $Revision$ -->
