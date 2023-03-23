# Kontroler tastature

- Polaznici: Vuk Mićović, Nikola Lukić
- Saradnici: Petar Marković

## Uvod

Današnji računarski sistemi imaju mnoštvo periferija za različite
potrebe. Jedna od tih periferija jeste tastatura, kao ulazna periferija,
za koju je potreban određen kontroler. Tastatura može da komunicira sa
računarskim sistemom preko različitih protokola, ali protokol koji ćemo
mi koristiti ovde jeste PS/2 zbog svoje jednostavnosti. Zaduženje
kontrolera tastature jeste da piše i čita odgovarajuće PS/2 pakete kako
bi odredio pritisnute ili otpuštene tastere na tastaturi i te događaje
poslao na svoj izlaz kako bi komponenta koja taj kontroler koristi mogla
da na lak način reaguje na ove događaje.

## Metod

### Aparatura

- FPGA razvojna ploča
- PS/2 tastatura

### Postupak razvoja

1.  Pisanje modula za čitanje PS/2 paketa
    - **Smernice:** Prvi korak u razvoju ovog mikroprojekta jeste razvoj modula koji ume da čita PS/2 pakete, bajt po bajt. Za ovo je potrebno razumeti kako funkcioniše PS/2 protokol (videti literaturu i konsultovati se sa mentorima). Ovaj korak se može testirati tako što se modul poveže na tastaturu i na sedmosegmentni displej ispisuju primljeni bajtovi. Nije neophodno implementirati proveru bita parnosti.
    - **Rezultat:** Komponenta se poveže na tastaturu i ispravno čita bajtove koje tastatura šalje kad se pritisne taster.
2.  Pravljenja interfejsa ka spoljašnjem svetu
    - **Smernice:** Kada je već uspostavljena komunikacija sa tastaturom, sada je potrebno prepoznati događaje sa nje, odnosno kada se neki taster pritisne ili otpusti. Za ove potrebe tastatura šalje određene *make* ili *break* kodove (videti literaturu i konsultovati se sa mentorima). U ovom koraku je potrebno sačuvati poslednji taster nad kojim se desio događaj, kao i koji se događaj desio, u odgovarajućim registrima. Korisniku modula dozvoliti da pročita sadržaj ovih registara, kao i da obriše njihov sadržaj, čime signalizira da ih je pročitao. Testiranje vršiti tako što se kod poslednjeg tastera pritisnutog ili otpuštenog na tastaturi prikazuje na sedmosegmentnom displeju, a to da li je pritisnut ili otpušten na LED. Preko dugmeta dozvoliti resetovanje sadržaja registara.
    - **Rezultat:** Pritiskom na tastaturu prikazuje se kod pritisnutog tastera i LED dioda je upaljena, otpuštanjem se prikazuje kod otpuštenog tastera i LED dioda je ugašena, a pritiskom na dugme za resetovanje se kod resetuje na 0.

### Literatura

- [PS/2 stranica na Vikipediji](https://en.wikipedia.org/wiki/IBM_PS/2)
- [Tehnička specifikacija PS/2 komunikacije generalno](http://www.burtonsys.com/ps2_chapweske.htm) (Adam Chapweske, 1999)
- [Tehnička specifikacija funkcionisanja PS/2 tastature](http://www-ug.eecg.toronto.edu/msl/nios_devices/datasheets/PS2%20Keyboard%20Protocol.htm) (Adam Chapweske, 2003)

### Dodatne mogućnosti

- Realizovati prikazivanje poslednjih šest pritisnutih tastera na sedmosegmentnim displejima, ukoliko je tehnički moguće prikazati ih (na primer, slovo W se nikako ne može prikazati na sedmosegmentnom displeju).
- Konsultovati se sa kolegama sa Pong projekta kako bi se omogućila kontrola preko tastature.

## Rezultat

Prikazuju se kod tastera nad kojim se poslednji događaj desio kao i
događaj na sedmosegmentnom displeju i LED. Ukoliko samo razumevanje
kodova od tastature nije implementirano u modulu, prikazati poslednje
primljene bajtove na sedmosegmentnom displeju.
