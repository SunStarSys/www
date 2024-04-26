---
archived: ~
categories: ~
dependencies: '*.md.sv api/index.md.sv'
keywords: Markdown, Asymptote, Sjöjungfru
published: ~
status: skiss
title: Orion-teknik
---

## Solaris 11.4

- DTrace &mdash;

- ZFS &mdash;

- Zoner &mdash;

## node.js v21.6.1

- Eftersom Editor.md är ** fantastiskt**, portade vi den till [`node.js`](#) &mdash;

## Perl v5.38.2

- {# lede #}Nu med mod_perl v2.0.13 w/ ithreads och httpd v2.4.58 w/ händelse mpm.{# lede #}

## Subversion v1.14.4

- anpassad ithread-safe [`SVN::Klient`](#).

- infödda python3 bindningar (v3.8.3).

- gängade python3 portar av svnpubsub och svnwcsub &mdash;

- slutfört python3 [vykort](https://vcs.sunstarsys.com/viewvc/public/site).

------------

## Några anmärkningar på vägarna inte (ännu?) Utförd...

<br/>

### SQL

Vi är en NoSQL butik för hela vår webbplats infrastruktur, och om du är sadlad med en gigantisk enda punkt-of-failure som kallas en RDBMS driver din webbplats tillgångar, vänligen ompröva en mer decentraliserad strategi baserat på #Jamstack och Serverless Technology. Även om det inte är vår. Du kommer att tacka oss senare!

### Varför inte Git?

- Den [`git svn`](#) bro finns redan om du föredrar att arbeta med git själv, istället för att använda online IDE för Orion &trade;. Du har alternativ! Du kan hitta att du får ännu mer körsträcka av GitHub-åtgärder genom att trycka på dina ändringar till GitHub (och linting dem i en GitHub-åtgärd, eller pre-commit hook, eller båda, säg) före [`git svn dcommit`](#)-ing dem till våra Subversion-repos för live-publicering. [Här](https://github.com/SunStarSys/www).

Webbplatskällträd är inte riktigt som programvarukällträd, när det gäller hur du ändrar och hanterar dem.  De är mer anpassade till [devops/stambaserad utveckling](/essays/devops) än med [`gitflöde`](#). Dessutom kommer gigantiska webbplatser att behöva SSI, och kanske lite CGI, för deras användning: åtminstone för att undvika massiva, ogranskbara webbplatschurn från lika massiva engagerade mailare [`skillnad`](#).

Att försöka få en fullt fungerande SSI-implementering av någon lokal "webbserver" som du använder för att förhandsgranska dina ändringar i något annat byggsystem, är bara lite dumt om du stannar och tänker på det.  Med vår Orion skapar du bara en gren i svn och av dig: redigera, bekräfta, bygga, surfa och **iterera**, direkt, på en per-gren, efemär Apache-serverad webbplats som är integrerad i Orion &trade;

- När det är dags att migrera dessa förändringar till den stambaserade produktionsplatsen kan du välja att marknadsföra så mycket, eller så lite, av grenen som du tycker passar, direkt tillbaka till bagageutrymmet.  Om trunk har gått framåt sedan dina grenändringar i slutändan var redo för prime time, klickar du bara på knappen <span class="text-white">Synkronisera</span> för att synkronisera trunk med din gren.  Efter att ha dubbelkontrollerat byggresultaten för din post-sync-merge-bekräftelse till din gren webbplats, gå vidare och klicka på länken <span class="text-white">Marknadsför</span>, följ upp det med en <span class="text-white">Bekräfta</span> på samma sida med ett rimligt bekräftelseloggmeddelande och voilÃ , du sänder nu på bagageutrymmets produktionsbygge.

- Om du behöver distribuera och hantera resulterande byggträd med versionskontroll, kommer du inte att gilla git i stor skala. Speciellt när du integrerar binära artefakter (t.ex. programvaruutgåvor) eller (äldre) produktdokumentation (tänk på doxygen eller javadocs), byggda med det här systemet eller med hjälp av en tredjepartsbyggare som du använder lokalt för att bara ladda upp dessa byggresultat direkt till våra måldatalager. Med vårt tillvägagångssätt kan du undvika onödig röran och svälla i din webbplats källträd, till skillnad från hur det skulle fungera med git, med hjälp av grenar i ett datalager som är gemensamt för både din källa och bygga träd.

- Subversion stöder **finkornig åtkomstkontroll** och låter dig göra partiella/glesa utcheckningar av [`Huvud`](#).

- För IDE skulle vi behöva läs + skriv Perl bindningar för [`libgit2`](#) (som **inte tillhandahålls av det faktiska git utvecklingsteamet**, och till stor del stöds av megalitiska företag som INTE tillhandahåller en online IDE för git som en jämförbar SaaS-produkt; och nej, GitHubär det inte) för att matcha svns httpd-kompatibla minneshanteringssystem och POSIX (+ Perl ithreads) trådsäkerhet, i en beständig exekvering och över flera server-side på disk git-datalager av klientwebbplatsträd.  Mognaden i denna infrastruktur med öppen källkod är inte acceptabel för 2020 i vår uppskattning, men vi kommer att hålla koll på utvecklingen framåt.  Tittar på dig, [`Git::Rå`](#).

- Jag vet fortfarande inte hur man gör ett posix-thread-säkert git porslin.  Trådsäkerhet över separata datalager, men inom en gemensam process RAM, är användningsfallet, inte trådsäkerhet inom ett visst datalager (vilket är en nutty fråga).

### Varför inte Python eller Ruby eller Javascript eller Go?

- [GIL](https://en.wikipedia.org/wiki/Global_interpreter_lock)-tillagd [`mod_python`](#) fortfarande har en väg att gå innan den når mognaden av [`mod_perl`](#) i ett gängat mpm. Dessutom är vår produkts nuvarande implementering tätt integrerad med Apache HTTPd-serverns fullständiga modul-API, som endast [`mod_perl`](#).

- [GIL](https://en.wikipedia.org/wiki/Global_interpreter_lock)-tillagd [`mod_ruby`](#) I stort sett övergavs Ruby-samhället av olika kvalitetskontrollskäl.  Portning av anpassade 5K LOC Perl 5-källor i Orion &trade;

För att vara säker, här är en ögonblicksbild, daterad 19 juli 2020, av SunStar Systems delen av produktionskällträdet för hela Orion (IDE+build).  Det finns inte mycket annat som är inblandat utöver vår [`Dotiac::DTL`](#).

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

- [`mod_js`](#).

- Försöker bädda in [`GoLang`](#).

- När det gäller byggsystemet Perl 5, håll dig uppdaterad!  *Ingen anledning det inte kan * portas till något annat programmeringsspråk, eftersom byggsystemet är helt isolerat från Orion &trade;'s online IDE (utanför markdown renderer-demon baserat på [`node.js`](#), som är ett fristående system i sig) av en miljon säkerhets- / arkitektoniska designskäl.  Om du behöver en teaser om möjligheterna, kika på [`build_external.pl`](#).

- Ja, Perls popularitetsbana spårar ironiskt COBOL, eller till och med Common Lisp, trots Unix dominans på servermarknaden; men vissa saker åldras bättre än andra. Den fasta (och unika Perl) [`ithread`](#) ingenjör från [`p5p`](#), som förberedelse för tillkomsten av Perl 7, är välkomna nyheter till mod_perl utvecklare fortfarande klamrar sig fast vid Doug MacEachern ursprungliga vision.  Om du befinner dig knä-djup i 100 + LOC Perl källor för att få vad du behöver ut ur vårt nuvarande Perl-bara byggsystem, låt oss chatta &mdash;

### Varför inte med något baserat på JVM?

-  Bara arbetat ut så, med tanke på min 20-åriga historia med LAMP Stack och konstruktiva bidrag till den utökade Apache HTTPd webbserver gemenskap.  Doable, men återigen ett massivt företag med massor av hårda tekniska problem att lösa längs vägen.

--------

## Index

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date: 2024-03-29 15:57:18 +0000 (Fri, 29 Mar 2024) $ $Author: joe $ $Revision: 21889 $ -->
