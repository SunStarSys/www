---
acl: '@staff=rw, *=r'
archived: ~
categories: ~
dependencies: '*.md.sv api/index.md.sv'
keywords: security,infosec,appsec,ipsec,devsecops,it,acl,svnauthz
published: ~
status: publicerad
title: Orion Security
---

[TOC]

## {# lede #}"Säkerhet genom dunkel är inte mycket säkerhet alls."{# lede #}

Populär parafrasering av amerikansk låssmed [Alfred Charles Hobbs](https://en.wikipedia.org/wiki/Alfred_Charles_Hobbs) 1851, som lätt plockade Crystal Palace lås under en London-utställning det året.  Vi håller helt med, och därför är våra kopior för vår automatiseringsmotor för Oracle Cloud Infrastructure (OCI) [finns på GitHub](https://github.com/joesuf4/home/blob/wsl/.ocirc).

## Infrastruktursäkerhet för Orion

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

FIPS 140-2-kompatibel med trippelkryptering för tjänster med bakåtporterad port (HTTPS/SSH/IPsec).  Bälte, hängslen och stigbyglar!

----

&nbsp;

### Passwordless [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control) modell, pepprad med [ortrus](https://github.com/SunStarSys/orthrus) [otp-sha1](https://en.wikipedia.org/wiki/One-time_password).

Inga fasta lösenord lagrade på servrar. Detta *begränsar * huvudlös automatisering av sudo / RBAC-användning, av goda skäl.  Men vi har [verktyg](https://github.com/SunStarSys/pty).

### Sandboxad körning för byggen och CGI-skript

Vi distribuerar zonbyggen med "delat-inget" som standard är noll nätverkstillgänglighet. Det betyder att det enda som en kunds bygge kan komma åt eller ändra är sina egna tillgångar, inte de som någon annan kund har eller andra systemvägar i själva zonen (förutom [`/tmp`](#).

Ditto för CGI-skript, som är helt låsta när det gäller skrivåtkomst till något annat än [`/tmp`](#).

### Kryptering från början till slut

- TLS 1.3 (+FS) AES(256) SHA(256) för HTTPS FIPS 140-3-anslutningar

- SSHv2 ED25519 FIPS 140-3 / NIST-kompatibla nycklar för korsvärd [`toalettstol`](#).

- IPsec/IKEv2/PFS AES(256) för gränsöverskridande VPN

- AES(256) för ZFS-kryptering

### Nolltillit

Den grundläggande förutsättningen för [arkitektur med noll förtroende](https://csrc.nist.gov/publications/detail/sp/800-207/final) är att undvika att utforma din nätverkssäkerhet kring musslans fysiologi: hårt på utsidan, men mjukt och löst när du är i.  Så vi gör inte det; varje meningsfull privilegierad nätverksport inuti de olika närvaropunkterna (POP) LAN utsätts bara för den nakna metallmaskinens loopback-enhetsgränssnitt. [`lo0`](#).

Denna infra är helt automatiserad när en region tas online, men det är allt vi kan dela offentligt om arkitekturen (balansering Hobbsian öppenhet med det militära mantrat "lösa läppar sjunka fartyg" är mer konst än vetenskap).  Var säker &mdash; bortom att bryta antispoofing [`lo0`](#).

Även om huvudkontrollkontot för OCI har äventyrats fortsätter **konfidentialiteten** och **integriteten** för alla kundtillgångar att vara okränkbara.  Allt en svart hatt kan göra är att göra en röra med kundens hemsida ** tillgänglighet**. I synnerhet kan de inte komma åt dataposterna för Subversion-tjänsten.  Vi kan rekonstruera hela OCI-infrastrukturen från grunden på 48-72 timmar när det dåliga äpplets OCI-åtkomst har avslutats.

-----

### Loggning, övervakning och granskning

Vi uppmuntrar företagskunder att skapa ett Splunk-konto, och vi kommer att leverera webbloggar i nära realtid till ditt konto från varje global POP du behöver.  Felloggar för CGI-skript på serversidan görs också tillgängliga för Splunk.

Vi övervakar tjänstens tillgänglighet från alla våra OCI POP:er över hela världen och utlöser händelser för hög tillgänglighet (tillgänglighetsdomän) eller regional failover om ett serveravbrott varar längre än 30 sekunder.

ACL-granskning kan utföras genom att helt enkelt bygga en webbplats Subversion HEAD med hjälp av Apache Licensed [Orion SSG](https://github.com/SunStarSys/orion/blob/master/test.sh) skript och undersöka den resulterande versionen till [`www/.acl`](#).

Bekräftelsehookar för Subversion Server-Side kan också anpassas efter dina tillsynsproblem. Från en enkel bekräftelse mailer till säker tillgång till vår svnpubsub daemon, det finns ett antal anpassade konfigurationer tillgängliga.

-----

## Säkerhet för Orion-applikation

```graphviz
digraph {
"@path::acl" -> "authz-svn.conf" [label="svn"];
"@path::acl" -> "/**/.htaccess" [label="httpd"];
};
```

&nbsp;

Orions säkerhetsmodell hanteras centralt av inställningarna i [`@path::acl`](#) som konstuced i [`lib/path.pm`](#).

### OpenIDC Säkerhet för enkel inloggning

Sessionscookies är HttpOnly och Secure-flaggade, så Javascript-sessionsstöldförsök neutraliseras effektivt av Orion Online Editor.

### Bcrypt för Subversion-lösenord

Justerbart antal omgångar (standard är för närvarande 5).

### Målade dataskydd

Alla våra Perl-körtider har obligatoriska taint-kontroller aktiverade med -T-flaggan; en kraftfull, unikt Perl-skydd mot Remote Shell Exploits.

### Wiki-problem

Wikisäkerhet involverar flera faktorer:

1. Gränssnitts-/API-säkerhet

2. Mellanprogramvara/säkerhet på serversidan

3. Traversskydd för mall

4. ACL-kompatibilitet för sökmotor

Vi gräver i dessa frågor som de relaterar till Orion nedan.

#### Redigerare online

Redigeraren online stöder ett JSON-gränssnitt genom att helt enkelt ställa in användaragentens Accept-rubrik så att den föredrar [`ansökan/json`](#).

**Det finns inget administrativt användargränssnitt/API** utanför direkt Subversion-åtkomst.

##### Subversion-ACL:er styr läsbehörighet för arbetskopia på serversidan

Varje resurs för arbetskopiering som är tillgänglig via användargränssnittet korskontrolleras mot dina åtkomstkontrollistor för Subversion innan de visas för användaren.  På så sätt säkerställer vi att läsåtkomst till obehöriga återkomster förhindras för tillgångarna under versionskontroll (aka ** allt**).

#### Bekräftelseåtkomst styrs direkt med Subversions åtkomstlistor

Inget kan skapas och sedan visas över nätverket utan motsvarande auktoriserade Subversion-bekräftelse. Huvudproblemet här är att kontrollera vilken information som är tillgänglig för en wiki-sidförfattares bekräftade och byggda redigeringar.

Om du tillåter mallförbearbetning på källsidorna för nedsättning måste du vara medveten om hur mallargument gör innehållet i andra filer i trädet tillgängligt som variabler till källan till den redigerade sidan.

Ofta, om det är konfigurerat att göra det, kan den redigerade sidan deklarera sina egna beroendefiler i sidhuvuden, vilket är något att tänka på när du väger funktionsuppsättningar mot säkerhetskontroller i Wikis informationsarkitektur.

Medan vi kan erbjuda vägledning och stöd för att matcha dina behov, är det verkligen upp till dig att bestämma hur du ska balansera skalorna för din organisations företagswiki.

Se avsnittet nedan på [Beroende-/ACL-insprutningskontroller](#h4-dependency-acl-injection-controls) för mer information, och kolla in detta live exempel på hur enkelt åtkomstkontrollistor kan konfigureras centralt i [`lib/acl.yml`]({{snippetA.pretty_uri}}).

[snippet:repo=SunStarSys/www:path=lib/acl.yml:branch=trunk:token=#acl:lang=yaml]

Innehållsredigerare kan konfigurera sidbegränsningar på sidans [rubriker]({{snippetB.pretty_uri}}).

[snippet:repo=SunStarSys/www:path=content/orion/security.md.en:branch=trunk:lines=1,4:lang=yaml]

Som en sidoanteckning kan skyddade resurser inte kopieras till en gren av obehörig personal, även utan att placera några ytterligare åtkomstkontrollistor för skapande och ändring av grenar. Med andra ord kommer systemet att stödja försök på filialer utan ytterligare kontroller från din sida för att säkerställa att skyddade tillgångar förblir skyddade under varje filials naturliga livscykel.

#### Skapa systemåtkomstlistor?

Byggsystemet är allseende och allvetande, men vi kan se till att dina byggda, skyddade tillgångar endast är synliga för de team du hanterar och kontrollerar i Subversion ACL.

Byggsystemet visar listan över filnamn som den skapade via webbläsarens IDE vid en bekräftelse, men den listan baseras bara på en användares läsåtkomst till resurserna som är beroende av användarens lägg till, uppdatera eller ta bort innehållsåtgärder i bekräftelsen.

#### Malltraverseringskontroller

Se [sanitize_relative_path]({{snippetC.pretty_uri}}).

[snippet:repo=SunStarSys/orion:path=lib/SunStarSys/Util.pm:token=#ttc:lang=perl]

Den här koden tillämpar de regler som följer nedan i det här avsnittet.

##### inkludera och utöka taggar

Alla målfiler finns i en undermapp till [`/mallar/`](#).

##### ssi-tagg

Alla målfiler finns i en undermapp till [`/innehåll/`](#).

Om målsökvägen inte har konfigurerats i [`@path::mönster`](#) med en matchande inställning som gör att målsökvägen i fråga antingen kan arkiveras eller kategoriseras, [`ssi`](#).

Detta beror på att [`ssi`](#).

#### Beroende-/ACL-injektionskontroller

Kontrollerad av [`lib/path.pm`](#).

#### lib/{path,view}.pm Subversion ACL:er

Det är klokt att kontrollera skrivåtkomst till dessa resurser genom att begränsa dem till personer som är både behöriga i kodbasen och behöriga att implementera säkerhetskontroller för hela uppsättningen tillgångar under versionskontroll (aka *allt*).

Det är också en bra idé att inkludera [`@svnadmin`](#).

##### Dynamiskt genererade regler via &#64;

Byggsystemet noterar din [`lib/path.pm`](#).

##### Anpassade kontroller för användning av seed_file_deps() och seed_file_acl() i lib/path.pm

Utöver dessa symbolers betydelse för [`lib/path.pm`](#), det finns också ett val i hur och på vilka filer du vill använda dem under en körning av kodblocket walk_content_tree ().  När allt kommer omkring är det inte bara en konfigurationsfil, utan en kodbas, med alla Turing-kompletta funktioner i [`Perl`](#).

#### Byggda åtkomstkontrollistor för webbplats och subversion synkroniserade med &#64;

Automatiskt skydd för efemära grenbyggen. Ingen ytterligare konfiguration krävs.

### PCRE Inbyggda kontroller för sökmotor

Samma situation som det allmänna användargränssnittet: det korskontrollerar mot Subversion-servern från användargränssnittet.

På den aktiva webbplatsen kommer sökmotorn att göra exakt samma sak när du aktiverar sökningar med nedsättning (källträd). Annars körs httpd-delbegäranden till den aktiva webbplatsen för att testa om användaren har behörighet att komma åt den aktiva filen (förutsatt att du har lösenordsskyddat sökmotorn så att den har användardata att arbeta med).

### Säkerhetspolicyer för innehåll

- [x]

Google och/eller LinkedIn.

- [x]

Data måste levereras från våra servrar.

- [x]

Innehållet måste levereras från våra servrar.

- [x]

Javascript Code måste levereras från våra servrar.

- [x]

CSS måste levereras från våra servrar.

- [x]

Endast PDF för närvarande.

### Korsursprunglig resursdelning

- [x]

- [x] Företag och företagskunder kan behandla Orion som en [Huvudlöst CMS](https://aws.amazon.com/what-is/headless-cms/) om de vill bygga sitt eget gränssnitt från [JSON Subversion Porslin](api/editor) eller [JSON-sökning](api/search).

### Tredjepartsberoenden

Anmärkningsvärt korta och beprövade beroenden, vars huvudkomponenter omfattas av [Orion-teknik](technology).

#### stycklista för programvara (SBOM) tillgänglig på begäran

[Kontakta oss](/contact).

--------

## Index

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date: 2024-04-11 19:29:56 +0000 (Thu, 11 Apr 2024) $ $Author: joe $ $Revision: 22074 $ -->
