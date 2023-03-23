# ADC VU metar

- Polaznici: Tadija Simić, Pavle Ivanović
- Saradnici: Lazar Premović

## Uvod

Analogno-digitalni konvertori su neophodni gde god je potrebno merenje
nekih fizičkih veličina i kao takvi se nalaze u skoro svim uređajima oko
nas. Kroz ovaj projekat, upoznaćete se sa korišćenjem
analogno-digitalnog konvertora na primeru indikatora jačine zvuka,
poznatijeg kao VU (volume unit) metra.

## Metod

### Aparatura

- FPGA razvojna ploča (DE10)
- Mikrofon

### Postupak razvoja

1.  Razumevanje SPI protokola i komunikacije sa ADC-om
    - **Smernice:** Potrebno je izučiti datasheet ADC čipa i uputstvo za FPGA pločicu i implementirati prosti SPI interfejs koji na LED diodama ili sedmosegmentnom displeju prikazuje pročitane vrednosti.
    - **Rezultat:** Vrednosti pročitane sa ADC-a se prikazuju na LED diodama ili sedmosegmentnom displeju.
2.  Izdvajanje korisnog signala i njegov lep prikaz
    - **Smernice:** Signal sa ADC-a ima poprilično malu amplitudu i veliku DC komponentu tako da taj signal treba transformisati kako bi se mogao lepo prikazati u vidu bar graph-a na LED diodama.
    - **Rezultat:** Vrednosti sa ADC-a se prikazuju u vidu bar graph-a i to tako da se njihovo ponašanje može korelisati sa jačinom ambijentalnog zvuka.

### Literatura

- [VU meter - Wikipedia](https://en.wikipedia.org/wiki/VU_meter)
- [DE10-Standard User Manual 1 www.terasic.com January 19, 2017](https://ftp.intel.com/Public/Pub/fpgaup/pub/Intel_Material/Boards/DE10-Standard/DE10_Standard_User_Manual.pdf)
- [LTC2308 - Low Noise, 500ksps, 8-Channel, 12-Bit ADC](https://www.analog.com/media/en/technical-documentation/data-sheets/2308fc.pdf)
- [Analog VU Meters](https://www.youtube.com/watch?v=vX9jlMtxYig)
- [Stereo LM3914/16 VU-METER with PEAK-Hold. Old project Finally Working.](https://www.youtube.com/watch?v=6TwP9PgxPuI)

### Dodatne mogućnosti

- Dodavanje usrednjavanja i indikatora maksimuma
  - **Smernice:** Pravi VU merači po svojoj prirodi vrše usrednjavanje signala, dok je ovde tu funkcionalnost potrebno ručno implementirati, pogledati reference ponašanja VU merača kao inspiraciju. Neki VU merači takodje prikazuju i vrednost vremenski lokalnog maksimuma koji polako opada kroz vreme, opet pogledati reference za inspiraciju.
  - **Rezultat:** VU merač koji oponaša analogne VU merače po pitanju odziva i ima indikator maksimuma.

## Rezultat

Prikaz nivoa zvuka dobijenog sa mikrofona korišćenjem ADC-a u obliku bar
graph-a prikazanog na LED diodama FPGA pločice, sa opcionim
usrednjavanjem vrednosti i indikatorom maksimuma. Alternativno
prezentabilni deo je i prikazivanje vrednosti očitanih sa ADC-a na
sedmosegmentnom displeju.
