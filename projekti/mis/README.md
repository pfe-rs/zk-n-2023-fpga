# Kontroler miša

- Polaznici: Nemanja Majski, Lenka Vučković
- Saradnici: Luka Simić

## Uvod

Današnji računarski sistemi imaju mnoštvo periferija za različite
potrebe. Jedna od tih periferija jeste miš, kao ulazna periferija, za
koju je potreban određen kontroler. Miš može da komunicira sa
računarskim sistemom preko različitih protokola, ali protokol koji ćemo
mi koristiti ovde jeste PS/2 zbog svoje jednostavnosti. Zaduženje
kontrolera miša jeste da piše i čita odgovarajuće PS/2 pakete kako bi
odredio trenutno stanje miša, odnosno njegovu poziciju i koji tasteri su
na njemu trenutno pritisnuti, kao i da to stanje pošalje na svoj izlaz
kako bi komponenta koja taj kontroler koristi mogla da na lak način
pristupi ovim informacijama.

## Metod

### Aparatura

- FPGA razvojna ploča
- PS/2 miš

### Postupak razvoja

1.  Pisanje modula za čitanje PS/2 paketa
    - **Smernice:** Prvi korak u razvoju ovog mikroprojekta jeste razvoj modula koji ume da čita PS/2 pakete, bajt po bajt. Za ovo je potrebno razumeti kako funkcioniše PS/2 protokol (videti literaturu i konsultovati se sa mentorima). Nažalost, miš ne šalje toliko smislene PS/2 pakete dok mu se ne pošalje komanda za reset, tako da je ovaj korak najbolje testirati tako što se poveže na tastaturu i na sedmosegmentni displej ispisuju primljeni bajtovi. Nije neophodno implementirati proveru bita parnosti.
    - **Rezultat:** Komponenta se poveže na tastaturu i ispravno čita bajtove koje tastatura šalje kad se pritisne taster.
2.  Slanje komande za reset PS/2 miša
    - **Smernice:** PS/2 miš je, nakon povezivanja, potrebno resetovati slanjem odgovarajuće komande (videti literature i konsultovati se sa mentorima). Nakon ovoga, miš bi trebalo da šalje smislene PS/2 pakete koji se mogu ispisati na sedmosegmentni ekran.
    - **Rezultat:** Komponenta se poveže na miš, pošalje mu komandu i ispravno čita bajtove koje mu miš šalje.
3.  Razumevanje primljenih paketa od PS/2 miša i održavanje stanja
    - **Smernice:** Sada kad je komunikacija sa PS/2 mišem uspešno uspostavljena, potrebno je čitati njegove pakete sa informacijama o pomeraju i pritisnutim tasterima, kao i zabeležiti rezultate tih informacija. Na primer, ukoliko paket kaže da je sada miš pomeren ulevo i da je pritisnut levi taster, potrebno je da modul taj pomeraj uračuna u apsolutni pomeraj miša otkad je FPGA uključen i zapamti da je levi taster trenutno pritisnut.
    - **Rezultat:** Komponenta ispisuje na sedmosegmentni displej lokaciju miša u odnosu na njegovu početnu poziciju (po X osi kada je prekidač spušten, po Y kad je podignut) i na LED prikazuje stanje pritiska tastera (levog, srednjeg i desnog).

### Literatura

- [PS/2 stranica na Vikipediji](https://en.wikipedia.org/wiki/IBM_PS/2)
- [Tehnička specifikacija PS/2 komunikacije generalno](http://www.burtonsys.com/ps2_chapweske.htm) (Adam Chapweske, 1999)
- [Tehnička specifikacija funkcionisanja PS/2 miša](https://isdaman.com/alsos/hardware/mouse/ps2interface.htm) (Adam Chapweske, 2001)

### Dodatne mogućnosti

- Ukoliko su kolege sa projekta za VGA kontroler uradile veći deo projekta, konsultovati se sa njima kako bi prikazali kurzor miša koji se kreće po ekranu. Za ovaj deo je takođe potrebno implementirati ograničavanje miša kako ne bi izašao van ekrana.

## Rezultat

Prikazane su X ili Y koordinate miša na sedmosegmentnom displeju u
zavisnosti od stanja određenog prekidača, i kada se pritisne ili otpusti
neki od tri tastera ta promena se vidi na jednoj od LED. Ukoliko je deo
sa slanjem komande uspešno realizovan, ali njeno parsiranje nije još
uvek, prikazati poslednja tri bajta primljena od miša na sedmosegmentnim
displejima u vidu heksadecimalnih brojeva.
