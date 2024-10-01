-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi
-- aeroporti?

select a.codice, a.nome, count(distinct ar.comp) as num_compagnie
from aeroporto a, arrpart ar
where a.codice = ar.partenza or a.codice = ar.arrivo
group by a.codice, a.nome;

 codice |                 nome                 | num_compagnie 
--------+--------------------------------------+---------------
 CDG    | Charles de Gaulle, Aeroport de Paris |             2
 CIA    | Aeroporto di Roma Ciampino           |             2
 FCO    | Aeroporto di Roma Fiumicino          |             3
 HTR    | Heathrow Airport, London             |             3
 JFK    | JFK Airport                          |             3
(5 rows)

-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno
-- 100 minuti?

select count(*) as num_voli
from arrpart ar, volo v
where ar.partenza = 'HTR'
    and ar.codice = v.codice
    and v.durataMinuti >= 100;

 num_voli 
----------
        1
(1 row)

-- 3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione
-- nella quale opera?

select l.nazione , count(distinct l.aeroporto) as num_aeroporti
from arrpart ar, luogoAeroporto l
where ar.comp = 'Apitalia'
    and (ar.partenza = l.aeroporto or ar.arrivo = l.aeroporto)
group by l.nazione;

    nazione     | num_aeroporti 
----------------+---------------
 Italy          |             2
 United Kingdom |             1
 USA            |             1
(3 rows)

-- 4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla
-- compagnia ‘MagicFly’ ?

select avg(durataMinuti) as media, min(durataMinuti) as minimo, max(durataMinuti) as massimo
from volo
where comp = 'MagicFly';

        media         | minimo | massimo 
----------------------+--------+---------
 420.0000000000000000 |     60 |     600
(1 row)

-- 5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli
-- aeroporti?

select a.codice, a.nome, min(c.annoFondaz)
from arrpart ar, compagnia c, aeroporto a
where (ar.partenza = a.codice or ar.arrivo = a.codice)
    and c.nome = ar.comp
group by a.codice, a.nome;

 codice |                 nome                 | min  
--------+--------------------------------------+------
 CIA    | Aeroporto di Roma Ciampino           | 1900
 HTR    | Heathrow Airport, London             | 1900
 CDG    | Charles de Gaulle, Aeroport de Paris | 1954
 FCO    | Aeroporto di Roma Fiumicino          | 1900
 JFK    | JFK Airport                          | 1900
(5 rows)

-- 6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più
-- voli?

select lp.nazione, count(distinct la.nazione)
from arrpart ar, luogoAeroporto lp, luogoAeroporto la
where ar.partenza = lp.aeroporto
    and ar.arrivo = la.aeroporto
    and lp.nazione <> la.nazione
group by lp.nazione;

-- 7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?

select a.codice, a.nome, avg(v.durataMinuti)
from arrpart ar, aeroporto a, volo v
where ar.partenza = a.codice
    and ar.codice = v.codice
group by a.codice, a.nome;

 codice |                 nome                 |         avg          
--------+--------------------------------------+----------------------
 CIA    | Aeroporto di Roma Ciampino           | 407.0000000000000000
 HTR    | Heathrow Airport, London             | 105.0000000000000000
 CDG    | Charles de Gaulle, Aeroport de Paris |  60.0000000000000000
 FCO    | Aeroporto di Roma Fiumicino          | 545.5000000000000000
 JFK    | JFK Airport                          | 599.5000000000000000
(5 rows)

-- 8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate
-- a partire dal 1950?

select c.nome, sum(v.durataMinuti) as durata_tot
from arrpart ar, volo v, compagnia c
where c.annoFondaz >= 1950
    and ar.codice = v.codice
    and v.comp = c.nome
group by c.nome;

   nome    | durata_tot 
-----------+------------
 Caimanair |       1043
 MagicFly  |       1260
(2 rows)

-- 9. Quali sono gli aeroporti nei quali operano esattamente due compagnie?

select a.codice, a.nome
from arrpart ar, aeroporto a
where ar.partenza = a.codice or ar.arrivo = a.codice
group by a.codice, a.nome
having count(distinct ar.comp) = 2;

 codice |                 nome                 
--------+--------------------------------------
 CDG    | Charles de Gaulle, Aeroport de Paris
 CIA    | Aeroporto di Roma Ciampino
(2 rows)

-- 10. Quali sono le città con almeno due aeroporti?

select distinct l1.citta
from luogoAeroporto l1, luogoAeroporto l2
where l1.citta = l2.citta
    and l1.aeroporto <> l2.aeroporto;

 citta 
-------
 Roma
(1 row)

-- 11. Qual è il nome delle compagnie i cui voli hanno una durata media maggiore di 6
-- ore?

select c.nome
from compagnia c, volo v
where v.comp = c.nome
group by c.nome
having avg(v.durataMinuti) > 360;

   nome   
----------
 Apitalia
 MagicFly
(2 rows)

-- 12. Qual è il nome delle compagnie i cui voli hanno tutti una durata maggiore di 100
-- minuti?

select c.nome
from compagnia c, volo v
where v.comp = c.nome
group by c.nome
having min(v.durataMinuti) > 100;

   nome   
----------
 Apitalia
(1 row)