---
archived: ~
categories: ~
keywords: qpsmtpd,Apache::Qpsmtpd,earlytalker,Apache CMS
published: ~
status: ~
title: Från Apache Software Foundation
---

![ASF](apache.page/feather2.png).

[Från Apache Software Foundation](http://www.apache.org/) (ASF) är en 501(c)(3) offentlig välgörenhet som ägnar sig åt att främja och utveckla programvara med öppen källkod.  Under de 8 år jag tjänstgjorde som (kontraktad) systemadministratör för ASF, stiftelsen tredubblades i både storlek och omfattning.  Vi gick från ett halvskåp värde av maskiner 2006 till över 4 skåp värda 2014, och började processen att expandera till molnet.

När jag började arbeta på Apache 2006 var det mest akuta problemet de överbelastade inkommande posttjänsterna.  Organisationen drunknade i skräppost, och vid 1,5 miljoner inkommande anslutningar per dag överträffade det organisationens utgående leverans och överväldigade programvaran.  Min första uppgift var att lösa denna situation, så det jag kom fram till var en dubbel strategi: första uppgradering `qpsmtpd` till `Apache::Qpsmtpd`, `mod_perl` experimentell variant som konverterar `httpd` till en server för inkommande e-post.

`Apache::Qpsmtpd` Jag behövde några patchar för att göra den lämplig för företagstjänst, som jag tillhandahöll.  Det tog hand om de omedelbara farhågorna kring den krossande belastningen på tjänsten, men om tillväxttrenderna fortsatte skulle det innebära ständiga investeringar i mer
och bättre maskinvara och programvara, främst för att betjäna all tillväxt av skräppostanslutningen. Vi försökte även en aborterad insats för att distribuera `celeritet`, som på Apple-utrustning inte var tillräckligt stabil för att vi skulle migrera till 2006.  `Ecelerity` (nu känd som `Starkare` från [Meddelandesystem](http://www.messagesystems.com)) är en vackert konstruerad mjukvara, med en imponerande balans av händelseslingor, arbetstrådar och förlängningspunkter, men i slutändan överkill för ASF.  Lösningarna med öppen källkod var "tillräckligt bra".

Ange den andra delen av mitt tillvägagångssätt: ett försök att avskräcka spammare från att träffa ASF: s e-postservrar i första hand.  Det innebar korrigering `qpsmtpd`s `tidig talare` plugin att köra i `DATA` fas, kombinerat med ratcheting upp fördröjningen till 20 sekunder - en hög men tolerabel mängd för alla RFC-kompatibla meddelandeleveransmedel.  Det var en känslig balans när skräppostnivåerna steg till 2 miljoner sedan 2,5 miljoner per dag, eftersom `tidig talare` fördröjning ökade samtidighetsnivåer 4-5 gånger över "normala" nivåer och spam fortsatte att växa. Vi pressade `httpd`s `MaxClients` inställningar under den perioden, till och med till den punkt att behöva anpassa `httpd` för att höja den sammanställda gränsen, men efter några månader började vi se mätbara förbättringar.

Normalt `tidig talare` körs innan bannern levereras, vilket är suboptimalt när din primära plugin för att hantera spammare kretsar kring dns svarta listor.  Körs `tidig talare` så sent som möjligt i `SMTP` sessionen innebar att andra, snabbare verkande, anti-spam plugins kunde släppa anslutningen så snart som möjligt, innan förseningarna började sparka in och binda upp `httpd` barn.  Spammare betalar också detta förseningspris för varje meddelande som skickas när `tidig talare` körs i `DATA` fas, inte bara vid initiering av en anslutning som är vad som händer när du kör den före bannern.  Med andra ord finns det ingen väg runt det annat än genom att skicka en lång mottagarlista som kan utlösa andra anti-spam-verktyg.

Över en 8-årsperiod, den ekologiska effekten av min `tidig talare` Justeringarna var tydliga: vi hade tappat antalet dagliga inkommande skräppostanslutningar ** tio gånger**, ner till cirka 150K per dag, utspridda på två servrar.  Spammare var helt enkelt **opting ut** av att skicka meddelanden till apache.org, vilket var den bästa anti-spam-lösningen möjligt.

Utöver de rutinmässiga sysslor som varje systemadministratör står inför, var min andra främsta prestation på ASF skapandet av `Apache CMS`. Skälen och motiven bakom det var [dokumenterad](http://www.apache.org/dev/cms), men det är viktigt att notera att denna programvara snabbt utvecklades under en 3-månadersperiod innan den pressades in i produktion för webbplatsen <http://www.apache.org/>.  Det har uppnått en popularitet inom ASF utöver mina vildaste förväntningar: över 100 projekt är för närvarande beroende av det för sina webbplatsbehov.  Det minskar skalan till små men intrikata webbplatser som [Apache Thrift](http://thrift.apache.org/), samtidigt som du skalar upp för att uppfylla behoven hos en 5 GB webbplats som [OpenOffice.org](http://www.openoffice.org/).

Jag njöt av den största delen av min tid som betjänade behoven hos Apache-gemenskapen, men efter 8 år var det dags för en förändring.  Jag kommer alltid att se förtjust på de många minnen och vänner jag gjorde där, och önskar Apache allt det bästa framöver.

<!-- $Date: 2026-02-16 12:33:32 -0700 (Mon, 16 Feb 2026) $ $Author: joe $ $Revision: 27653 $ -->
