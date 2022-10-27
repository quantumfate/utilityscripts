#VL 03

## Der Client muss nur ein Session Cookie mitgeben, wenn?

Das Cookie vorhanden ist. Sonst wird kein Cookie mitgegeben.

[#HTTP](:/deb63e33d93849039bf6dbf8b57ba5f7) [#Cookie](:/4bef241fb8e14e269d093b465048efd0)

## Muss der Client überprüfen ob sein Cache noch aktuell ist?

Nein

[#HTTP](:/deb63e33d93849039bf6dbf8b57ba5f7) [#Cookie](:/4bef241fb8e14e269d093b465048efd0)

## Wie werden ranges von bestimmten Content Typen übermittelt?

Mithilfe jeweiliger Optionen im Header. Es wird eine Byte range angegeben.

![90d21b8162067e161640aaea3ea3f718.png](:/dbec913ab865492b888b306d1122aa46)

## Ist Base64 Codierung verschlüsselt?

Nein

[#SMTP](:/4bef241fb8e14e269d093b465048efd0)

## Wozu wird Base64 Codierung verwendet?

Um Binary Data in String codiert zu übermitteln.

![6799cfc88f833b0d85a2783362094d95.png](:/b6b6097f8a494e70a0dcac0edc282f8c)

[#SMTP](:/4bef241fb8e14e269d093b465048efd0)


## Zwischen welchen Endpunkten wird das SMTP Protokoll verwendet?

- zwischen User Agent und Mailserver
- zwischen Mailservern

![00338027c870547f6d675bf4e40081aa.png](:/a7c0e27f788b4abfb6c5cbd1a95f66de)

[#SMTP](:/4bef241fb8e14e269d093b465048efd0)

# test

## Warum ist es problematisch folgendes im Nachrichtentext einer Mail zu haben? Was wird im SMTP Protokoll dagegen unternommen?

`<CR><LF>.<CR><LF>`

%

- `<CR><LF>.<CR><LF>`  signalisiert das Ende des Nachrichtenbefehls DATA
- ein weiterer "." wird hinzugefügt

[#SMTP](:/4bef241fb8e14e269d093b465048efd0)
