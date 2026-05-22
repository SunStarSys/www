---
categories: ~
dependencies: '*.md.es api/index.md.es'
keywords: jamstack,markdown,mermaid,graphviz,editor.md,ide,node.js,oracle,cloud,cdn,http/2,confluencia,slab,noción
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

## Infraestructura de sistema rápido

- Latencia de 50 ms o menos RTT para la mayor parte de la población mundial, con una cobertura ampliada en África/Oriente Medio en 2026

- 2 veces más rápido HTTP / 2 tiempos de entrega de páginas multiplexadas (fuera de la caja, para *todos *los clientes) que la competencia

<div class="embed-responsive embed-responsive-16by9">
	 		<iframe loading="lazy" class="embed-responsive-item" style="margin-bottom:20px;max-width:560;max-height:315" src="https://www.youtube.com/embed/z8QveI4CHT8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

- Construcciones sostenidas de 300 MB/s para árboles fuente de varios gigabytes

- NVMe o una infraestructura de almacenamiento de compilación más rápida

- Solaris 11.4 para la estabilidad de ZFS, respaldado por Soporte completo al cliente de Oracle

- node.js para la representación de rebajas con agrupación en clusters de CPU

- Construcciones simultáneas de 8-64 vías

- Confirmación rápida ahora el valor por defecto para la mayoría de las circunstancias

- Apache httpd 2.4 basado en IDE:

- HTTP/2

- mpm de evento

- mod_perl con ithreads

- mod_apreq2

- TLS 1.3

