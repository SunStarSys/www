---
archived: ~
categories: ~
keywords: qpsmtpd,Apache::Qpsmtpd,earlytalker,Apache CMS
published: ~
status: ~
title: Apache Software Foundation
---

![ASF](http://www.apache.org/images/feather.png).

[Apache Software Foundation](http://www.apache.org/).

När jag började arbeta på Apache 2006 var det mest angelägna problemet de överbelastade inkommande e-posttjänsterna.  Organisationen drunknade i skräppost, och vid 1,5 miljoner inkommande anslutningar per dag överträffade det organisationens utgående leverans och överväldigade programvaran.  Min första uppgift var att lösa denna situation, så vad jag kom upp med var en tvåfaldig strategi: första uppgraderingen `qpsmtpd` till `Apache::Qpsmtpd`, den `mod_perl` experimentell variant som konverterar `httpd`

`Apache::Qpsmtpd` behövde några patchar för att göra den lämplig för företagstjänst, som jag tillhandahöll.  Det tog hand om den omedelbara oro som kretsade kring den krossande belastningen på tjänsten, men om tillväxttrenderna fortsatte skulle det innebära fortsatta investeringar i mer
och bättre hårdvara och mjukvara, främst för att betjäna all spam-anslutning tillväxt. Vi försökte till och med göra en abort `ecelerity`, som på Apple-utrustning inte var tillräckligt stabil för att vi skulle migrera till 2006.  `Ecelerity` (nu känd som `Moment` från [Meddelandesystem](http://www.messagesystems.com).

Ange den andra delen av mitt tillvägagångssätt: ett försök att avskräcka spammare från att träffa ASF: s e-postservrar i första hand.  Det innebar patchning `qpsmtpd`s `fetknopp` plugin som ska köras i `DATA` fas, i kombination med spärrning upp fördröjningen till 20 sekunder - ett högt men tolerabelt belopp för alla RFC-kompatibla meddelandeleveransmedel.  Det var en känslig balans när skräppostnivåerna steg till 2 miljoner sedan 2,5 miljoner per dag, eftersom `fetknopp` fördröjning ökade samtidighetsnivåer 4-5 gånger över "normala" nivåer och skräpposten fortsatte att växa. Vi pressade `httpd`s `MaxClients` inställningar under den perioden, även till den grad att man måste anpassa `httpd`

Normalt `fetknopp` körs innan bannern levereras, vilket är suboptimal när din primära plugin för att hantera spammare kretsar kring dns blacklists.  Körs `fetknopp` så sent som möjligt i `SMTP` sessionen innebar att andra, snabbareverkande, anti-spam plugins kunde släppa anslutningen så snart som möjligt, innan förseningarna började sparka in och binda upp `httpd` barn.  Spammare betalar också detta förseningspris för varje meddelande som skickas när `fetknopp` körs i `DATA`

Över 8 år, den ekologiska effekten av min `fetknopp`

Utöver de rutinmässiga sysslor som varje systemadministratör står inför, var min andra chefs prestation på ASF skapandet av `Apache CMS`. Skälen och motiven bakom det var [dokumenterad](http://www.apache.org/dev/cms), men det är viktigt att notera att denna programvara snabbt utvecklades under en 3-månadersperiod innan den trycktes i produktion för webbplatsen <http://www.apache.org/>.  Det har uppnått en popularitet inom ASF utöver mina vildaste förväntningar: över 100 projekt förlitar sig för närvarande på det för deras webbplatsbehov.  Det sänker skalan till små men invecklade webbplatser som [Apache Thrift](http://thrift.apache.org/), samtidigt som du skalar upp för att möta behoven hos en 5 GB webbplats som [OpenOffice.org](http://www.openoffice.org/).

Jag njöt av större delen av min tid som betjänade Apache-samhällets behov, men efter 8 år var det dags för en förändring.  Jag kommer alltid att se hjärtligt på de många minnen och vänner jag gjorde där, och önskar Apache allt det bästa framöver.
