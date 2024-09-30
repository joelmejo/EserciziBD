-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi
-- aeroporti?

select a.codice, a.nome, count(distinct ar.comp) as num_compagnie
from aeroporto a, arrpart ar
group by a.codice, a.nome;

-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno
-- 100 minuti?

select count(*)
from arrpart ar, volo v
where ar.partenza = 'HTR'
    and ar.codice = v.codice
    and v.durataMinuti >= 100;

-- 3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione
-- nella quale opera?

select l.nazione , count(*) as num_aeroporti
from arrpart ar, luogoAeroporto l
where ar.comp = 'Apitalia'
    and ar.partenza = l.aeroporto or ar.arrivo = l.aeroporto
group by l.nazione;

-- 4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla
-- compagnia ‘MagicFly’ ?

select avg(durataMinuti) as media, min(durataMinuti) as minimo, max(durataMinuti) as massimo
from volo
where comp = 'MagicFly';

-- 5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli
-- aeroporti?

select a.codice, a.nome, min(c.annoFondaz)
from arrpart ar, compagnia c, aeroporto a
where ar.partenza = a.codice or ar.arrivo = a.codice
group by a.codice, a.nome;

-- 6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più
-- voli?



-- 7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?

select a.codice, a.nome, avg(v.durataMinuti)
from arrpart ar, aeroporto a, volo v
where ar.partenza = a.codice
    and ar.codice = v.codice
group by a.codice, a.nome;

-- 8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate
-- a partire dal 1950?

select sum(v.durataMinuti)
from arrpart ar, volo v, compagnia c
where c.annoFondaz >= 1950
    and ar.codice = v.codice
    and v.comp = c.nome;

-- 9. Quali sono gli aeroporti nei quali operano esattamente due compagnie?

------------
select a.codice, a.nome
from arrpart ar, aeroporto a
where ar.partenza = a.codice or ar.arrivo = a.codice
group by a.codice, a.nome
having count(distinct ar.comp) = 2;
--------------

-- 10. Quali sono le città con almeno due aeroporti?

select distinct l1.citta
from luogoAeroporto l1, luogoAeroporto l2
where l1.citta = l2.citta
    and l1.aeroporto <> l2.aeroporto;

-- 11. Qual è il nome delle compagnie i cui voli hanno una durata media maggiore di 6
-- ore?

select c.nome
from compagnia c, volo v
where v.comp = c.nome
group by c.nome
having avg(v.durataMinuti) > 360;

-- 12. Qual è il nome delle compagnie i cui voli hanno tutti una durata maggiore di 100
-- minuti?

select c.nome
from compagnia c, volo v
where v.comp = c.nome
group by c.nome
having min(v.durataMinuti) > 100;