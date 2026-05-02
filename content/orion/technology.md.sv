---
categories: ~
dependencies: '*.md.sv api/index.md.sv'
keywords: Nedsättning, Asymptote, Sjöjungfru
status: skiss
title: Orionteknik
---

## Solaris 11.4

- DTrace &mdash; Vi tog kökshandfat tillvägagångssätt: alla våra dyamic programmeringsspråk verktyg integreras med det.  Medan bpftrace är en trevlig ny utveckling för Linux, att ha det gör användbara saker i det dynamiska språkutrymmet är långt borta, vilket är där åtgärden är.

- ZFS &mdash; bättre med Solaris, uppbackat av Oracle Support.  Acceptera inga ersättare.

- Zoner &mdash; tillhandahåller serviceisolering och lämpligt sandlådade webbplatsbyggen.

## node.js v21.6.1

- Eftersom Editor.md är **fantastisk**, portade vi det till [`node.js`](#) &mdash; WYSIWYG, oavsett tittarens sammanhang (redigering i vår online IDE, eller surfa på den resulterande produktionswebbplatsen).

## Perl v5.38.2

- {# lede #}Nu med mod_perl v2.0.14 w/ ithreads och httpd v2.4.67 w/ event mpm.{# lede #}

## Subversion v1.14.6

- anpassad ithread-safe [`SVN::Klient`](#) bindningar med minnespooler per begäran.

- ursprungliga python3 bindningar (v3.8.3).

- gängade python3 portar av svnpubsub och svnwcsub &mdash; hela *kit och caboodle* för distribuerad driftsättning av företags-/CDN-platser med Subversion.

- slutförde python3 [visningarvc](https://vcs.sunstarsys.com/viewvc/public/site) hamn.  Kommer att titta på en hämtningsbegäran för mina ändringar uppströms som tiden tillåter.

------------

## Några anmärkningar på vägarna inte (ännu?) Utförd...

<br/>

### SQL

Vi är en NoSQL-butik för hela vår webbplatsinfrastruktur, och om du är sadlad med en gigantisk enpunktsfel känd som en RDBMS som driver din webbplats tillgångar, vänligen ompröva en mer decentraliserad strategi baserad på Jamstack och Serverless Technology. Även om det inte är vår. Du kommer att tacka oss senare!

### Varför inte Git?

- Den [`git tjänst`](#) bro finns redan om du föredrar att arbeta med git själv, istället för att använda online IDE för Orion &trade;. Du har valmöjligheter! Du kan upptäcka att du får ännu mer körsträcka av GitHub åtgärder genom att trycka på dina ändringar till GitHub (och luddning dem i en GitHub åtgärd, eller pre-commit hook, eller båda, säg) innan [`git svn dcommit`](#)-ing dem till våra Subversion repos för live publicering. [Här](https://github.com/SunStarSys/www) är en levande, historia komplett git kopia av hela webbplatsens källor.

- Webbplatsens källträd är inte riktigt som programvarukällträd, när det gäller hur du ändrar och hanterar dem.  De är mer anpassade till [devops / trunk baserad utveckling](/essays/devops) än med [`gitflöde`](#). Dessutom kommer gigantiska webbplatser att behöva SSI, och kanske lite CGI, för deras användning: åtminstone för att undvika massiv, ogranskbar webbplats bortfall från lika massiv commit mailer [`diff`](#) utdata för de resulterande byggträdsdeluppgifterna.

- Att wit: försöker få en fullt fungerande SSI-implementering ur några lokala "webbserver" att du använder för att förhandsgranska dina ändringar i något annat byggsystem, är bara lite dumt om du slutar och tänker på det.  Med vår Orion skapar du bara en gren i svn och av dig går: redigera, begå, bygga, surfa och **iterera**, omedelbart, på en per gren, efemär Apache-serverad webbplats som är integrerad i Orion &trade; IDE:s infrastruktur för dubbelriktad länk (och bokmärkesomdirigering).  <span class="text-primary">Utan att någonsin lämna din webbläsare</span>.

- När det är dags att migrera dessa ändringar till den stambaserade produktionsplatsen kan du välja att marknadsföra så mycket, eller så lite, av grenen som du tycker passar, direkt tillbaka till bagageutrymmet.  Om bagageutrymmet har rört sig framåt sedan dina grenändringar var i slutändan redo för prime time, klicka bara på <span class="text-white">Synkronisera</span> -knappen för att synkronisera kopplingsstammen med grenen.  Efter dubbelkontroll av byggresultaten för din post-sync-sammanslagning åtagande till din gren webbplats, gå vidare och klicka på <span class="text-white">Flytta upp</span> Länk, följ upp med en <span class="text-white">Bekräfta</span> På samma sida med ett rimligt bekräftelseloggmeddelande, och voilà, sänder du nu på bagageutrymmets produktionsbyggnad.

- Om du behöver distribuera och hantera resulterande byggträd med versionskontroll, kommer du inte att gilla git i stor skala. Speciellt när du integrerar binära artefakter (t.ex. programvaruversioner) eller (äldre) produktdokumentation (tänk doxygen eller javadocs), byggda med det här systemet eller med hjälp av en tredjepartsbyggare som du använder lokalt för att bara ladda upp dessa byggresultat direkt till våra måldatalager. Med vårt tillvägagångssätt kan du undvika onödigt kaos och uppblåsthet i din webbplats källträd, till skillnad från hur det skulle fungera med git, med hjälp av grenar i ett förråd som är gemensamt för både din källa och bygga träd.

- Subversion stöder **finkornig åtkomstkontroll** och låter dig göra partiella/glesa utcheckningar av [`Huvud`](#); med Git har du **NO ACL**s annat än på en allt-eller-inget-grenpush, och du måste klona hela grenen (som inkluderar historik) tidigare.  Om du inte känner igen nödvändigheten av dessa svn-bara funktionsuppsättningar, har du inte groked föregående objekts (se ovan) kommentarer ännu.

- För IDE skulle vi behöva läs + skriv Perl bindningar för [`libgit2`](#) (som **inte tillhandahålls av den faktiska git utvecklingsteamet**, och till stor del stöds av megalitiska företag som INTE tillhandahåller en online IDE för git som en jämförbar SaaS-produkt; och nej, GitHub är det inte) för att matcha svns httpd-kompatibla minneshanteringssystem och POSIX (+ Perl ithreads) trådsäkerhet, i en beständig exekvering och över flera server-sida på disk git-datalager av klientwebbplatsträd.  Mognaden för denna infrastruktur med öppen källkod är inte möjlig för 2020 enligt vår uppskattning, men vi kommer att hålla koll på utvecklingen framåt.  Tittar på dig, [`Git::Raw`](#)!

- Jag vet fortfarande inte hur man gör ett posix-thread-säker git porslin.  Trådsäkerhet över separata datalager, men inom en gemensam process RAM, är användningsfallet, inte trådsäkerhet inom ett visst datalager (vilket är en nötig fråga).

### Varför inte Python eller Ruby eller Javascript eller Go?

- [GIL](https://en.wikipedia.org/wiki/Global_interpreter_lock)-addlade [`mod_python`](#) fortfarande har en väg att gå innan den når mognaden av [`mod_perl`](#) i ett gängat mpm. Dessutom är vår produkts nuvarande implementering tätt integrerad med Apache HTTPd serverns fullständiga modul API, som endast [`mod_perl`](#) tillhandahåller.

- [GIL](https://en.wikipedia.org/wiki/Global_interpreter_lock)-addlade [`mod_ruby`](#) Av olika kvalitetskontrollskäl övergavs Ruby-samhället.  Portning av de anpassade 5K LOC Perl 5-källorna i Orion &trade; till en annan programmeringsmiljö skulle resultera i ungefär en <span class="text-warning">10-100 vikbar ballong</span> av implementeringens linjeantal, och följaktligen en stor försämring av prestanda i något annat dynamiskt programmeringsspråk.

Här är en ögonblicksbild, daterad den 19 juli 2020, av SunStar-systemdelen av produktionskällträdet för hela Orion (IDE+build).  Det är inte mycket mer som är involverat än vår [`Dotiac::DTL`](#) gaffel.  All kod relaterad till bygget har redan öppnats på GitHub.  Det som förblir privat är de C-baserade anpassningarna till källträd från tredje part, som är unika differentierare för vår produkt.

```shell
joe@zeus:/x1/Orion% wc -l */lib/SunStarSys/**/*.pm
     1 build/lib/SunStarSys/ASF.pm
   128 build/lib/SunStarSys/SVNUtil.pm
   270 build/lib/SunStarSys/Util.pm
    36 build/lib/SunStarSys/Value.pm
    82 build/lib/SunStarSys/Value/Blogs.pm
    61 build/lib/SunStarSys/Value/Jira.pm
    77 build/lib/SunStarSys/Value/Mail.pm
    70 build/lib/SunStarSys/Value/SVN.pm
   106 build/lib/SunStarSys/Value/Snippet.pm
    85 build/lib/SunStarSys/Value/Twitter.pm
   378 build/lib/SunStarSys/View.pm
  1260 webgui/lib/SunStarSys/Orion.pm
   112 webgui/lib/SunStarSys/Orion/Cookie.pm
   183 webgui/lib/SunStarSys/Orion/Filter.pm
    90 webgui/lib/SunStarSys/Orion/MapToStorage.pm
    59 webgui/lib/SunStarSys/Orion/WC.pm
   194 webgui/lib/SunStarSys/Orion/WC/Add.pm
    97 webgui/lib/SunStarSys/Orion/WC/Browse.pm
   133 webgui/lib/SunStarSys/Orion/WC/Commit.pm
    79 webgui/lib/SunStarSys/Orion/WC/Copy.pm
    66 webgui/lib/SunStarSys/Orion/WC/Delete.pm
    47 webgui/lib/SunStarSys/Orion/WC/Diff.pm
   182 webgui/lib/SunStarSys/Orion/WC/Edit.pm
   116 webgui/lib/SunStarSys/Orion/WC/Mail.pm
    70 webgui/lib/SunStarSys/Orion/WC/Merge.pm
    67 webgui/lib/SunStarSys/Orion/WC/Move.pm
    52 webgui/lib/SunStarSys/Orion/WC/Production.pm
    47 webgui/lib/SunStarSys/Orion/WC/Promote.pm
    60 webgui/lib/SunStarSys/Orion/WC/Resolve.pm
    64 webgui/lib/SunStarSys/Orion/WC/Revert.pm
    82 webgui/lib/SunStarSys/Orion/WC/Rollback.pm
   123 webgui/lib/SunStarSys/Orion/WC/Search.pm
    78 webgui/lib/SunStarSys/Orion/WC/Staged.pm
    24 webgui/lib/SunStarSys/Orion/WC/Static.pm
    49 webgui/lib/SunStarSys/Orion/WC/Update.pm
   220 webgui/lib/SunStarSys/SVN/Client.pm
  4848 total
```

- [`mod_js`](#) aldrig gjort snittet för httpd v2, mycket mindre gängade mpm.

- Försöker bädda in [`GoLang`](#) i httpd, med infödda version-kontroll bindningar, skulle vara en rolig utmaning; bara inte för mig personligen.  Bra språk med intressanta kompromisser när det gäller dynamisk länkning, men en bestämd kanske för framtida utredning.

- När det gäller byggsystemet Perl 5, håll ögonen öppna!  *Ingen anledning att det inte kan* portas till något annat programmeringsspråk, eftersom byggsystemet är helt isolerat från Orion &trade;'s online IDE (utanför återgivardemon för nedsättning baserad på [`node.js`](#), som är ett fristående system i sig) av en miljon säkerhet / arkitektoniska designskäl.  Om du behöver en teaser om möjligheterna, kika på [`build_external.pl`](#) Skript över i @SunStarSys Orion repo: ASF använde det för alla typer av saker som inte hade något akut behov av ett beroendehanteringssystem.

- Ja, Perls popularitet spårar ironiskt COBOL, eller till och med Common Lisp, trots Unix dominans på servermarknaden; men vissa saker åldras bättre än andra. Den fasta (och unika Perl) [`ithread`](#) Ingenjör utanför [`p5p`](#), som förberedelse för tillkomsten av Perl 7, är välkomna nyheter till mod_perl utvecklare fortfarande klamrar sig fast vid Doug MacEachern ursprungliga vision.  Om du befinner dig knä-djup i 100 + LOC Perl källor för att få vad du behöver ut ur vår nuvarande Perl-bara byggsystem, låt oss chatta &mdash;  Kanske kan vi samarbeta om något mindre komplext som du kan använda för att bygga din webbplats.  Mindre är mer med Perl.

### Varför inte med något baserat på JVM?

- Bara arbetat ut på det sättet, med tanke på min 20-åriga historia med LAMP Stack och konstruktiva bidrag till den utökade Apache HTTPd webbserver gemenskap.  Görbart, men återigen ett massivt åtagande med massor av hårda tekniska problem att lösa längs vägen.

--------

## Index

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
