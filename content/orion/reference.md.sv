---
archived: ~
categories: ~
dependencies: '*.md.sv api/index.md.sv'
keywords: ~
published: ~
status: skiss
title: Orionreferens
---

<div class="float-lg-right">
	<img src="../images/sunstarstaronly.png">
</div>

## Live-demo

För en demonstration av Orion &trade;

Om det är för mycket besvär för dig, är denna webbplats själv värd på Orion &trade;och {# lede #}de heta rosa pennikonerna [<img src="../images/edit.png" style="width:20px">](javascript:location.href='https://cms.sunstarsys.com/redirect?uri='+location.href) längst upp till höger bredvid brödsmulorna ger dig en live-demonstration{# lede #}

## Rekommenderat bokmärke

Var noga med att installera bokmärket i webbläsarens verktygsfält genom att öppna en dialogruta för "Nytt bokmärke" från webbläsarens meny och skriva följande i fältet Plats/URL:

```javascript
	javascript:void(location.href='https://cms.sunstarsys.com/redirect?uri='+escape(location.href))
```

Utan denna bookmarklet installerad kan du inte surfa på live-webbplatsen och omedelbart redigera sidor i Orion &trade;

Om du vill använda bokmärket bläddrar du bara till produktionswebbplatsen (INTE i Orion) &trade;

## Komma igång-guide

<div class="embed-responsive embed-responsive-16by9">
	 	<iframe class="embed-responsive-item" style="max-width:560;max-height:315" src="https://www.youtube.com/embed/4-KiEDFbzl4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	</div>
	<p style="height:20px">&nbsp;</p>

## IoC Bygg API

[snippet:lang=perl:repo=SunStarSys/orion:path=README.md:token=#api]

## Introduktionsprocess

För tidiga adoptörer, Orion &trade;

1. Förse oss med webbadressen till din webbplats källor i Subversion.

2. Ge oss e-postadressen (roll eller e-postlista) för att diskutera problem med webbplatsutveckling och underhåll och se till att adressen är [SBS](https://en.wikipedia.org/wiki/Sender_Rewriting_Scheme).

3. Prenumerera på dina produktionswebbservrar' `svnwcsub` Demon till vår publik `svnpubsub`

4. Låt oss veta om du vill att innehållet skiljer sig från de byggen som skickas ut och till vilken e-postadress du vill att de ska levereras.

## Layout för källkatalog

- bål/
	- cgi-bin/
	- innehåll/
	- mallar/
	- lib/
		- path.pm
		- view.pm
- filialer/


Se <https://vcs.sunstarsys.com/repos/svn/public/cms-sites/www.sunstarsys.com/> för ett liveexempel.

## Dynamiskt innehåll

### Exempelskript för att generera om en källsida med ändrat innehåll, även när källorna inte gör det.

Grundtanken är att några av dina högprofilerade källsidor bygger med "dynamiskt" innehåll (bygga innehåller ständigt föränderliga utdrag från andra online-webbplatser, som Jira vattenfall eller aktuella e-postlisttrådar).

Ett bra exempel på detta är avsnittet "Senaste nyheter" i [ASF: Hemsida](https://www.apache.org/), och här är bakom kulisserna hur det fungerar, med lite shell + svn + cron magi som exemplifieras här (ta den dynamiska byggets källfil som `$fil`

```shell
% cp $file $file.tmp
% svn rm $file
% mv $file.tmp $file
% svn add $file
% svn commit -m "rebuild $file"
```

Införliva detta i ett litet skalskript som kommer att använda dina cachelagrade svn-inloggningsuppgifter på din egen dator och få cron att köra det åt dig på ett fast schema (baserat på din frontend-webbserver / CDN HTTP-cacheens TTL).  Inget behov av verktyg på serversidan i vår ände; du har full kontroll över din egen lösenordssäkerhet, schemaläggning och dynamiska sidmål.  Om du använder din egen svnpubsub-aktiverade Subversion-tjänst innebär ingen av den transaktionen direkt någon av vår hårdvara. Din bekräftelse utlöser vår svnwcsub-klient, som alltid lyssnar på din svnpubsub-server, för att bygga och distribuera dessa ändringar på begäran &mdash;

Antal undantag

Ej fastställt

## Sök

Ej fastställt

## Snabbbekräftelse

Ej fastställt

## Lägg till resurs

Ej fastställt

--------

## Index

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
