---
archived: ~
categories: ~
dependencies: '*.md.es api/index.md.es'
keywords: jamstack,markdown, sirena,graphviz,editor.md,ide,node.js,oracle,cloud,cdn,http/2,confluencia,slab,notion
published: ~
status: borrador
title: Características de Orion
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

## Infraestructura de sistema rápida e intensa

- 50 ms o menos de latencia de RTT para la mayor parte de la población mundial, con planes para ampliar la cobertura en África

- 2 veces más rápido HTTP / 2 tiempos de entrega de páginas multiplexadas (listos para usar, para * todos * los clientes) que la competencia

<div class="embed-responsive embed-responsive-16by9">
	 		<iframe loading="lazy" class="embed-responsive-item" style="margin-bottom:20px;max-width:560;max-height:315" src="https://www.youtube.com/embed/z8QveI4CHT8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

- 500 MB/s de construcciones sostenidas para árboles de origen de varios gigabytes

- NVMe o una infraestructura de almacenamiento de creación más rápida

- Solaris 11.4 para la estabilidad de ZFS, respaldado por Full Oracle Customer Support

- node.js para la representación de Markdown con clusters de CPU

- 8-64 formas de construcciones simultáneas

- Compromiso rápido ahora la configuración por defecto para la mayoría de las circunstancias

- IDE basado en httpd 2.4 de Apache:

- HTTP/2

- evento mpm

- mod_perl con ithreads

- mod_apreq2

- TLS 1.3

- Personalizado [`SVN::Cliente`](#).

## Multilingüe

- Español

- Español

- Alemán

- Francés

## Mejor soporte para diferenciadores de correo y creación de clonaciones

- Protegido por DMARC

- Utiliza SRS y Responder a para la compatibilidad ezmlm

- Todos los usuarios se autentican a través del servicio OpenID-Connect de Google

## El patito curioso es ahora un cisne elegante

<br>

<div class="col-lg-3">
	<div class="embed-responsive embed-responsive-16by9">
	<iframe loading="lazy" class="embed-responsive-item" src="https://www.youtube.com/embed/JNWybe63G3s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	</div>
</div>

<br>

- Estilo Bootstrap (Solarized).

- Editor.md es increíble: al utilizar relativo [`origen`](#).

## Representación consistente de rebajas con sabor a GitHub (GFM) con Editor.md :editormd-logo-1x: y plantillas de Django

- [x] **SEMIOLOGÍA:** {# lede #}El mismo motor de representación de código javascript tanto en el explorador como en el script de compilación markdown.js (basado en node.js){# lede #} garantiza una consistencia estructural del 100 % entre la ventana de vista previa de Markdown de Editor.md y el sitio de producción.
- [x] Las cabeceras YAML en los archivos de origen (markdown) ahora están totalmente soportadas.
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

- [ ]

- [x] Don Knuth [$$\TeX$$](https://www.iconoclasts.blog/joe/triple-products.pdf) / Academia de Kahn [$$\KaTeX$$](https://en.wikipedia.org/wiki/KaTeX).

```math
\ce{ Zn^2+ <=>[\ce{+ 2OH-}][\ce{+ 2H+}]$\underset{\text{amphoteric hydroxide}}{\ce{Zn(OH)2 v}}$<=>C[+2OH-][{+ 2H+}]$\underset{\text{tetrahydroxozincate}}{\ce{[Zn(OH)4]^2-}}$ }
```

- [x] Generación Bidireccional Síncrona de $$\LaTeX$$ Archivos de origen a/desde Markdown+$$\KaTeX$$

- [x] Navier-Stokes en la notación de Einstein [DOLOR](https://en.wikipedia.org/wiki/Abstract_index_notation).

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

El editor se autocompletará y se autoindentará; tiene modo de pantalla completa, así como soporte para varios otros modos de creación de contenido disponibles para su resaltador de sintaxis CodeMirror 5.

## Soporte completo para creaciones de sucursales

- [x] No más ubicación temporal/publicación: sustituido por <span class="text-white">promoción</span> de rama por recurso.
- [x]

## Buscador de árbol fuente en vivo

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

- [x] Se basa en la expresión regular compatible (PCRE).
- [x] La funcionalidad de búsqueda y sustitución global también (soporte único de PCRE); admite capturas de expresiones regulares.
- [ ] La búsqueda en PDF llegará pronto.
- [ ]

## Archivos adjuntos de página ilimitados con tipos MIME arbitrarios

## Comentarios seguros por página

## Traducciones de lenguaje natural automatizadas de Markdown (próximamente).

## Gráficos vectoriales matemáticos interactivos con @vectorgraphics/asymptote

- [x] Resaltador de sintaxis para asíntota
- [x] CMS fallará rápidamente en bloques de código asintótico no analizables
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

## Deltas de las funciones de <span class='text-info'>Apache CMS</span>

- Solo está disponible el sistema de compilación basado en Perl.

- El nuevo editor de Markdown es [`marcado/gfm`](#).

- GFM utiliza un delimitador diferente para los bloques de código.

- [`extpaths.txt`](#).

----

## Índice

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
