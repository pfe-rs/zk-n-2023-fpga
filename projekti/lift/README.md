# Kontroler lifta

- Polaznici: Lenka Milojčević, Milica Ćeranić
- Saradnici: Filip Parag, Dragan Mićić

## Uvod

Kontroler lifta je „mozak” iza sprave koju koristite svakodnevno i
njegov zadatak je da ne razmišljate o njemu, odnosno da uvek radi
pouzdano. Kontroleri na novim modernim su veoma napredni jer između
ostalog upošljavaju redove čekanja da minimizuju nervozu, ali se u
osnovi svode na mašinu stanja koju ćete realizovati u ovom projektu.

## Metod

### Aparatura

- FPGA razvojna ploča
- Taster x2

### Postupak razvoja

1.  Konačan automat
    - **Smernice:** Kada posmatramo lift, on se uvek nalazi u nekom određenom stanju, a naredno stanje zavisi od trenutnog i korisničkog unosa preko tastera. U prvom koraku treba da odredite koja su sve moguća stanja i dozvoljeni prelazi između njih i to prikažete grafički na papiru. Radi jednostavnosti, pretpostavimo da lift može biti u podrumu, prizemlju i na prvom spratu i da na svakom od njih ima dugme za dozivanje lifta, a unutar njega ima dugme za gore i dole. Pri prelasku s jednog na drugi sprat, lift se nalazi u međustanju koje označava njegovo kretanje.
    - **Rezultat:** Dijagram koji opisuje sva moguća stanja i prelaze između njih.
2.  Implementacija
    - **Smernice**: Implementirati lift u kodu kao par kombinacione mreže koja računa sledeće stanje i sekvencijalnog kola koje ga ažurira. Zatim napraviti testbench u kome testirate ponašanje lifta. Svaki taster je predstavljen jednobitnim signalom, a stanje lifta je predstavljeno enumerisanim tipom signala.
    - **Rezultat**: Lift se uspešno kreće (menja stanja) i odaziva na komande.
3.  Korisnički unos
    - **Smernice**: Treći, i verovatno najzanimljiviji korak, je povezivanje upravljačkih signala na tastere i LE diode. Tri tastera i diode koje se nalaze na ploči treba povezati na signale dugmića za dozivanje lifta i njegov trenutni (među)sprat, a pored toga dodatna dva tastera priključiti na GPIO pinove i povezati na signale dugmića u liftu. Staviti da se promena stanja izvršava ne brže od jednom u sekundi.
    - **Rezultat**: Lift se može kontrolisati hardverski, a njegovo stanje se vidi na diodama.

### Literatura

- [Mašina stanja na Vikipediji](https://en.wikipedia.org/wiki/Finite-state_machine)
- [Murova mašina na Vikipediji](https://en.wikipedia.org/wiki/Moore_machine)

### Dodatne mogućnosti

- Prikazati trenutni sprat na sedmosegmentnom displeju.
- Dodati mehanizam za otvaranje i zatvaranje vrata kao posledicu dolaska na sprat i preduslov odlaska sa sprata. Indikator o tome da li su vrata otvorena povezati na LED.

## Rezultat

Na LED se prikazuje trenutni položaj lifta i kontroliše se tasterima. U
slučaju da ne stignete implementaciju trećeg koraka, napravite demo koji
simulira korisničke unose sličan testbench-u, ali položaj prikazuje na
diodama razvojne ploče.
