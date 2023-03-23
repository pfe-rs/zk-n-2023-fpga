# FIR / IIR filtri

- Polaznici: Marina Stojilković, Lazar Zubović
- Saradnici: Nataša Jovanović, Milomir Stefanović

## Uvod

Digitalni filtri su osnovna komponenta digitalne obrade signala. Koriste
se za izdvajanje željenih frekvencijskih opsega. Za cilj ovog projekta,
digitalne filtre ćemo koristiti za izdvajanje matrice iz pesme. Ljudski
glas i matrica pesme mogu, a ne moraju se nalaziti na različitim
frekvencijama. U okviru ovog projekta, radiće se sa pesmom/pesmama kod
kojih je moguće izdvojiti matricu iz pesme, samo na osnovu izdvajanja
određenog frekvencijskog opsega.

## Metod

### Aparatura

- FPGA razvojna ploča
- USB2UART

### Postupak razvoja

1.  Dizajn digitalnog filtra
    - **Smernice:** Prvi korak jeste analiza datog audio signala i definisanje parametara IIR i FIR filtara. Ovo je moguće postići analizom spektrograma datog signala u Python-u ili MATLAB-u i izdvajanjem učestanosti od značaja. Radi provere rezultata dobijenih implementacijom filtra u Verilogu, primenite generisane filtre na ulazni audio signal i zabeležite rezultate.
    - **Rezultat:** Koeficijenti FIR / IIR filtra neophodni za izdvajanje matrice pesme
2.  Šema filtra
    - **Smernice:** Sa koeficijentima iz prethodnog koraka, potrebno je ilustrovati šemu filtra sa unetim odgovarajućim koeficijentima.
    - **Rezultat:** Šema FIR/IIR filtra sa dobijenim koeficijentima
3.  Implementacija
    - **Smernice:** Na osnovu date strukture filtra, napisati kod koji će za ulazne podatke (u početku to mogu biti predefinisani nizovi brojeva a nakon toga i podaci preuzeti iz fajla) generisati izlazni signal. Nakon toga, napravite testbench koji će istestirati ponašanje napisanog koda. Uporedite dobijeni izlazni signal sa signalom generisanim u koraku 1.
    - **Rezultat:** Funkcionalan i istestiran kod koji realizuje IIR / FIR filtar i generiše očekivani izlazni signal.
4.  Hardverski “Hello World”
    - **Smernice:** Potrebno je testirati UART konekciju, tako što će se poslati niz podataka jednostavno vratiti nazad pošiljaocu. Pošiljalac bi bio računar, dok bi se sva komunikacija vršila putem UART kanala. Ovo će poslužiti kao priprema za poslednji korak.
    - **Rezultat:** Mogućnost komunikacije između računara i pločice pomoću USB2UART konvertera
5.  Hardverska realizacija
    - **Smernice:** Potrebno je funkcionalan kod dobijen trećim korakom spustiti na pločicu, te pomoću računara i UART kanala proslediti pločici odabranu pesmu. Pločica treba nakon svakog primljenog odbirka da vrši filtriranje i vraća odgovarajući filtriran odbirak.
    - **Rezultat:** Funkcionalna pločica koja realizuje učitavanje pesme, filtriranje i slanje filtrirane pesme.

### Literatura

- [Difference Between FIR Filter and IIR Filter (with Comparison chart) - Circuit Globe](https://circuitglobe.com/difference-between-fir-filter-and-iir-filter.html)

### Dodatne mogućnosti

- Za proizvoljno izabrani audio signal možete pokušati da u prethodno opisanim koracima dizajnirate band-pass / high-pass filtar.

## Rezultat

Generiše se novi, isfiltrirani audio signal koji predstavlja matricu
prethodno izabrane pesme.

Ukoliko nije odrađen poslednji korak, moguće je vršiti filtriranje
signala koji su direktno uneti u kod (hardkodovani). Za cilj
demonstracije rada filtra, odabrati reprezentativan signal koji se može
filtrirati, te pokazati dobijeni rezultat.
