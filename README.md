## Vplyv zmeny sieťových bufferov na HTTP adaptívne streamovanie

#### Autori: Miroslav Procházka, Igor Vereš

Zámerom tohto projektu je overiť výsledky článku[1], teda otestovať ako vplýva veľkosť sieťových bufferov a sieťových radov (queue), medzi **1xDBP** až **30xBDP**(Bandwith delay product), na adaptívne stremovanie cez HTTP (HAS), a to pre scenáre keď v sieti je viacero klientov, ktorí využívajú adaptívne streamovanie cez HTTP a prehliadajú webové stránky. Títo klienti pritom zdieľajú rovnaký “bottleneck”. 

Sieť budeme simulovať pomocou virtuálneho testovacieho nástroja **Mininet** s kontrolerom **Ryu**. V tomto nástroji naimplementujeme “dumbbell” topológiu, ktoréj návrh je zobrazený na Obr. 1. Táto topológia je zvolená kvôli jednoduchšej manipulácii s bandwithom v bottlenecku medzi viacerými zdrojmi a klientami.

Na tejto topológii sú zobrazené dva sieťové prvky (switche), 1 až N HAS klientov a Apache web server, ktorý bude slúžiť ako zdroj video streamu a webových stránok.

Switche v tejto topológii predstavujú “bottleneck” pomocou nastavenia RTT (Round trip time), BW (Bandwith) a Queue Length.

Testované video zdroje uložené na serveri majú variabilitu rozlíšení a dátového toku. Testovacie webové stránky sa rozlišujú množstvom a pomerom textu a multimediálneho obsahu.


![Obr. 1 - Topológia testovacej siete](topology.png?raw=true "Obr. 1 - Topológia testovacej siete")

Niektorí klienti budú prehliadať webové stráky pomocou nástroja “Selenium”, ktorý slúži na automatizovanie prehliadania webových stránok. Iní klienti budú spotrebovávať video stream pomocou klienta “GPAC”, ktorý poskytuje vysoko konfigurovateľnú open-source platformu pre prehrávanie multimediálneho obsahu.

Následne budeme testovať nestabilitu prehrávača, neférovosť, utlizáciu badwithu, stall-y a pre klientov ktorí prehliadajú stránky budeme monitorovať čas načítania stránky a tiež počet opustených stránok (stránka sa nenačítala do 15 sekúnd).

Premenné ktoré sa budú meniť sú: bandwith, RTT a veľkosť video buffera klienta (BDP). Tieto zmeny sa budú vykonávať v “bottleneck-u” siete pomocou nástroja “tc-netem”, ktorý slúži na kontrolu premávky na platforme Linux.

Testovacie paramtetre, ktoré použili autori článku sú zobrazené na Obr. 2.


![Obr. 2 - Parametre pre experiment](parameters.png?raw=true "Obr. 2 - Parametre pre experiment")

Naším cieľom bude vyhodnocovať výsledky na základe týchto zmien, a teda rýchlosti načítania stránok, videí a veľkosti front klientov, ktorý čakajú.

Následne tieto výsledky porovnáme s meraniami, ktoré vekonali autori tohto článku.

Literatúra:

[1] 	D. Raca, A. H. Zahran, and C. J. Sreenan, “Sizing Network Buffers: An HTTP Adaptive Streaming Perspective,” 2016 IEEE 4th International Conference on Future Internet of Things and Cloud Workshops (FiCloudW), 2016.

