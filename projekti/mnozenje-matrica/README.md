# Množenje matrica

- Polaznici: Tijana Beljić, Ksenija Živanić
- Saradnici: Pavle Pađin, Milomir Stefanović

## Uvod

Množenje matrica je jedna od osnovnih operacija u linearnoj algebri.
Pored očiglednih primena u matematici, jedna zanimljiva primena jesu
grafičke kartice, gde se pomoću množenja matrica dolazi do vrednosti
piksela koje je potrebno prikazati na ekranu. Jedan od glavnih kvaliteta
grafičke kartice jeste koliko efikasno može da vrši ovu operaciju.

## Metod

### Aparatura

- FPGA razvojna ploča
- USB2UART

### Postupak razvoja

1.  Softversko množenje 2x2
    - **Smernice:** Za početak, realizovati softverski množenje dve matrice koje su dimenzija 2x2 (te će i rezultat biti 2x2). Radi jednostavnosti, neka se svaki element čuva na 8 bita (unsigned). U ovom koraku je dovoljno uneti direktno u programu konkretne vrednosti za polja matrice, te videti dobijeni rezultat. Napraviti testbench koji će istestirati ponašanje napisanog koda.
    - **Rezultat:** Funkcionalan i istestiran softverski množač matrica 2x2
2.  Hardverski “Hello World”
    - **Smernice:** Potrebno je testirati UART konekciju, tako što će se poslati niz podataka jednostavno vratiti nazad pošiljaocu. Pošiljalac bi bio računar, dok bi se sva komunikacija vršila putem UART kanala.
    - **Rezultat:** Mogućnost komunikacije između računara i pločice pomoću USB2UART konvertera
3.  Hardversko množenje 2x2
    - **Smernice:** Pomoću osposobljene UART konekcije, potrebno je softverskom množaču ulazne matrice prosleđivati sa računara, putem UART konekcije. Najpre bi se obe matrice 2x2 prosledile pločici, te bi se nakon obrade računaru vratila matrica 2x2 koja je proizvod unetih matrica.
    - **Rezultat:** Pločica koja vrši množenje i interaguje putem UART konekcije.

### Literatura

- [How to Multiply Matrices](https://www.mathsisfun.com/algebra/matrix-multiplying.html)

### Dodatne mogućnosti

- Moguće je povezati prekidač(e) koji će omogućiti izbor dimenzija matrica koje se množe. Npr. sa jednim prekidačem 0 znači da množimo dve matrice 2x2, dok 1 znači da množimo matrice 2x3 i 3x2. U skladu sa postavljenim podešavanjem prekidača, potrebno je obrađivati unete podatke.

## Rezultat

Kao rezultat imaćete funkcionalan hardverski izveden množač matrica
prethodno definisanih dimenzija. Za nekoliko proizvoljnih primera
matrica unesenih na računaru generisati njihov proizvod i poslati
rezultat na računar.

Jedna alternativa jeste da se umesto UART-a, svi podaci unose direktno
na pločici, kao i da se rezultat ispisuje na pločici.