- Personalizado [`SVN::Cliente`](#) módulo con soporte de ithread para agrupaciones por solicitud

## Multilingüe

- Inglés

- Español

- Alemán

- Francés

- Portugués brasileño

- Ruso

- Chino

- Coreano

- Japonés

- Árabe

- Hebreo

- Sueco

## Mejor soporte para Diffs de Correo y Creación de Clones

- DMARC protegido

- Utiliza SRS y Reply-To para la compatibilidad con ezmlm

- Todos los usuarios son autenticados a través del servicio OpenID-Connect de Google

## El curioso pato es ahora un elegante cisne

<br>

<div class="col-lg-3">
	<div class="embed-responsive embed-responsive-16by9">
	<iframe loading="lazy" class="embed-responsive-item" src="https://www.youtube.com/embed/JNWybe63G3s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	</div>
</div>

<br>

- Estilo Bootstrap 4+ para un estilo semántico CSS fácil y una incorporación rápida.

- Editor.md es increíble: mediante el uso de relativos [`src`](#) urls, las imágenes enlazadas se representarán en el panel de vista previa del editor.

## Representación consistente de Markdown de tipo GitHub (GFM) con Editor.md:editormd-logo-1x y plantillas de Django

- [x] **WYSIWYG:** {# lede #}Mismo motor de representación de código javascript tanto en el explorador como en el script de compilación markdown.js (basado en node.js){# lede #} garantiza una consistencia estructural del 100% entre la ventana de vista previa de Markdown Editor.md y el sitio de producción.
- [x] Las cabeceras YAML en los archivos de origen (markdown) ahora están totalmente soportadas.

- [x] Soporte nativo d3-graphviz.js:

```graphviz
digraph {
a -> b;
a -> c [color=red];
}
```
&nbsp;
----
&nbsp;

- [x] Nativo @mermaid-js/mermaid v11.15.0 con soporte de mindmap:

```mermaid
graph TD
    A[Navidad]
 -->|Obtener dinero| B(Ir de compras)
    B --> C{Permitir pienso yo}
    C -->|Uno| D[fa:fa-laptop Equipo portátil]
    C -->|Dos| E[fa:fa-mobile iPhone]
    C -->|Tres| F[fa:fa-car Coche]
```
----
```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hola John, cómo ¿Eres tú?
    loop Healthcheck
        John->>John: Lucha contra la hipocondría
    end
    Note right of John: Racional pensamientos<br/>prevalezcan...
    John-->>Alice: ¡Genial!
    John->>Bob: Cómo acerca de usted?
    Bob-->>John: ¡Bien!
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
    [*] --> Aún
    Aún --> [*]
    Aún --> Moviendo
    Moviendo --> Aún
    Moviendo --> Bloqueo
    Bloqueo --> [*]
```
----
```mermaid
gantt
    title A Gantt Diagram
    dateFormat  YYYY-MM-DD
    section Section
    Una tarea           :a1, 2014-01-01, 30d
    Otra tarea     :after de a1  , 20d
    section Another
    Tarea en segundos      :2014-01-12  , 12d
    otra tarea      : 24d
```
----
```mermaid
pie title Commits to orion on GitHub
	"Domingo" : 4
	"Lunes" : 5
	"Martes" : 7
  "Miércoles" : 3
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
    sq[Forma cuadrada] --> CI((Círculo forma))

subgraph A
        od>Forma impar]-- Dos líneas<br/>comentario de borde --> ro
        di{Diamante con <br/> salto de línea} -.-> ro(Redondeado<br>cuadrado<br>forma)
        di==>ro2(Rounded forma cuadrada)
    end

%% Notice that no text in shape are added here instead that is appended further down
    e --> od3>Texto realmente largo con salto de línea<br>en una forma extraña]

%% Comentarios tras signos del doble por ciento
    e((Interior/círculo<br>y algunos extraños <br>caracteres especiales)) --> f(,.?!+-*ز)

Cir[Cyrillic]-->cyr2((Circle shape Начало));

classDef green fill:#9f6,stroke:#333,stroke-width:2px;
     classDef orange fill:#f96,stroke:#333,stroke-width:4px;
     class sq,e green
     class di orange
```
----
```mermaid
mindmap
  root((mapa mental))
    Orígenes
      Largo historial
      ::icon(fa fa-libro)
      Popularización
        Británico autor de psicología Tony Buzan
    Investigación
      Sobre la eficacia<br/>y características
      Activado Creación automática
        Usos
            Técnicas creativas
            Estratégico planificación
            Argumento asignación
    Herramientas
      Pluma y papel
      Sirena
```
----
```mermaid
journey
    title Mi día laborable
    section Ir al trabajo
      Hacer té: 5: Yo
      Arriba: 3: Yo
      Hacer trabajo: 1: Yo, Gato
    section Ir a inicio
      Bajar las escaleras: 5: Yo
      Siéntate: 3: Yo
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
    A1[[Usuario público<br/> Mediante API de REST]]
    B1[Servicios de backend/<br/>servicios de frontend]
end
class publicUser,A1 gray

subgraph authorizedUser[ ]
    A2[[Usuario autorizado<br/> Mediante API de REST]]
    B2[Servicios de backend/<br/>servicios de frontend]
end
class authorizedUser,A2 darkBlue

subgraph booksSystem[ ]
    A3[[Sistema de libros]]
    B3[Permite interactuar con registros de libros]
end
class booksSystem,A3 brightBlue

publicUser--Lee registros mediante-->booksSystem
authorizedUser--Lee y escribe registros mediante-->booksSystem

subgraph authorizationSystem[ ]
    A4[[Sistema de autorización]]
    B4[Autoriza el acceso a los recursos]
end

subgraph publisher1System[ ]
    A5[[Sistema Publisher 1]]
    B5[Proporciona detalles sobre los libros publicados por ellos]
end
subgraph publisher2System[ ]
    A6[[Sistema Publisher 2]]
    B6[Proporciona detalles sobre los libros publicados por ellos]
end
class authorizationSystem,A4,publisher1System,A5,publisher2System,A6 gray2

booksSystem--Accede a los detalles de autorización usando-->authorizationSystem
booksSystem--Accede a los detalles del editor mediante-->publisher1System
booksSystem--Accede a los detalles del editor mediante-->publisher2System

class A1,A2,A3,A4,A5,A6,B1,B2,B3,B4,B5,B6 borderless

click A3 "https://github.com/csymapp/mermaid-c4-model/blob/master/containerDiagram.md" "booksSystem"
```

&nbsp;
----
&nbsp;

- [x] Markmap.js Ver soporte

- [x] Don Knuth's [$$\TeX$$](https://www.iconoclasts.blog/joe/triple-products.pdf) / Academia de Kahn [$$\KaTeX$$](https://en.wikipedia.org/wiki/KaTeX) Soporte para matemáticas, física y química:

```math
\ce{ Zn^2+ <=>[\ce{+ 2OH-}][\ce{+ 2H+}]$\underset{\text{amphoteric hydroxide}}{\ce{Zn(OH)2 v}}$<=>C[+2OH-][{+ 2H+}]$\underset{\text{tetrahydroxozincate}}{\ce{[Zn(OH)4]^2-}}$ }
```

- [x] Generación Bidireccional y Síncrona de $$\LaTeX$$ Archivos de origen a/desde Markdown+$$\KaTeX$$ Archivos.

- [x] Navier-Stokes en la notación de Einstein (aka [DOLOR](https://en.wikipedia.org/wiki/Abstract_index_notation))

```math
\begin{aligned}
\pdv{\rho}{t}+\pdv{(\rho u_i)}{x_i} &= 0 \\
      \pdv{(\rho u_i)}{t}+\pdv{(\rho u_i u_j)}{x_j} &= -\pdv{p}{x_i}+\pdv{\tau_{ij}}{x_j}+\rho f_i \\
      \pdv{(\rho e)}{t}+\pdv{(\rho e+p)u_i}{x_i} &= \pdv{(\tau_{ij} u_j)}{x_i}+\rho f_i u_i+\pdv{(\dot{q}_i)}{x_i}+r \\
\end{aligned}
```

- [x] Navier-Stokes en notación clásica

```math
\begin{aligned}
\pdv{\rho}{t}+\vec{\nabla}\cdot(\rho\vec{u}) &= 0 \\
      \pdv{(\rho \vec{u})}{t}+\vec{\nabla}\cdot\rho\vec{u}\otimes\vec{u} &= -\vec{\nabla p}+\vec{\nabla}\cdot\bar{\bar{\tau}}+\rho\vec{f} \\
      \pdv{(\rho e)}{t}+\vec{\nabla}\cdot(\rho e+p)\vec{u} &= \vec{\nabla}\cdot(\bar{\bar{\tau}}\cdot\vec{u})+\rho\vec{f}\cdot\vec{u}+\vec{\nabla}\cdot\vec{\dot{q}}+r
\end{aligned}
```

----

- [x] ¡Eléctrico!

Editor se autocompletará y autoindent; tiene modo de pantalla completa, así como soporte para varios otros modos de creación de contenido disponibles para su resaltador de sintaxis CodeMirror 5.

## Soporte completo para creaciones de sucursales

- [x] No hay más ubicación temporal/publicación: se ha sustituido por una rama por recurso <span class="text-white">Promoción</span>.
- [x] <span class="text-white">Rollback</span> y <span class="text-white">Sincronizar</span> Combinación totalmente soportada.

## Motor de búsqueda de árbol de origen activo

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

- [x] Perl Compatible Regular Expression (PCRE) basado.
- [x] La funcionalidad de búsqueda y sustitución global también (compatibilidad única con PCRE); admite capturas de expresiones regulares.
- [ ] Búsqueda en PDF próximamente.
- [ ] Compatibilidad con GraphQL/AI próximamente. ¡La seguridad se ve divertida!

## Anexos de página ilimitados con tipos MIME arbitrarios

## Comentarios por página seguros y roscados

## Traducciones automatizadas de lenguaje natural de Markdown

## Gráficos vectoriales matemáticos interactivos con @vectorgraphics/asymptote

- [x] Resaltar sintaxis para asíntota
- [x] CMS fallará rápidamente en bloques de código asíntota no analizables
- [x] Salida HTML activada para WebGL con varios subprocesos

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

## Deltas de <span class='text-info'>CMS de apache</span> Funciones

- Solo está disponible el sistema de creación basado en Perl.

- El nuevo editor de Markdown es [`marcado/gfm`](#) basado, por lo que el analizador es más moderno.  La última versión admite la especificación de enlace amigable (slug) al analizador original basado en python.

- GFM utiliza un delimitador diferente para los bloques de código.

- [`extpaths.txt`](#) ya no es compatible: a las personas seleccionadas de cada proyecto se les otorgará acceso de escritura al árbol del sitio web de producción en nuestros repositorios de subversión para cargar material producido externamente (javadocs, artefactos de versión de software, etc.)

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
