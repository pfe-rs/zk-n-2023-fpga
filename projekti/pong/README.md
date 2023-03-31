# Pong

- Polaznici: Anastasija Papić, Žarko Hajder
- Saradnici: Nikola Milenić

## Uvod

Pong je jedna od najstarijih arkadnih igrica, inspirisana stonim
tenisom. Igrači kontrolišu “rekete” koji se pomeraju vertikalno duž
ivica terena i prosleđuju loptu jedan drugom. Kad igrač ne uspe da vrati
loptu, njegov protivnik osvaja poen. Prvi igrač koji osvoji 3 poena
pobeđuje. Cilj projekta je napraviti ovakvu igricu na FPGA razvojnoj
ploči.

## Metod

### Aparatura

- FPGA razvojna ploča
- 8x8 LED displej

### Postupak razvoja

1.  Reketi
    - LED displej direktno povezati za GPIO pinove. Preko displeja prikazati dva reketa dimenzija 1x3 na levoj i desnoj ivici ekrana.
    - Omogućiti da se pomoću dugmića na razvojnoj ploči reketi pomeraju gore-dole. Postarati se da se reketi pomeraju ravnomerno, čak i tokom brzog pritiskanja dugmića.
2.  Loptica
    - Napraviti lopticu koja se odbija od gornjeg i donjeg zida ekrana, kao i od reketa. Na početku svakog poena, loptica se pojavljuje na centru ekrana i počinje kretanje direktno na levo ili desno. Pravac bacanja loptice na početku odrediti pseudo-nasumično pomoću [LFSR-a](https://en.wikipedia.org/wiki/Linear-feedback_shift_register).
    - Pri sudaru sa reketom, pravac odbijanja loptice zavisi od dela reketa koji je pogođen. Ako loptica pogodi centar reketa, odbija se horizontalno. Ako loptica pogodi gornji ili donji deo reketa, odbija se pod uglom od 45 stepeni na gore ili dole, respektivno.
3.  Rezultat
    - Kad loptica dođe do leve ili desne ivice ekrana a da se ne odbije od reketa, jedan od igrača dobija poen.
    - Rezultat prikazati na sedmosegmentnom displeju. Na kraju partije, na displeju pobednika nacrtati W a na displeju gubitnika L.
    - Pri inicijalizaciji uređaja i nakon završetka partije, ne počinjati novu partiju odmah. Igrači započinju partiju pomoću nekog od dugmića i prekidača. LFSR inicijalizovati pomoću brojača koji broji vreme od inicijalizacije uređaja do početka partije.

### LED matrica

LED matrica se sastoji od 64 kvadratno raspoređene LED diode. Sve diode
u istom redu imaju zajedničku anodu, a sve diode u istoj koloni imaju
zajedničku katodu (ili obrnuto, zavisno od orijentacije displeja).
Displej ima 16 pinova (8 anoda i 8 katoda). Na našem displeju, negativni
pinovi su obeleženi serijskim brojem. Dovođenjem napona na jedan par
anode i katode se pali LED dioda u njihovom preseku.

Može se primetiti da sa ovakvim sistemom nije moguće istovremeno
paljenje proizvljne kombinacije dioda. Najveći skup dioda koji se može
istovremeno proizvoljno kontrolisati je jedan red (ili kolona).To se
postiže dovođenjem napona na zajedničku anodu tog reda i na katode onih
dioda koje želimo da upalimo.

Da bismo postigli prikazivanje slike preko celog ekrana, neophodno je
vremensko multipleksiranje. Drugim rečima, naizmeničnim paljenjem jednog
po jednog reda i brzim smenjivanjem redova, stvara se iluzija
istovremenog paljenja celog ekrana.

**Napomena:** redosled pinova na displeju ne odgovara nužno
geometrijskom rasporedu dioda. Prvi korak bi bio da saznaš kako su
pinovi raspoređeni, pre nego što pokušaš da prikažeš nešto.
