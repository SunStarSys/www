---
archived: ~
categories: ~
dependencies: '*.md.ru api/index.md.ru'
keywords: jamstack,markdown, русалка, graphviz,editor.md,ide,node.js,oracle,cloud,cdn,http/2,confluence,slab,notation
published: ~
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

- 50 мс или менее задержки RTT для большей части населения мира, с расширенным охватом в Африке в 2024 году

- в 2 раза быстрее время доставки мультиплексированной страницы HTTP/2 (для *всех* клиентов) по сравнению с конкурентами

<div class="embed-responsive embed-responsive-16by9">
	 		<iframe loading="lazy" class="embed-responsive-item" style="margin-bottom:20px;max-width:560;max-height:315" src="https://www.youtube.com/embed/z8QveI4CHT8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

- 500 МБ / с устойчивыми сборками для многогигабайтных исходных деревьев

- NVMe или более быстрая разработка инфраструктуры хранения данных

- Solaris 11.4 для стабильности работы ZFS при поддержке Oracle Customer Support

- node.js для визуализации разметки с помощью кластеризации ЦП

- 8-64 способа параллельных сборок

- Быстрая фиксация теперь используется по умолчанию для большинства обстоятельств

- IDE на основе Apache httpd 2.4:

- HTTP/2

- событие mpm

- mod_perl без потоков

- mod_apreq2

- TLS 1.3

