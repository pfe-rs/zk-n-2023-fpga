# ZK-S 2023
Na zimskom kampu za stare polaznike PFE, održanom od 20. do 25. marta 2023. godine, radila se digitalna elektronika, arhitektura i organizacija računara, jezici za opis hardvera i mikroprojekti korišćenjem FPGA razvojnih pločica. U ovom repozitorijumu mogu se pronaći materijali sa radionice i mikroprojekti polaznika rađenih pred kraj.

## Struktura
Repozitorijum je struktuiran na sledeći način:

- `materijali`: Direktorijum sa materijalima sa predavanja
    - `logisim`: [Logisim-evolution](https://github.com/logisim-evolution/logisim-evolution) šeme sa predavanja iz arhitekture i organizacije računara, uključujući jedan nedovršen [RISC-V](https://riscv.org/) (rv32i) procesor i neki primeri upravljačkih i operacionih jedinica
    - `projekat`: Početni projekat za Intel® Quartus® Prime Lite za Cyclone V na [DE1-SoC](http://de1-soc.terasic.com/) FPGA razvojnoj ploči
- `projekti`: Projekti polaznika radionice. U okviru svakog direktorijuma za projekat nalazi se specifikacija projekta

## Uputstvo za polaznike
Ukoliko se rešite da sami dodate fajlove u repozitorijum, to možete uraditi na sledeći način:

1. Instalirajte [Git](https://git-scm.com/) (ako ga već nemate)
2. Otvorite Git Bash u nekom direktorijumu
3. Klonirajte repozitorijum:
    1. Ukoliko nemate SSH ključ (ukoliko ne znate šta je SSH ključ najverovatnije ga nemate), pokrenite `git clone https://github.com/pfe-rs/zk-s-2023-fpga.git`
    2. Ukoliko imate SSH ključ, pokrenite `git clone git@github.com:pfe-rs/zk-s-2023-fpga.git`
4. Promenite trenutni direktorijum na repozitorijum: `cd zk-s-2023-fpga`
5. **Napravite svoju granu:** `git checkout -b [projekat]` (zamenite `[projekat]` sa nazivom svog projekta)
    - Ukoliko ne napravite svoju granu, dobićete grešku kako nemate dozvolu za guranje koda na tu granu
6. Dodajte fajlove svog projekta u direktorijum namenjen za projekat, unutar `projekti` direktorijuma
7. Uradite *stage*: `git add .`
8. Uradite *commit*: `git commit -m "Ovde ide commit poruka."`
9. Prihvatite vašu [pozivnicu za GitHub repozitorijum](https://github.com/pfe-rs/zk-s-2023-fpga/invitations)
10. Pokrenite `git push --set-upstream origin [projekat]` (gde je `[projekat]` isto kao ime vaše prethodno napravljene grane)
11. Osvežite stranicu sa repozitorijumom (sa koje verovatno čitate ovo uputstvo) i pritisnite dugme kako biste napravili *pull request*

Ukoliko se rešite da ipak ne dodajete sami fajlove u repozitorijum, možete ih podeliti preko alternativnih načina čija su uputstva prethodno poslata. Ukoliko želite da svoj projekat čuvate kao odvojen Git repozitorijum pod svojim nalogom, obavestite saradnike kako bi rukovodili ovom vanrednom situacijom.
