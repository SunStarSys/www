---
acl: '@staff=rw, *=r'
categories: ~
dependencies: '*.md.sv api/index.md.sv'
keywords: säkerhet,infosec,appsec,ipsec,devsecops,it,acl,svnauthz,zerotrust
status: publicerad
title: Orion-säkerhet
---

<div class="right">

![hänglås](security.page/padlock)

</div>

<ul class="nav nav-tabs" role="tablist">
  <li class="nav-item" role="presentation">
    <a class="nav-link" data-bs-toggle="tab" href="#sbom" aria-selected="false" role="tab" tabindex="-1">Perl SBOM</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link active" data-bs-toggle="tab" href="#docs" aria-selected="true" role="tab">Dokumentation</a>
  </li>
</ul>
</div>
<div class="tab-content">
<div class="tab-pane fade active show" id="docs" role="tabpanel">

[TOC]

## {# lede #}"Säkerhet genom dunkelhet är inte mycket säkerhet alls."{# lede #}

Populär parafrasering av amerikansk låssmed [Alfred Charles Hobbs](https://en.wikipedia.org/wiki/Alfred_Charles_Hobbs) 1851, som lätt plockade Crystal Palace lås under en London utställning det året.  Vi instämmer helt och hållet, och det är därför våra kopior av vår OCI-automatiseringsmotor för Oracle Cloud Infrastructure är [tillgänglig på GitHub](https://github.com/joesuf4/home/blob/wsl/.ocirc).

## Orion-infrastruktursäkerhet

```mermaid
flowchart TB
classDef borderless stroke-width:0px
classDef darkBlue fill:#00008B, color:#fff
classDef brightBlue fill:#6082B6, color:#fff
classDef gray fill:#62524F, color:#fff
classDef gray2 fill:#4F625B, color:#fff

subgraph vcs[ ]
    A1[["Fort Lauderdale, FL"]]
    B1[Air-Gapped versionskontrollserver]
end
class vcs,A1 gray

subgraph vpn-us-east[ ]
    A2[["Reston (ort)"]]
    B2[Oracles molninfrastruktur - kantservrar]
end
class vpn-us-east,A2 darkBlue

subgraph vpn-us-west[ ]
    A3[["Phoenix, Arizona, USA"]]
    B3[Oracles molninfrastruktur - kantservrar]
end
class vpn-us-west,A3 darkBlue

subgraph vpn-de-central[ ]
    A4[["Frankfurt, Tyskland"]]
    B4[Oracles molninfrastruktur - kantservrar]
end
class vpn-de-central,A4 darkBlue

subgraph vpn-bz-west[ ]
    A5[["São Paolo (ort)"]]
    B5[Oracles molninfrastruktur - kantservrar]
end
class vpn-bz-west,A5 darkBlue

subgraph vpn-au-west[ ]
    A6[["Sydney, Australien"]]
    B6[Oracles molninfrastruktur - kantservrar]
end
class vpn-au-west,A6 darkBlue

subgraph vpn-ap-west[ ]
    A7[["Hyderabad (ort)"]]
	B7[Oracles molninfrastruktur - kantservrar]
end
class vpn-ap-west,A7 darkBlue

subgraph vpn-ap-east[ ]
    A8[["Seoul, Sydkorea"]]
    B8[Oracles molninfrastruktur - kantservrar]
end
class vpn-ap-east,A8 darkBlue

class A1,A2,A3,A4,A5,A6,A7,A8 borderless

vcs==VPN==>A2==SSH/vpn==>B2
vcs==VPN==>A3==SSH/vpn==>B3
vcs==VPN==>A4==SSH/vpn==>B4
vcs==VPN==>A5==SSH/vpn==>B5
vcs==VPN==>A6==SSH/vpn==>B6
vcs==VPN==>A7==SSH/vpn==>B7
vcs==VPN==>A8==SSH/vpn==>B8
```
&nbsp;

FIPS 140-3-kompatibel med MFA-trippelkryptering för tjänster som körs bakåt i porten (HTTPS/SSH/IPsec).  Bälte, hängslen och stigbyglar!

----

&nbsp;

### [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control) modell, pepprad med [brunst](https://github.com/SunStarSys/orthrus) Engångslösenord/TOTP-utmaningar

All inloggningsåtkomst till infrastrukturkonto kräver flerfaktorautentisering, inklusive OCI-konton. Det finns inga bakdörrar till denna policy, genom design.

Alla anställdas SSH-åtkomst till företagsmaskiner kräver YubiKey PKI-integrering med privata nycklar för auktorisering av ECDSA-SHA-2-NISTP-256 som lagras i PKCS11-platser på Yubikey eller direkt integrering av smartkort med ED25519-sk-nycklar.

Inga fasta lösenord lagrade på diskar. Denna *begränsar* huvudlös automatisering av sudo / RBAC-användning, av goda skäl.  Men vi har [verktyg](https://github.com/SunStarSys/pty) för att eliminera slit att svara på frågor av olika slag.

### Sandboxad körning för byggen och CGI-skript

Vi distribuerar "Delad-ingenting" zonbyggen, standardinställs på noll nätverkstillgänglighet. Det betyder att de enda saker som en kund kan komma åt eller ändra är deras egna tillgångar, inte de som någon annan kund, eller några andra systemvägar i själva zonen (förutom `/tmp`. Dessutom är det bara företagskunder och företagskunder som har tillgång till internet under sina byggen, eftersom de använder sina egna *unika* Solaris-zoner som kan skräddarsys exakt efter sina byggkrav.

Dito för CGI-skript, som är helt låsta när det gäller skrivåtkomst till något annat än `/tmp`.

### Kryptering från början till slut

- OpenSSL v4+ TLS 1.3 (+FS) AES(256) SHA(256) för HTTPS FIPS 140-3-anslutningar

- OpenSSH v10+ ED25519 FIPS 140-3 med Post-Quantum KexAlgorithm / NIST-kompatibla nycklar för flera värdar `lo` spola bakåt i tiden

- IPsec/IKEv2/PFS AES(256) FIPS 140-2 för gränsöverskridande VPN

- AES(256) för ZFS-kryptering

### Zero Trust-aspekter

Den grundläggande förutsättningen för [arkitektur med nolltillit](https://csrc.nist.gov/publications/detail/sp/800-207/final) Det är för att undvika att utforma din nätverkssäkerhet kring musslans fysiologi: hårt på utsidan, men mjukt och löst när du är i.  Så vi gör inte det; varje meningsfull privilegierad nätverksport inuti de olika POP-LAN-nätverken (Point of Presence) exponeras bara för maskinens loopback-enhetsgränssnitt. `lo0`, och är endast meningsfull i samband med att en (omvänd) port vidarebefordrar SSH-anslutning *till den*.

Vi använder TCP-proxyer, inte HTTP-proxyer och inga MSA-serverdelar **så den enda värd som ser din okrypterade TLS-webbtrafik är den värd som dekrypterar den**. Samma regler gäller för omställningstrafik &mdash; Endast direkt, end-to-end TLS-krypterad trafik till **tjänstslutpunkten** ser dina okrypterade data på kabeln.

Lycka till med **MSA-lagren och lagren av privat dataexponering** med andra leverantörer. Fienden till "icke-funktionell teknik" är komplexitet. Det är mycket lättare att ge meningsfulla säkerhetslöften när din produkt är en **förenad monolit istället för ett massivt MSA-minfält**, vilket är en annan motsvarighet mellan Orion och dess konkurrentfält.

Denna infra är helt automatiserad när en region tas online, men det är allt vi kan dela offentligt om arkitekturen (balansera Hobbsian öppenhet med det militära mantrat) "lösa läppar sjunka fartyg" är mer konst än vetenskap).  Var säker &mdash; Bortom att bryta antispoofing `lo0` skydd inom själva Solaris 11s (BSD) paketfilter, det finns inga meningsfulla sätt att få tillgång till dessa tjänster, även för kundkonton.

Även om huvudkontot för OCI-kontroll har äventyrats är **sekretess** och **integritet** för alla kundtillgångar okränkbara.  Allt en svart hatt kan göra är att göra en röra med kundens webbplats **tillgänglighet**. Framför allt har de inte åtkomst till posterna med Subversion-tjänstdata.  Vi kan rekonstruera hela OCI-infrastrukturen från grunden på 48-72 timmar när det dåliga äpplets OCI-åtkomst har avslutats.

-----

### Loggning, övervakning och granskning

Vi uppmuntrar Enterprise-kunder att skapa ett Splunk-konto och vi kommer att leverera webbloggar i nära realtid till ditt konto från varje global POP du behöver.  Felloggar för CGI-skript på serversidan görs också tillgängliga för Splunk.

Vi övervakar tjänstens tillgänglighet från alla våra OCI POP:er över hela världen och utlöser HA (Tillgänglighetsdomän), eller regionala felöverlämningshändelser om ett serveravbrott varar i mer än 30 sekunder.

ACL-granskning kan utföras genom att helt enkelt bygga en webbplats Subversion HEAD med hjälp av Apache Licensed [Orion SSG](https://github.com/SunStarSys/orion/blob/master/test.sh) skript och undersöka den resulterande versionen till `www/.acl` fil i din arbetskatalog, när du vill.  Normalt tar byggprocessen mindre än 10-15 sekunder på modern hårdvara.

Subversion Server-Side Commit Hooks är också anpassningsbara för dina tillsynsproblem. Från ett enkelt bekräftelsemeddelande till säker åtkomst till vår svnpubsub-demon finns det valfritt antal anpassade konfigurationer tillgängliga.

-----

## Orion-applikationssäkerhet

### [SSR är en lukt](https://queue.acm.org/detail.cfm?id=2721993)

#### Separation av Concens och Engineering Tradeoffs

I ett nötskal är hur alla andra wiki-plattformar fungerar som en SQL [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) app som gör det snabbt och enkelt att ändra innehåll, för vilket resultaten måste rekonstrueras i realtid (eller från en webbsidescache) varje gång någon behöver visa det innehållet online.

I (noSQL) Orion tar vi redigering och rendering som två separata problem som ska hanteras av två oberoende programvarustackar; där mycket mer process, design, validering och beroendehantering investeras i redigeringsgränssnittet. Detta är så att vi kan begränsa programvaran på renderingsstacken till att vara en barebones SSI-aktiverad Apache-filserver med bog-standard webbautentisering och åtkomstkontroller inblandade, och optimistiskt förväntar vi oss att innehållet ses en storleksordning oftare än den redigerades.

Följaktligen är redigeringsupplevelsen lite mindre snabb och mycket mindre smutsig, eftersom vi validerar och bygger det modifierade innehållet, tillsammans med korpus av beroende sidor, *vid redigeringstid, inte vid renderingstid *.

I själva verket är kostnaden några sekunder mer av exponering för byggmaskineriet innan man kan se publicerade förändringar på den levande webbplatsen.
Och förmånen? Du kommer **aldrig se din webbplats bli hackad igen** genom nolldagssårbarheter i den renderande webbserverns programvarustack.

### Hantering av åtkomstkontrollista

```graphviz
digraph {
"@path::acl" -> "authz-svn.conf" [label="svn"];
"@path::acl" -> "/**/.htaccess" [label="httpd"];
};
```

&nbsp;

Orions säkerhetsmodell styrs centralt av inställningarna i [`@path::acl`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/acl.yml) som konstueras i [`lib/path.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm). Konfigurationsfiler för offshoot-servrar genereras dynamiskt vid varje skapad ändring.

Om du förstår säkerhetsmodellen för POSIX-filsystemet kommer du att vara hemma hos Orion [`mod_dav_svn`](https://svnbook.red-bean.com/en/1.7/svn.ref.mod_dav_svn.conf.html) behörighetsmodell och Apache HTTPd-webbserverns .htaccess-kontroller, som genereras automatiskt från webbplatsens `lib/acl.yml` YAML-konfiguration.

### OpenIDC Säkerhet för enkel inloggning

Alla OpenID-sessionscookies är HttpOnly och Secure-flaggade, så javascript-sessionsstöldförsök neutraliseras effektivt av Orion Online Editor.

All lagring av cookie-inloggningsuppgifter är dessutom AES-256 krypterad under en HMAC SHA-1 hash.

### Bcrypt för Subversion-lösenord

Justerbart antal rundor (för närvarande är standardvärdet 5).

### Målade dataskydd

Alla våra Perl-körtider har obligatoriska taint-kontroller aktiverade med -T-flaggan; ett kraftfullt, unikt Perl-skydd mot [Utnyttjande av fjärrskal](https://github.blog/security/securing-the-git-push-pipeline-responding-to-a-critical-remote-code-execution-vulnerability/).

### Wiki-problem

Wiki security involves several factors:

1. Gränssnitts-/API-säkerhet

2. Säkerhet för mellanprogramvara/serverdel

3. Traversskydd för mall

4. ACL-kompatibilitet för sökmotor

Vi gräver i dessa frågor som de relaterar till Orion nedan.

#### Onlineredigerare

Online-redigeraren stöder ett JSON-gränssnitt genom att helt enkelt ställa in användaragentens Accept-rubrik för att föredra `application/json` MIME-typ, så säkerhetskontrollerna är samma för både användargränssnittet och API:t.

**Det finns inget administrativt användargränssnitt/API** utanför direkt Subversion-åtkomst.

##### Subversion-åtkomstlistor styr läsbehörighet för arbetskopia på serversidan

Alla resurser för arbetskopiering som är tillgängliga via användargränssnittet är korskontrollerade mot dina åtkomstkontrollistor för Subversion innan de visas för användaren.  På så sätt ser vi till att läsåtkomst till obehöriga resurser förhindras för tillgångarna under versionskontroll (dvs. **allt**).

##### Bekräftelseåtkomst kontrolleras direkt med Subversion-åtkomstkontrollistor

Ingenting kan skapas och sedan visas över nätverket utan en motsvarande auktoriserad Subversion-bekräftelse. Huvudfrågan här är att kontrollera vilken information som är tillgänglig för en wikisidans författares engagerade och byggda redigeringar.

Om du tillåter mallförbearbetning på källsidorna för nedsättning måste du vara medveten om hur mallargument gör innehållet i andra filer i trädet tillgängligt som variabler för källan till den redigerade sidan.

Ofta, om det är konfigurerat att göra det, kan den redigerade sidan deklarera sina egna beroendefiler i sidans rubriker, vilket också är något att tänka på när du väger funktionsuppsättningar mot säkerhetskontroller i din Wikis informationsarkitektur. Oavsett din inställning säkrar vi din webbplats som standard &mdash; inklusive innehållsberoenden och `ssi` innehåller.

Medan vi kan erbjuda vägledning och stöd för att matcha dina behov, är det verkligen upp till dig att bestämma hur du ska balansera skalorna för din organisations förvaltade tillgångar i en Orion-stödd wiki.

Se avsnittet nedan på [Beroende-/ACL-injektionskontroller](#h4-dependency-acl-injection-controls) för mer information, och kolla in detta live-exempel på hur enkla åtkomstlistor kan konfigureras centralt i [`lib/acl.yml`]({{snippetA.pretty_uri}}):

[snippet:repo=SunStarSys/www:path=lib/acl.yml:branch=trunk:token=#acl:lang=yaml]

Innehållsredigerare kan konfigurera sidbegränsningar i sidans [rubriker]({{snippetB.pretty_uri}}):

[snippet:repo=SunStarSys/www:path=content/orion/security.md.en:branch=trunk:lines=1,4:lang=yaml]

Som en sidoanteckning kan skyddade resurser inte kopieras till en gren av obehörig personal, även utan att lägga till ytterligare åtkomstkontrollistorskontroller för att skapa och ändra grenar. Med andra ord kommer systemet att stödja filialexperimentering utan ytterligare kontroller från din sida för att säkerställa att skyddade tillgångar förblir skyddade under varje branschs naturliga livscykel.

#### Vill du skapa systemåtkomstlistor?

Byggsystemet är allseende och allvetande, men vi kan se till att dina byggda, skyddade tillgångar bara är synliga för de team du hanterar och kontrollerar i Subversion ACLs.

Byggsystemet visar listan över filnamn som byggts via webbläsarens IDE vid en bekräftelse, men den listan baseras bara på en användares läsbehörighet till resurserna som är beroende av användarens åtgärder för att lägga till, uppdatera eller ta bort innehåll i bekräftelsen.

##### Mallkontroller för traversering

Se [sanitize_relative_path]({{snippetC.pretty_uri}}):

[snippet:repo=SunStarSys/orion:path=lib/SunStarSys/Util.pm:token=#ttc:lang=perl]

Koden tillämpar de regler som följer nedan i det här avsnittet.

###### inkluderar och utökar taggar

Alla målfiler finns i en undermapp i `/templates/` och måste refereras som absoluta sökvägar som är rotade i den mappen.

###### ssi-tagg

Alla målfiler finns i en undermapp i `/content/` och måste refereras som absoluta sökvägar som är rotade i den mappen.

Om målsökvägen inte har konfigurerats i `@path::patterns` med en matchande inställning som gör att målsökvägen i fråga antingen kan arkiveras eller kategoriseras, eller så är den senast ändrade författaren av källfilen helt enkelt inte behörig att visa målsökvägen, `ssi` Åtgärden kommer att misslyckas.

Detta beror på att `ssi` support är en förutsättning för dessa funktionsuppsättningar, för att bevara webbplatsens mål *permalinks*.

#### Beroende-/ACL-injektionskontroller

Kontrollerad av `lib/path.pm` import.

##### lib/{sökväg,visa}.pm Subversion ACL:er

Det är klokt att kontrollera skrivåtkomst till dessa resurser, genom att begränsa dem till personer som både är kompetenta i kodbasen och auktoriserade att genomföra säkerhetskontroller för hela uppsättningen av tillgångar under versionskontroll (aka *allt *).

Det är också en bra idé att inkludera `@svnadmin` gruppera bland dem med läs- och skrivbehörighet, men det är inte absolut nödvändigt även om du behöver att vi manuellt återställer dina Subversion-åtkomstlistor.

##### Dynamiskt genererade regler via &#64;sökväg::acl

Byggsystemet noterar din `lib/path.pm` import av antingen (eller båda) av seed_file_deps() och seed_file_acl(), och föra detta val framåt i sin interna bearbetning av Subversion commit-ändringar som ger upphov till en inkrementell bygge.

##### Migreringsspårning för kontrollerat innehåll

När du visar användarnas fullständiga versionskontrollhistorik måste du se till att auktoriseringskontrollerna bevaras på det kontrollerade materialets ursprungliga plats.

Annars kan materialet **oavsiktligt utsättas för en historisk forskare utan nödvändiga tillstånd**.

Orions CMS-spårningslogik för förflyttning/borttagning hanterar detta sömlöst.

##### Anpassade kontroller för användning av seed_file_deps() och seed_file_acl() i lib/path.pm

Bortom importen av dessa symboler till `lib/path.pm`, det finns också ett val i hur, och vilka filer du vill tillämpa dem på, under en körning av kodblocket walk_content_tree ().  När allt kommer omkring är det inte bara en konfigurationsfil, men en kodbas, med alla Turing fullständiga funktioner i `Perl` Vi har lärt känna och uppskattar!

#### Byggda .htaccess-filer för webbplats och Subversion-auktoriseringsfiler synkroniseras med `@path::acl` Omedelbart efter bekräftelse

Automatiskt åtkomstkontrollista-skydd för efemära grenbyggen. Ingen ytterligare konfiguration krävs.

#### Inbyggda kontroller för sökmotorn i PCRE

Same situation as the general-purpose UI: den korsar kontroller mot Subversion-servern från användargränssnittet.

På den aktiva webbplatsen gör sökmotorn exakt samma sak när du aktiverar sökningar med nedsättningar (källträd). Annars kommer det att köra httpd-delbegäranden till din aktiva webbplats för att testa om användaren har behörighet att komma åt den aktiva filen (förutsatt att du har lösenordsskyddad din sökmotor så att den har användardata att arbeta med).

### Policyer för innehållssäkerhet

- [x] Analysbegränsningar

Googla och/eller LinkedIn.

- [x] Databegränsningar

Data måste levereras från våra servrar.

- [x] Innehållsbegränsningar

Innehållet måste levereras från våra servrar.

- [x] Kodbegränsningar

Javascript-koden måste levereras från våra servrar.

- [x] Formatbegränsningar

CSS måste levereras från våra servrar.

- [x] Begränsningar för insticksprogram

För närvarande endast PDF.

### Cross-Origin resursdelning

- [x] Alla användare med ett konto kan använda användargränssnitt/API:er från andra håll med sina inloggningsuppgifter.

- [x] Företagskunder kan behandla Orion som en [Huvudlös CMS](https://aws.amazon.com/what-is/headless-cms/) om de vill bygga sitt eget användargränssnitt från [JSON Subversion Porslin](api/editor) eller [JSON Sök](api/search) API:er.

### Beroenden för tredje part

Anmärkningsvärt korta och beprövade beroenden; de viktigaste komponenterna omfattas av [Orionteknik](technology) sida.

#### Fullständiga stycklistor för programvara (SBOM) tillgängliga på begäran

[Kontakta oss](/contact) för mer information.

</div>
<div class="tab-pane fade" id="sbom" role="tabpanel">
{{sbom.content|safe}}
</div>
</div>

--------

## Index

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date$ $Author$ $Revision$ -->
