# PWM generator

- Polaznici: Dimitrije Pešić, Luka Zrnić
- Saradnici: Vuk Vukomanović

## Uvod

Jedna od veoma čestih mogućnosti mikrokontrolera je da generišu impulsno
širinski modulisan (PWM) signal. Zadatak ovog mikroprojekta je da
rekreira hardversku komponentu mikrokontrolera koja generiše ovaj
signal. IŠM se podešava uz dva šesnaestobitna registra (jedan za
frekvenciju, drugi za dužinu pulsa) koji se povećavaju/smanjuju
tasterima, a izlaz bloka je signal koji predstavlja IŠM.

## Metod

### Aparatura

- FPGA razvojna ploča

### Postupak razvoja

1.  Simulacija brojača
    - **Smernice:** Komponenta koja na svaki takt povećava vrednost registra. Kada ta vrednost dostigne određenu vrednost koja je zadata na ulazu, registar se vraća na nulu i brojanje počinje iz početka.
    - **Rezultat:** U simulaciji možemo videti testerasti grafik koji predstavlja vrednost registra tokom vremena
    - Testirati sa vrednostima 1, 255 i 73
    - **Izazov:** Napisati generičku komponentu kojoj se pri instanciranju može dodeliti broj bitova u brojaču.
2.  Modul za generisanje PWM signala od brojača
    - **Smernice:** Implementirati modul koji poredi vrednost brojača sa vrednošću trigger-a na ulazu. Kada je vrednost brojača manja, izlazni signal treba da bude 0, u suprotnom treba da bude 1.
    - Testirati sa sledećim opcijama:
      1.  Maksimalna vrednost brojača: 256. Duty Cycle: 128
      2.  Maksimalna vrednost brojača: 100. Duty Cycle: 0 i 100
3.  Modul za kontrolu PWM signala
    - Da bismo prirodnije interagovali sa sistemom, želeli bismo da imamo sledeći model interakcije: komponenta koja na “ulazu” ima registar za periodu (u ms) i registar za duty cycle (u procentima), a na izlazu daje željeni signal. Ovi “ulazi” se zapravo
    - QoL: Svitch koji kontroliše da li izlaz postoji. Kada se uključi PWM generator se resetuje i pusti u rad. Kada se isključi ne postoji signal na izlazu.

### Literatura

- Svi potrebni linkovi idu u listu ovde

### Dodatne mogućnosti

- Ovde navesti stvari na kojima polaznici mogu da rade nakon što završe osnovni deo mikroprojekta

## Rezultat
