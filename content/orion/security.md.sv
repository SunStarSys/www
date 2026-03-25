---
acl: '@staff=rw, *=r, joe=rw'
archived: ~
categories: ~
dependencies: '*.md.sv api/index.md.sv'
keywords: säkerhet,infosec,appsec,ipsec,devsecops,it,acl,svnauthz,zerotrust
published: ~
status: publicerad
title: Orion-säkerhet
---

<div class="right">

![hänglås](security.page/padlock).

</div>

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
    A1[[Fort Lauderdale, FL]]
    B1[Air-Gapped Version Control Server]
end
class vcs,A1 gray

subgraph vpn-us-east[ ]
    A2[[Reston, VA]]
    B2[OCI Edge Servers]
end
class vpn-us-east,A2 darkBlue

subgraph vpn-us-west[ ]
    A3[[Phoenix, AZ]]
    B3[OCI Edge Servers]
end
class vpn-us-west,A3 darkBlue

subgraph vpn-de-central[ ]
    A4[[Frankfurt, Germany]]
    B4[OCI Edge Servers]
end
class vpn-de-central,A4 darkBlue

subgraph vpn-bz-west[ ]
    A5[[São Paolo, Brazil]]
    B5[OCI Edge Servers]
end
class vpn-bz-west,A5 darkBlue

subgraph vpn-au-west[ ]
    A6[[Sydney, Australia]]
    B6[OCI Edge Servers]
end
class vpn-au-west,A6 darkBlue

subgraph vpn-ap-west[ ]
    A7[[Hyderabad, India]]
	B7[OCI Edge Servers]
end
class vpn-ap-west,A7 darkBlue

subgraph vpn-ap-east[ ]
    A8[[Seoul, South Korea]]
    B8[OCI Edge Servers]
end
class vpn-ap-east,A8 darkBlue

class A1,A2,A3,A4,A5,A6,A7,A8 borderless

vcs==vpn==>A2==ssh/vpn==>B2
vcs==vpn==>A3==ssh/vpn==>B3
vcs==vpn==>A4==ssh/vpn==>B4
vcs==vpn==>A5==ssh/vpn==>B5
vcs==vpn==>A6==ssh/vpn==>B6
vcs==vpn==>A7==ssh/vpn==>B7
vcs==vpn==>A8==ssh/vpn==>B8
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

