# Kontrola VGA displeja

- Polaznici: Despot Maksimović, Milica Jovičić
- Saradnici: Vuk Vukomanović

## Uvod

Pre pojave LCD, LED i OLED monitori koji su danas najzastupljeniji VGA
monitori su bili deo standardne opreme svakog računara. VGA je interfejs
za kontrolu **analognih** monitora i zbog svog “jednostavnog” interfejsa
je odličan za korišćenje sa mikroprocesorima.

Za potrebe ovog projekta potrebno je implementirati VGA kontroler na
FPGA ploči i iscrtati kvadrat u zadatoj boji na njemu.

## Metod

### Aparatura

- FPGA razvojna ploča
- VGA monitor
- VGA kabal

### Postupak razvoja

VGA konektor se sastoji od 15 različitih pinova (nisu nam svi bitni):

| Pin | Signal | Opis                         |
|-----|--------|------------------------------|
| 1   | R      | \[3.3V\] crvena boja piksela |
| 2   | G      | \[3.3V\] zelena boja piksela |
| 3   | B      | \[3.3V\] plava boja piksela  |
| 4   | EDID   | No connect                   |
| 5   | GND    | /                            |
| 6   | GND    | /                            |
| 7   | GND    | /                            |
| 8   | GND    | /                            |
| 9   | /      | /                            |
| 10  | GND    | /                            |
| 11  | EDID   | /                            |
| 12  | EDID   | /                            |
| 13  | H_sync | Horizontalni sync signal     |
| 14  | V_sync | Vertikalni sync signal       |
| 15  | EDID   | /                            |

Nama su od interesa signali **R**, **G** i **B** koji daju monitoru
informaciju o boji određenog piksela i signali **H_sync** i **V_sync**
koji daju informaciju monitoru o početku novog frejma i poziciji
piksela.

Signali **R**, **G** i **B** su po svojoj prirodi analogni (napon na
žici određuje koliko je piksel crven, zelen ili plav) a FPGA na našoj
pločici radi isključivo sa digitalnim signalima, zato na našoj pločici
postoji poseban čip kome za svaki od signala **R**, **G** i **B**
pošaljemo 8-bitni broj koji predstavlja intenzitet te boje a on vrši
konverziju tog signala u analogni napon. (Detaljnije o tom čipu se može
videti u uputstvu za pločicu ili se konsultovati sa mentorom.)

Signali **H_sync** i **V_sync** su prosti digitalni signali koji uz
pomoć nekoliko impulsa precizne dužine i frekvencije obaveštavaju
monitor o tome koji piksel se trenutno šalje. Tačne vrednosti za ove
impulse se mogu naći u literaturi (800 x 600 @ 72 Hz timing). Za ovaj
projekat ćemo konkretno koristiti rezoluciju od 800 puta 600 piksela i
72 osvežavanja ekrana u sekundi. (Ova rezolucija je pogodna jer se
podaci za novi piksel šalju frekvencijom od 50MHz, što je jednako
frekvenciji na kojoj naš FPGA radi, olakšavajući realizaciju ovog
projekta.)

1.  Razumevanje VGA protokola i prikaz jednobojnog ekrana
    - **Smernice:** Potrebno je upoznati sa detaljima VGA protokola i preciznim vrednostima za **H_sync** i **V_sync** impulse. Implementirati hardver koji generiše ove impulse i pravilno prikazuje boje na ekranu, dok su vrednosti boje piksela konstantne.
    - **Rezultat:** Na VGA monitoru se prikazuje validna jednobojna slika.
2.  Prikazivanje gradijenta
    - **Smernice:** Promeniti deo hardvera zadužen za vrednosti boje piksela tako da se na ekranu prikazuje gradijent. Ideja za realizaciju: Hardver koji generiše impulse daje informaciju hardveru zaduženom za vrednost boje piksela o tome koji piksel se trenutno šalje monitoru, a onda u zavisnosti od koordinate trenutnog piksela izračunati boju piksela.
    - **Rezultat:** Na ekranu se prikazuje gradijent
3.  Prikazivanje pravougaonika
    - **Smernice:** Promeniti deo hardvera zadužen za vrednosti boje piksela tako da se na jednom delu ekrana (preko gradijenta) iscrtava jednobojni pravougaonik. Ideja za realizaciju: Proširiti hardver zadužen za vrednosti boje piksela tako da detektuje da li se trenutni piksel nalazi u pravougaoniku i u zavisnosti od toga odabrati koja boja se prikazuje.

### Literatura

- [VGA (unm.edu)](http://ece-research.unm.edu/jimp/vhdl_fpgas/slides/VGA.pdf)
- [VESA Signal 800 x 600 @ 72 Hz timing](http://tinyvga.com/vga-timing/800x600@72Hz)
- [de1-soc_user_manual.pdf](http://www.ee.ic.ac.uk/pcheung/teaching/ee2_digital/de1-soc_user_manual.pdf)

### Dodatne mogućnosti

- Animirati pozadinski gradijent da se menja kroz vreme
- Omogućiti promenu boje pravougaonika korišćenjem prekidača na pločici
- Omogućiti pomeranje pravougaonika korišćenjem tastera na pločici

## Rezultat

Validna slika na VGA monitoru koja prikazuje pozadinu sa gradijentom i
na njoj jednobojni pravougaonik, sa opcionom animacijom gradijenta i
pomeranjem pravougaonika. Alternativno, prezentabilni delovi su i samo
prikaz jednobojne pozadine ili pozadine sa gradijentom.
