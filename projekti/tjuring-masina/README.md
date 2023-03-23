# Tjuringova mašina

- Polaznici: Aleksandar Brkić, Katarina Gavrilović
- Saradnici: Nikola Milenić

## Uvod

Tjuringova mašina (eng. *Turing machine*) je apstraktni teorijski model
računara koji se sastoji od pokretne glave na traci. Traka je podeljena
na diskretne ćelije od kojih svaka može sadržati neki iz konačnog skupa
simbola (alfabeta). Glava se u svakom trenutku može naći u jednom od
konačnog broja stanja. U svakom koraku izvršavanja, glava pročita simbol
iznad kog se trenutno nalazi, pa na osnovu tog simbola i svog stanja
upiše nov simbol na to mesto, promeni stanje, i pomeri se na novo mesto
na traci. Uprkos svojoj jednostavnosti, bilo koji algoritam se može
izvršiti pomoću Tjuringove mašine. Intuitivan način za posmatranje
Tjuringove mašine je analogija po kojoj je traka ekvivalentna memoriji,
stanje ekvivalentno programskom brojaču a skup pravila ekvivalentan
programu.

## Metod

### Aparatura

- FPGA razvojna ploča
- UART interfejs

### Arhitektura

Alfabet Tjuringove mašine će se sastojati od 8-bitnih brojeva. Traka će
biti modelovana memorijom, a položaj glave će biti adresa u memoriji na
koju se upisuje i sa koje se čita. Skup pravila prelaza i izvršavanja će
biti predstavljeni memorijom, u kojoj će svaka reč predstavljati pravilo
izvršavanja u odgovarajućem stanju. Samo stanje predstavlja adresu u
memoriji pravila. Mašina će podržavati sledeća pravila:

1.  **\>:** Pomeri glavu za jedno polje u desno; ne menjaj simbol; pređi u sledeće stanje
2.  **\<:** Pomeri glavu za jedno polje u levo; ne menjaj simbol; pređi u sledeće stanje
3.  **+:** Ne pomeraj glavu; povećaj simbol za 1; pređi u sledeće stanje
4.  **-:** Ne pomeraj glavu; smanji simbol za 1 (u drugom komplementu); pređi u sledeće stanje
5.  **?\<broj\>:** Ne pomeraj glavu; ne menjaj simbol; ako simbol nije 0, pomeri stanje za \<broj\>, u suprotnom pređi na sledeće stanje
6.  **!\<broj\>:** Ne pomeraj glavu; ne menjaj simbol; pomeri stanje za \<broj\>

Za pravila 5 i 6, broj je označen u drugom komplementu, veličine 6 bita.
Primeti da ukoliko je taj broj 0, mašina ostaje zaglavljena u tom stanju
(kraj programa).

Primer: Program ?2!0-\>+\<!-6 dodaje broj na trenutnoj poziciji broju na
poziciji desno od njega.

### Način rada

Na početku, Tjuringova mašina preko UART-a dobija skup pravila, početni
položaj, i početne vrednosti polja na traci. Zatim, mašina izvršava
program, i nakon svakog koraka preko UART-a ispisuje trenutni izgled
trake i stanje glave.

## Rezultat

Na kraju mikroprojekta, imaćeš funkcionalnu Tjuringovu mašinu koja će
moći da izvršava razne programe. Napiši nekoliko programa kojima ćeš
demonstrirati kako mašina radi.
