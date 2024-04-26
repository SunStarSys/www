---
archived: ~
categories: ~
dependencies: '*.md.sv api/index.md.sv'
keywords: ~
published: ~
status: skiss
title: Sekretesspolicy för Orion
---

<div class="float-lg-right">
	<img src="../images/sunstarstaronly.png"></img>
</div>

## Disposition

- INGEN DELNING/ÅTERFÖRSÄLJNING AV KUNDDATA.

- Cookies som endast används för säkerhets-/ansvarsyften.

- De enda användaridentitetskomponenterna vi loggar är ditt Google OpenID-kontos e-postadress och det användarkonto du använder för att ansluta till det Subversion-system som ligger till grund för Orion &trade; för den webbplats som du gör bekräftelser till.  Loggsystemet spårar dessa tillsammans med den grundläggande Apache [`httpd`](#) logguppsättning för åtkomstsvar som inkluderar anslutning av IP-adress, protokoll för begäran med URL-detaljer och annonserad klient [`Referens`](#) och  [`Användaragent`](#).

- {# lede #}Det är ett GDPR-kompatibelt opt-in-system.  Första besöket i Orion &trade; CMS/IDE, du kommer att dirigeras till en Googlesida där du uppmanas att godkänna{# lede #} appen <span class="text-white">SunStar Systems OIDC</span> där du kan använda dina angivna Google-kontouppgifter (främst profilinformation) &mdash;

--------

## Index

{% for d in deps %}
- [{{d.1.headers.title|safe}}]({{d.0}}) &mdash; {{d.1.content|lede}}...
{% endfor %}

<!-- $Date: 2024-03-29 15:57:18 +0000 (Fri, 29 Mar 2024) $ $Author: joe $ $Revision: 21889 $ -->