- Пользовательский [`SVN::Клиент`](#).

## Многоязычный

- английский

- Испанский

- Немецкий

- Французский

- русский

- Китайский

- иврит

- шведский

## Улучшенная поддержка рассылок и создания клонов

- DMARC-защита

- Использует SRS и Reply-To для совместимости с ezmlm

- Все пользователи проходят аутентификацию через сервис OpenID-Connect компании Google

## Интересно выглядящий утенок теперь элегантный лебедь

<br>

<div class="col-lg-3">
	<div class="embed-responsive embed-responsive-16by9">
	<iframe loading="lazy" class="embed-responsive-item" src="https://www.youtube.com/embed/JNWybe63G3s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	</div>
</div>

<br>

- Bootstrap 4+ стиль для легкого семантического стиля CSS и быстрой адаптации.

- Editor.md удивительно: используя относительный [`src`](#).

## Согласованная визуализация GitHub-Flavored Markdown (GFM) с Editor.md :editormd-logo-1x: и Django Templating

- [x] **WYSIWYG:** {# lede #}Одно и то же ядро визуализации кода javascript как в браузере, так и в сценарии сборки markdown.js (на основе node.js){# lede #} обеспечивает 100% структурную согласованность между окном предварительного просмотра разметки Editor.md и производственной площадкой.
- [x] Заголовки YAML в исходных файлах (уценка) теперь полностью поддерживаются.
- [x]

```flow
st=>start: börja
op=>operation: operation
cond=>condition: villkor Ja eller Nej?
e=>end: slutet

st->op->cond
cond(yes)->e
cond(no)->op
```
----
```seq
Andrew->Jenni: Says Hello
Note right of Jenni: Jenni thinks\nabout it
Jenni-->Andrew: How are you?
Andrew->>Jenni: I am good thanks!
```
&nbsp;
----
&nbsp;

- [x]

```graphviz
digraph {
a -> b;
a -> c [color=red];
}
```
&nbsp;
----
&nbsp;

- [x]

```mermaid
graph TD
    A[Christmas]
 -->|Get money| B(Go shopping)
    B --> C{Let me think}
    C -->|One| D[Laptop]
    C -->|Two| E[iPhone]
    C -->|Three| F[fa:fa-car Car]
```
----
```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts<br/>prevail...
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
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
    [*] --> Still
    Still --> [*]
    Still --> Moving
    Moving --> Still
    Moving --> Crash
    Crash --> [*]
```
----
```mermaid
gantt
    title A Gantt Diagram
    dateFormat  YYYY-MM-DD
    section Section
    A task           :a1, 2014-01-01, 30d
    Another task     :after a1  , 20d
    section Another
    Task in sec      :2014-01-12  , 12d
    another task      : 24d
```
----
```mermaid
pie title Commits to orion on GitHub
	"Sunday" : 4
	"Monday" : 5
	"Tuesday" : 7
  "Wednesday" : 3
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
    sq[Square shape] --> ci((Circle shape)).

subgraph A
        od>Odd shape]-- Two line<br/>edge comment --> ro
        di{Diamond with <br/> line break} -.-> ro(Rounded<br>square<br>shape)
        di==>ro2(Rounded square shape)
    end

%% Notice that no text in shape are added here instead that is appended further down
    e --> od3>Really long text with linebreak<br>in an Odd shape]

%% Comments after double percent signs
    e((Inner / circle<br>and some odd <br>special characters)) --> f(,.?!+-*ز).

cyr[Cyrillic]-->cyr2((Circle shape Начало));

classDef green fill:#9f6,stroke:#333,stroke-width:2px;
     classDef orange fill:#f96,stroke:#333,stroke-width:4px;
     class sq,e green
     class di orange
```
----
```mermaid
mindmap
  root((mindmap))
    Origins
      Long history
      ::icon(fa fa-book)
      Popularisation
        British popular psychology author Tony Buzan
    Research
      On effectivness<br/>and features
      On Automatic creation
        Uses
            Creative techniques
            Strategic planning
            Argument mapping
    Tools
      Pen and paper
      Mermaid
```
----
```mermaid
journey
    title My working day
    section Go to work
      Make tea: 5: Me
      Go upstairs: 3: Me
      Do work: 1: Me, Cat
    section Go home
      Go downstairs: 5: Me
      Sit down: 3: Me
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
    A1[[Public User<br/> Via REST API]]
    B1[Backend Services/<br/>frontend services]
end
class publicUser,A1 gray

subgraph authorizedUser[ ]
    A2[[Authorized User<br/> Via REST API]]
    B2[Backend Services/<br/>frontend services]
end
class authorizedUser,A2 darkBlue

subgraph booksSystem[ ]
    A3[[Books System]]
    B3[Allows interacting with book records]
end
class booksSystem,A3 brightBlue

publicUser--Reads records using-->booksSystem
authorizedUser--Reads and writes records using-->booksSystem

subgraph authorizationSystem[ ]
    A4[[Authorization System]]
    B4[Authorizes access to resources]
end

subgraph publisher1System[ ]
    A5[[Publisher 1 System]]
    B5[Gives details about books published by them]
end
subgraph publisher2System[ ]
    A6[[Publisher 2 System]]
    B6[Gives details about books published by them]
end
class authorizationSystem,A4,publisher1System,A5,publisher2System,A6 gray2

booksSystem--Accesses authorization details using-->authorizationSystem
booksSystem--Accesses publisher details using-->publisher1System
booksSystem--Accesses publisher details using-->publisher2System

class A1,A2,A3,A4,A5,A6,B1,B2,B3,B4,B5,B6 borderless

click A3 "https://github.com/csymapp/mermaid-c4-model/blob/master/containerDiagram.md" "booksSystem"
```

&nbsp;
----
&nbsp;

- [x]

- [x] Дон Кнут [$$\TeX$$](https://www.iconoclasts.blog/joe/triple-products.pdf) / Академия Кан [$$\KaTeX$$](https://en.wikipedia.org/wiki/KaTeX).

```math
\ce{ Zn^2+ <=>[\ce{+ 2OH-}][\ce{+ 2H+}]$\underset{\text{amphoteric hydroxide}}{\ce{Zn(OH)2 v}}$<=>C[+2OH-][{+ 2H+}]$\underset{\text{tetrahydroxozincate}}{\ce{[Zn(OH)4]^2-}}$ }
```

- [x] синхронная, двунаправленная генерация $$\LaTeX$$ Исходные файлы в/из Markdown+$$\KaTeX$$

- [x] Навье-Стокс в системе обозначений Эйнштейна (aka) [Болезнь](https://en.wikipedia.org/wiki/Abstract_index_notation).

```math
\begin{aligned}
\pdv{\rho}{t}+\pdv{(\rho u_i)}{x_i} &= 0 \\
      \pdv{(\rho u_i)}{t}+\pdv{(\rho u_i u_j)}{x_j} &= -\pdv{p}{x_i}+\pdv{\tau_{ij}}{x_j}+\rho f_i \\
      \pdv{(\rho e)}{t}+\pdv{(\rho e+p)u_i}{x_i} &= \pdv{(\tau_{ij} u_j)}{x_i}+\rho f_i u_i+\pdv{(\dot{q}_i)}{x_i}+r \\
\end{aligned}
```

- [x]

```math
\begin{aligned}
\pdv{\rho}{t}+\vec{\nabla}\cdot(\rho\vec{u}) &= 0 \\
      \pdv{(\rho \vec{u})}{t}+\vec{\nabla}\cdot\rho\vec{u}\otimes\vec{u} &= -\vec{\nabla p}+\vec{\nabla}\cdot\bar{\bar{\tau}}+\rho\vec{f} \\
      \pdv{(\rho e)}{t}+\vec{\nabla}\cdot(\rho e+p)\vec{u} &= \vec{\nabla}\cdot(\bar{\bar{\tau}}\cdot\vec{u})+\rho\vec{f}\cdot\vec{u}+\vec{\nabla}\cdot\vec{\dot{q}}+r
\end{aligned}
```

----

- [x]

Редактор будет автоматически завершать и автоматически отступать; имеет полноэкранный режим, а также поддержку нескольких других режимов редактирования контента, доступных для его подсветки синтаксиса CodeMirror 5.

## Полная поддержка сборки ветвей

- [x] Больше нет промежуточного хранения/публикации: заменено на ветвь <span class="text-white">Рекламная акция</span> для каждого ресурса.
- [x]

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

- [x] Регулярное выражение, совместимое с Perl (PCRE).
- [x] Функциональность глобального поиска и замены (уникальная, учитывая поддержку PCRE); поддерживает записи регулярных выражений.
- [ ] Поиск PDF скоро начнется.
- [ ]

## Неограниченное количество вложений страниц без произвольных mime-типов

## Безопасные, многопоточные комментарии на странице

## Автоматизированные переводы на естественный язык для снижения цен (скоро).

## Интерактивная математическая векторная графика с @vectorgraphics/asymptote

- [x] Подсветка синтаксиса для асимптоты
- [x] CMS быстро выйдет из строя на необработанных блоках кода Asymptote
- [x]

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
pen periwinklePen =  redPortion * red + greenPortion * green + bluePortion * blue;
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

## Дельта из возможностей <span class='text-info'>Apache CMS</span>

- Доступна только система сборки на базе Perl.

- Новый редактор снижения цен [`отмечено/gfm`](#).

- GFM использует другой разделитель для блоков кода.

- [`extpaths.txt`](#).

----

## индекс

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

<!-- $Date: 2024-05-10 12:44:07 -0400 (Fri, 10 May 2024) $ $Author: joe $ $Revision: 25004 $ -->
