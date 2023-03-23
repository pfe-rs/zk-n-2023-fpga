# UART

- Polaznici: Anđela Babincev, Marko Petrović
- Saradnici: Luka Simić

## Uvod

Za razne projekte bi bila korisna komunikacija sa računarom ili nekim
drugim uređajem radi prenosa podataka. Na primer, na projektima za
obradu slike se slika za obradu može poslati sa računara preko UART,
obraditi a zatim vratiti nazad, opet preko UART, i tako na lak način
podržati obradu bilo koje zadate slike (bez metoda poput direktne izmene
memorije na FPGA).

## Metod

### Aparatura

- FPGA razvojna ploča
- RS-232 kabl

### Postupak razvoja

1.  Razvijanje modula za [8N1](https://en.wikipedia.org/wiki/8-N-1) primanje podataka sa baud rate 9600
    - **Smernice:** Potrebno je poznavanje [UART](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter) protokola. Za komunikaciju sa računara se može koristiti Arduinov Serial Monitor, a primljeni karakteri se na pločici mogu prikazati na sedmosegmentnom ekranu. Proučiti postojeće pinove za UART komunikaciju na DE1-SoC pločici.
    - **Rezultat:** Nakon slanja karaktera sa Arduino Serial Monitora na sedmosegmentnim ekranima pločice prikaže se ASCII kod karaktera koji je poslat.
2.  Dodavanje mogućnosti za slanje podataka nazad
    - **Smernice:** Isto kao gore samo u obrnutom smeru.
    - **Rezultat:** Pored prikazivanja na ekranu, primljeni karakteri trebaju biti vraćeni pošiljaocu.
3.  Pakovanje u jedan Verilog modul
    - **Smernice:** Logiku za prikazivanje na ekranu i vraćanje karaktera nazad ostaviti u nekom spoljašnjem modulu, a u UART modulu ostaviti samo logiku za primanje i slanje, i ostaviti mogućnost da UART modul kaže spoljašnjem kada je završio operaciju, kao i da spoljašnji modul izabere operaciju koju želi da UART modul izvrši (čitanje ili pisanje).
    - **Rezultat:** Isto kao ranije, ali je modul odvojen.
4.  Mogućnost za konfiguraciju broja data, parity i stop bitova
    - **Smernice:** Kako bi modul podržavao različite varijante komunikacije, potrebno je dodati generičke parametre u modul za konfiguraciju ovih brojeva bitova.
    - **Rezultat:** Isto kao ranije, ali može da se menja broj bitova.

### Literatura

- [UART stranica na Vikipediji](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter)
- [DE1-SoC User Manual](https://www.terasic.com.tw/cgi-bin/page/archive_download.pl?Language=China&No=836&FID=ae336c1d5103cac046279ed1568a8bc3)

### Dodatne mogućnosti

- Integrisati napravljeni modul sa nekim od drugih projekata.

## Rezultat

Na kraju mikroprojekta očekuje se da je napravljen Verilog modul koji
može da komunicira sa računarom preko UART, kao i spoljašnja komponenta
oko modula koja primljene podatke ispisuje na sedmosegmentni ekran i
vraća nazad. Implementirana je provera bita parnosti, kao i podesiv broj
data, parity i stop bitova.