Vi distribuerar "Delad-ingenting" zonbyggen, standardinställs på noll nätverkstillgänglighet. Det betyder att de enda saker som en kund kan komma åt eller ändra är deras egna tillgångar, inte de som någon annan kund, eller några andra systemvägar i själva zonen (förutom [`/tmp`](#)).  Dessutom är det bara företagskunder och företagskunder som har tillgång till internet under sina byggen, eftersom de använder sina egna *unika* Solaris-zoner som kan skräddarsys exakt efter sina byggkrav.

Dito för CGI-skript, som är helt låsta när det gäller skrivåtkomst till något annat än [`/tmp`](#).

### Kryptering från början till slut

- TLS 1.3 (+FS) AES(256) SHA(256) för HTTPS FIPS 140-3-anslutningar

- SSHv2 ED25519 FIPS 140-3 / NIST-kompatibla nycklar för flera värdar [`toalettstol`](#) spola bakåt i tiden

- IPsec/IKEv2/PFS AES(256) för regionövergripande VPN

- AES(256) för ZFS-kryptering

### Zero Trust-aspekter

Den grundläggande förutsättningen för [arkitektur med nolltillit](https://csrc.nist.gov/publications/detail/sp/800-207/final) Det är för att undvika att utforma din nätverkssäkerhet kring musslans fysiologi: hårt på utsidan, men mjukt och löst när du är i.  Så gör vi'Alla meningsfulla privilegierade nätverksportar i de olika POP-LAN-nätverken (Point of Presence) exponeras endast för en maskin utan metall.'s loopback-enhetens gränssnitt [`lo0`](#), och är endast meningsfull i samband med att en (omvänd) port vidarebefordrar SSH-anslutning *till den*.

Vi använder TCP-proxyer, inte HTTP-proxyer och inga MSA-serverdelar **så den enda värd som ser din okrypterade TLS-webbtrafik är den värd som dekrypterar den**. Samma regler gäller för omställningstrafik &mdash; Endast direkt, end-to-end TLS-krypterad trafik till **tjänstslutpunkten** ser dina okrypterade data på kabeln.

Lycka till med **MSA-lagren och lagren av privat dataexponering** med andra leverantörer. Fienden till "icke-funktionell teknik" är komplexitet. Det är mycket lättare att ge meningsfulla säkerhetslöften när din produkt är en **förenad monolit istället för ett massivt MSA-minfält**, vilket är en annan motsvarighet mellan Orion och dess konkurrentfält.

Denna infra är helt automatiserad när en region tas online, men det's allt vi kan dela offentligt om arkitekturen (balansera Hobbsian öppenhet med militära mantra "lösa läppar sjunka fartyg" är mer konst än vetenskap).  Var säker &mdash; Bortom att bryta antispoofing [`lo0`](#) skydd inom Solaris 11's (BSD) paketfilter själv, det finns inga meningsfulla sätt att få tillgång till dessa tjänster, även för kundkonton.

Även om huvudkontot för OCI-kontroll har äventyrats är **sekretess** och **integritet** för alla kundtillgångar okränkbara.  Allt en svart hatt kan göra är att göra en röra med kundens webbplats **tillgänglighet**. Framför allt har de inte åtkomst till posterna med Subversion-tjänstdata.  Vi kan rekonstruera hela OCI-infrastrukturen från grunden på 48–72 timmar när det dåliga äpplet'OCI-åtkomsten har avslutats.

-----

### Loggning, övervakning och granskning

Vi uppmuntrar Enterprise-kunder att skapa ett Splunk-konto och vi kommer att leverera webbloggar i nära realtid till ditt konto från varje global POP du behöver.  Felloggar för CGI-skript på serversidan görs också tillgängliga för Splunk.

Vi övervakar tjänstens tillgänglighet från alla våra OCI POP:er över hela världen och utlöser HA (Tillgänglighetsdomän), eller regionala felöverlämningshändelser om ett serveravbrott varar i mer än 30 sekunder.

ACL-granskning kan utföras genom att helt enkelt bygga en webbplats's Subversion HEAD med Apache Licensierad [Orion SSG](https://github.com/SunStarSys/orion/blob/master/test.sh) skript och undersöka den resulterande versionen till [`www/.acl`](#) fil i din arbetskatalog, när du vill.  Normalt tar byggprocessen mindre än 10-15 sekunder på modern hårdvara.

Subversion Server-Side Commit Hooks är också anpassningsbara för dina tillsynsproblem. Från ett enkelt bekräftelsemeddelande till säker åtkomst till vår svnpubsub-demon finns det valfritt antal anpassade konfigurationer tillgängliga.

-----

## Orion-applikationssäkerhet

### [SSR är en lukt](https://queue.acm.org/detail.cfm?id=2721993).

### Hantering av åtkomstkontrollista

```graphviz
digraph {
"@path::acl" -> "authz-svn.conf" [label="svn"];
"@path::acl" -> "/**/.htaccess" [label="httpd"];
};
```

&nbsp;

Orion's säkerhetsmodell hanteras centralt av inställningarna i [`@path::acl`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/acl.yml) som konstueras i [`lib/path.pm`](https://github.com/SunStarSys/www.iconoclasts.blog/blob/trunk/lib/path.pm). Konfigurationsfiler för offshoot-servrar genereras dynamiskt vid varje skapad ändring.

Om du förstår säkerhetsmodellen för POSIX-filsystemet kommer du att vara hemma hos Orion's [mod_dav_svn]() behörighetsmodell och Apache HTTPd-webbservern's .htaccess-kontroller som genereras automatiskt från din webbplats's [lib/acl.yml](#) YAML-konfiguration.

### OpenIDC Säkerhet för enkel inloggning

Alla OpenID-sessionscookies är HttpOnly och Secure-flaggade, så javascript-sessionsstöldförsök neutraliseras effektivt av Orion Online Editor.

All lagring av cookie-inloggningsuppgifter är dessutom AES-256 krypterad under en HMAC SHA-1 hash.

### Bcrypt för Subversion-lösenord

Justerbart antal rundor (för närvarande är standardvärdet 5).

### Målade dataskydd

Alla våra Perl-körningar har obligatoriska taint-kontroller aktiverade med -T-flaggan; ett kraftfullt, unikt Perl-skydd mot Remote Shell Exploits.

### Wiki-problem

Wikisäkerhet innefattar flera faktorer:

1. Gränssnitts-/API-säkerhet

2. Säkerhet för mellanprogramvara/serverdel

3. Traversskydd för mall

4. ACL-kompatibilitet för sökmotor

Vi gräver i dessa frågor som de relaterar till Orion nedan.

#### Onlineredigerare

Online-redigeraren stöder ett JSON-gränssnitt genom att helt enkelt ställa in din användaragent's Acceptera huvudet för att föredra [`applikation/json`](#) MIME-typ, så säkerhetskontrollerna är samma för både användargränssnittet och API:t.

**Det finns inget administrativt användargränssnitt/API** utanför direkt Subversion-åtkomst.

##### Subversion-åtkomstlistor styr läsbehörighet för arbetskopia på serversidan

Alla resurser för arbetskopiering som är tillgängliga via användargränssnittet är korskontrollerade mot dina åtkomstkontrollistor för Subversion innan de visas för användaren.  På så sätt ser vi till att läsåtkomst till obehöriga resurser förhindras för tillgångarna under versionskontroll (dvs. **allt**).

##### Bekräftelseåtkomst kontrolleras direkt med Subversion-åtkomstkontrollistor

Ingenting kan skapas och sedan visas över nätverket utan en motsvarande auktoriserad Subversion-bekräftelse. Huvudfrågan här är att kontrollera vilken information som är tillgänglig för en wiki-sidförfattare's bekräftade och skapade redigeringar.

Om du tillåter mallförbearbetning på källsidorna för nedsättning måste du vara medveten om hur mallargument gör innehållet i andra filer i trädet tillgängligt som variabler för källan till den redigerade sidan.

Ofta, om det är konfigurerat för att göra det, kan den redigerade sidan deklarera sina egna beroendefiler i sidhuvuden, vilket är något att tänka när du väger funktionsuppsättningar mot säkerhetskontroller i din Wiki's Informationsarkitektur.

Även om vi kan erbjuda vägledning och stöd för att matcha dina behov, det'är verkligen upp till dig att bestämma hur du ska balansera skalorna för din organisation'wiki för företag.

Se avsnittet nedan på [Beroende-/ACL-injektionskontroller](#h4-dependency-acl-injection-controls) för mer information, och kolla in detta levande exempel på hur lätt ACL's kan konfigureras centralt i [`lib/acl.yml`]({{snippetA.pretty_uri}}):

[snippet:repo=SunStarSys/www:path=lib/acl.yml:branch=trunk:token=#acl:lang=yaml]

Innehållsredigerare kan konfigurera sidbegränsningar på sidan's [rubriker]({{snippetB.pretty_uri}}):

[snippet:repo=SunStarSys/www:path=content/orion/security.md.en:branch=trunk:lines=1,4:lang=yaml]

Som en sidoanteckning kan skyddade resurser inte kopieras till en gren av obehörig personal, även utan att lägga till ytterligare åtkomstkontrollistorskontroller för att skapa och ändra grenar. Med andra ord kommer systemet att stödja experiment med filialer utan ytterligare kontroller från din sida för att säkerställa att skyddade tillgångar förblir skyddade i varje filial.'naturlig livscykel.

#### Vill du skapa systemåtkomstlistor?

Byggsystemet är allseende och allvetande, men vi kan se till att dina byggda, skyddade tillgångar bara är synliga för de team du hanterar och kontrollerar i Subversion ACLs.

Byggsystemet visar listan över filnamn som byggts genom webbläsaren IDE vid en bekräftelse, men den listan är endast baserad på en användare's läsåtkomst till resurserna som är beroende av användaren'lägga till, uppdatera eller ta bort innehållsåtgärder i bekräftelsen.

##### Mallkontroller för traversering

Se [sanitize_relative_path]({{snippetC.pretty_uri}}):

[snippet:repo=SunStarSys/orion:path=lib/SunStarSys/Util.pm:token=#ttc:lang=perl]

Koden tillämpar de regler som följer nedan i det här avsnittet.

###### inkluderar och utökar taggar

Alla målfiler finns i en undermapp i [`/Mallar/`](#) och måste refereras som absoluta sökvägar som är rotade i den mappen.

###### ssi-tagg

Alla målfiler finns i en undermapp i [`/innehåll/`](#) och måste refereras som absoluta sökvägar som är rotade i den mappen.

Om målsökvägen inte har konfigurerats i [`@path::mönster`](#) med en matchande inställning som gör att målsökvägen i fråga antingen kan arkiveras eller kategoriseras, [`ssi`](#) Åtgärden kommer att misslyckas.

Detta beror på att [`ssi`](#) support är en förutsättning för dessa funktionsuppsättningar, för att bevara din webbplats's taget *permalinks*.

#### Beroende-/ACL-injektionskontroller

Kontrollerad av [`lib/path.pm`](#) import.

##### lib/{sökväg,visa}.pm Subversion ACL:er

Det'är klokt att kontrollera skrivåtkomst till dessa resurser, genom att begränsa dem till personer som är både kompetenta i kodbasen och behöriga att genomföra säkerhetskontroller för hela uppsättningen av tillgångar under versionskontroll (aka *allt *).

Det är också en bra idé att inkludera [`@svnadmin`](#) grupp bland dem med läs- och skrivbehörighet, men det'är inte absolut nödvändigt även om du behöver att vi manuellt återställer dina Subversion ACLs.

##### Dynamiskt genererade regler via &#64;sökväg::acl

Byggsystemet noterar din [`lib/path.pm`](#) import av antingen (eller båda) av seed_file_deps() och seed_file_acl(), och föra detta val framåt i sin interna bearbetning av Subversion commit-ändringar som ger upphov till en inkrementell bygge.

##### Migreringsspårning för kontrollerat innehåll

När du visar användarnas fullständiga versionskontrollhistorik måste du se till att auktoriseringskontrollerna bevaras på det kontrollerade materialets ursprungliga plats.

Annars kan materialet **oavsiktligt utsättas för en historisk forskare utan nödvändiga tillstånd**.

och Orion CMS's flytta spårningslogik hanterar detta sömlöst.

##### Anpassade kontroller för användning av seed_file_deps() och seed_file_acl() i lib/path.pm

Bortom importen av dessa symboler till [`lib/path.pm`](#), det finns också ett val i hur, och vilka filer du vill tillämpa dem på, under en körning av kodblocket walk_content_tree ().  När allt kommer omkring är det's inte bara en konfigurationsfil, utan en kodbas, med alla Turing fullständiga funktioner i [`Perl`](#) vi'Kom och lär känna och uppskatta!

#### Byggda .htaccss-filer för webbplats och Subversion-auktoriseringsfiler synkroniseras med &#64;Sökväg::avsluta direkt vid bekräftelse

Automatiskt åtkomstkontrollista-skydd för efemära grenbyggen. Ingen ytterligare konfiguration krävs.

#### Inbyggda kontroller för sökmotorn i PCRE

Samma situation som det allmänna användargränssnittet: det korsar kontroller mot Subversion-servern från användargränssnittet.

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

För närvarande PDF'Endast s.

### Cross-Origin resursdelning

- [x] Alla användare med ett konto kan använda användargränssnitt/API:er från andra håll med sina inloggningsuppgifter.

- [x] Företagskunder kan behandla Orion som en [Huvudlös CMS](https://aws.amazon.com/what-is/headless-cms/) om de vill bygga sitt eget användargränssnitt från [JSON Subversion Porslin](api/editor) eller [JSON Sök](api/search) API:er.

### Beroenden för tredje part

Anmärkningsvärt korta och beprövade beroenden; de viktigaste komponenterna omfattas av [Orionteknik](technology) sida.

#### Stycklista för programvara tillgänglig på begäran

[Kontakta oss](/contact) för mer information.

--------

## Index

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date: 2026-03-24 15:50:49 -0700 (Tue, 24 Mar 2026) $ $Author: joe $ $Revision: 30030 $ -->
