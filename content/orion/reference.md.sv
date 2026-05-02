---
categories: ~
dependencies: '*.md.sv api/index.md.sv'
keywords: ~
status: skiss
title: Orionreferens
---

<div class="lg right">
	<img src="../images/sunstarstaronly.png">
</div>

## Live-demo

För en demonstration av Orion &trade;'s IDE, besök <https://www.openoffice.org/> för en massiv webbplats, eller <https://thrift.apache.org/> för en invecklad en, och klicka på ovanstående bokmärke för att se en levande prototyp i aktion.

Om det är för mycket besvär för dig, är denna webbplats själv värd på Orion &trade;och {# lede #}dessa heta rosa penna ikoner [<img style="width:20px" src="../images/edit.png">](javascript:location.href='https://cms.sunstarsys.com/redirect?uri='+location.href) längst upp till höger bredvid brödsmulorna kommer att ge dig en levande demonstration{# lede #} hur systemet fungerar (utan bekräftelse-/byggbehörighet, som endast är låst för personal).

## Rekommenderade bokmärken

Var noga med att installera bokmärket i webbläsarens verktygsfält genom att öppna en "Nytt bokmärke" -dialogrutan från webbläsarens meny och skriv in följande i fältet Plats/URL:

```javascript
	javascript:void(location.href='https://cms.sunstarsys.com/redirect?uri='+escape(location.href))
```

Utan det här bokmärket installerat kommer du inte att kunna bläddra i den aktiva webbplatsen och omedelbart redigera sidor i Orion &trade; genom att klicka på bokmärket.

Om du vill använda bokmärket bläddrar du bara till din aktiva produktionswebbplats (INTE i Orion) &trade;!), hitta en sida du vill redigera och klicka på bokmärket. Du kommer till en sida inom denna Orion som låter dig redigera innehållet.

## Komma igång-guide

<div class="embed-responsive embed-responsive-16by9">
	 	<iframe class="embed-responsive-item" style="max-width:560;max-height:315" src="https://www.youtube.com/embed/4-KiEDFbzl4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	</div>
	<p style="height:20px">&nbsp;</p>

## IoC API för bygge

[snippet:lang=perl:repo=SunStarSys/orion:path=README.md:token=#api]

## Introduktionsprocess

För tidiga adoptörer, Orion &trade; Tjänsten ligger mellan källträdet för Subversion-databasen och de produktionswebbservrar som levererar webbplatsinnehåll till slutanvändarna.  Introduktionen är enkel för organisationer som redan kör sin egen svnpubsub-aktiverade Subversion-tjänst:

1. Ge oss URL:en till din webbplats källor i Subversion.

2. Ge oss e-postadressen (roll eller e-postlista) för att diskutera problem med webbplatsutveckling och underhåll, och se till att adressen är [SBS](https://en.wikipedia.org/wiki/Sender_Rewriting_Scheme)-efterlevnad när det gäller måttliga anläggningar.

3. Prenumerera på dina produktionswebbservrar" `Täcksub` Demon till vår publik `svnpubsub` tjänst  Dessa fristående programvarukomponenter är en del av varje ny Subversion-källversion, och är rimligt mogna och väl stödda av Subversion Development Team.  Om du bara inte kan vänta på att python3-porten ska slutföras kan vi låta dig använda våra (trådade) portar istället.

4. Låt oss veta om du vill att innehåll skiljer sig från de byggen som skickas ut, och till vilken e-postadress du vill att de ska levereras.

## Källkataloglayout

- bål/
	- cgi-bin/
	- innehåll/
	- mallar/
	- lib/
		- path.pm
		- view.pm
- filialer/
	.. varje gren följer trunk layout ovan ...

Se <https://github.com/SunStarSys/www.iconoclasts.blog/tree/trunk> för ett levande exempel.

## Dynamiskt innehåll

### Exempelskript för att generera om en källsida med ändrat innehåll, även när källorna inte gör det.

Grundtanken är att några av dina högprofilerade källsidor byggs med "dynamisk" innehåll (bygg innehåller ständigt föränderliga utdrag från andra online-webbplatser, som Jira vattenfall eller aktuella sändlistetrådar).

Ett bra exempel på detta är "Senaste nytt" sektion av [ASF: Hemsida](https://www.apache.org/), och här är bakom kulisserna hur det fungerar, med lite skal + svn + cron magi som exemplifieras här (ta den dynamiska byggets källfil som `$fil` nedan:

```shell
% cp $file $file.tmp
% svn rm $file
% mv $file.tmp $file
% svn add $file
% svn commit -m "rebuild $file"
```

Införliva detta i ett litet skalskript som kommer att använda dina cachade svn-inloggningsuppgifter på din egen dator och låta cron köra det åt dig på ett fast schema (baserat på din klientwebbserver / CDN HTTP-cachens TTL).  Inget behov av serververktyg i vår ände; du har full kontroll över din egen lösenordssäkerhet, schemaläggning och dynamiska sidmål.  Om du använder din egen svnpubsub-aktiverade Subversion-tjänst, innebär ingen av den transaktionen direkt någon av vår hårdvara. Din bekräftelse utlöser vår svnwcsub-klient, som alltid lyssnar på din svnpubsub-server, för att bygga och distribuera dessa ändringar på begäran &mdash; snart.

## Undantag

Ej fastställt

## Sök

Ej fastställt

## Snabbincheckning

Ej fastställt

## Lägg till resurs

Ej fastställt

--------

## Index

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
