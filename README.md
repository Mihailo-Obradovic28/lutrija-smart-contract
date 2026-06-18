# 🎰 Lutrija — Ethereum Smart Contract

**Predmet:** Distribuirano programiranje  
**Student:** Mihailo Obradovic

## Opis 

Decentralizovana lutrija implementirana kao pametni ugovor na Ethereum blockchain mreži u Solidity-u. Igrači učestvuju uplatom određenog iznosa ETH, nakon čega vlasnik pokreće izbor nasumičnog pobednika koji osvaja celokupan fond.

## Promenljive

- **vlasnik** — adresa naloga koji je deployovao ugovor
- **igraci** — niz adresa svih prijavljenih učesnika
- **cenaUlaznice** — iznos u wei koji svaki igrač mora uplatiti

## Funkcije

- **constructor(uint _cenaUlaznice)** — postavlja vlasnika i cenu ulaznice pri deploymentu
- **ucestvuj()** — payable funkcija za prijavu igrača uz uplatu ETH
- **izaberiPobednika()** — dostupna samo vlasniku; bira nasumičnog pobednika i šalje mu ceo balans
- **brojIgraca()** — vraća trenutni broj prijavljenih igrača
- **getStanje()** — vraća trenutni balans ugovora u wei

## Testiranje u Remix IDE

1. Ugovor deployovan sa cenom ulaznice od 0.01 ETH
2. Dva testna naloga su se prijavila funkcijom ucestvuj()
3. getStanje() vratio 0.02 ETH
4. Vlasnik pokrenuo izaberiPobednika() — pobednik primio 0.02 ETH, lista resetovana

## Napomena o nasumičnosti

Koristi keccak256 sa block.timestamp i block.prevrandao kao izvorima entropije. Za produkcijsku upotrebu preporučuje se Chainlink VRF.
