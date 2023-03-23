# Automat za slatkiše

- Polaznici: Anja Kovačev, Tadija Karanović
- Saradnici: Filip Parag, Dragan Mićić

## Uvod

Svaki automat za slatkiše (eng. *Vending machine*) ima neku vrstu
mikroprocesora koji mu omogućava da izračuna koliko novca je korisnik
ubacio, koji proizvod je izabrao i koliki kusur je potrebno vratiti
korisniku. Naš automat za slatkiše, za izvršavanje ove logike, ima FPGA.
Potrebno je osmisliti FPGA sistem za mašinu za slatkiše sa sledećim
specifikacijama:

1.  Jedini proizvod koji automat prodaje je krem bananica i njena cena je 25 RSD
2.  Automat prima novčiće od 5, 10 i 20 dinara, koji generišu sledeće signale ka FPGA: **rsd_5**, **rsd_10** i **rsd_20**
3.  Automat izbacuje krem bananicu korisniku tako što generiše izlazni signal ***bananica_out***
4.  Automat izbacuje kusur korisniku tako što generiše izlazne signale, ***kusur_5***, ***kusur_10**, **kusur_20***

Pošto je naš FPGA samo deo većeg sistema, svi ulazni i izlazni događaji
se dešavaju na uzlaznu ivicu takta.

## Metod

### Aparatura

- FPGA razvojna ploča

### Postupak razvoja

1.  Osmisliti i nacrtati mašinu stanja (**najbitniji korak projekta**) i pokazati saradniku
2.  Implementirati prvu verziju automata koji ne vraća kusur već samo generiše signal za izbacivanje bananica
3.  Dodati funkcionalnost automatu za vraćanje kusura

### Dodatne mogućnosti

- Izlazni signal **bananica_out** traje tačno jedan takt
- Povezati ulazne signale na dugmiće i izlazni signal na LED (DE1-SoC ima ove periferije)
- Uvesti brojač izbačenih krem bananica i ograničiti broj bananica u automatu - ukoliko korisnik proba da kupi više od 10 bananica generisati izlazni signal ***stock_error***

## Rezultat

Pokazati pomoću simulacije više test slučajeva ove mašine

1.  Kada korisnik unese tačan broj novčića
2.  Kada korisnik unese nedovoljno novčića
3.  Kada korisnik unese previše novčića (potrebno je generisati i signale za kusur)
