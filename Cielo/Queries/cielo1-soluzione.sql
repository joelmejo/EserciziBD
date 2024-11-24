--1 Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?
select volo.codice, volo.comp
from volo
where volo.durataminuti > 180;


--2 Quali sono le compagnie che hanno voli che superano le 3 ore?

select distinct comp
from volo
where durataminuti > 180;


--3 Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto 
-- con codice ‘CIA’ ?

select codice, comp
from arrpart
where partenza = 'CIA';


--4 Quali sono le compagnie che hanno voli che arrivano all’aeroporto 
-- con codice ‘FCO’ ?

select distinct comp
from arrpart
where arrivo = 'FCO';


--5 Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto ‘FCO’
-- e arrivano all’aeroporto ‘JFK’ ?

select codice, comp
from arrpart
where partenza = 'FCO'
	and arrivo = 'JFK';


-- 6  Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ 
-- e atterrano all’aeroporto ‘JFK’ ?

select distinct comp
from arrpart
where partenza = 'FCO'
	and arrivo = 'JFK';


--7 Quali sono i nomi delle compagnie che hanno voli diretti dalla città di 
--‘Roma’ alla città di ‘New York’ ?
select *
from arrpart a, luogoaeroporto lp, luogoaeroporto la
where 
	a.partenza = lp.aeroporto and 
	a.arrivo = la.aeroporto and
	lp.citta = 'Roma' and
	la.citta = 'New York';


-- alternativa, con join
select *
from arrpart a
	join luogoaeroporto lp
		on a.partenza = lp.aeroporto
	join luogoaeroporto la
		on a.arrivo = la.aeroporto
where 
	lp.citta = 'Roma' and
	la.citta = 'New York';


--8 Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali 
-- partono voli della compagnia di nome ‘MagicFly’ ?

select distinct 
	ap.codice as codiceIATA, 
	ap.nome as aeroporto, 
	lap.citta, 
	lap.nazione
from arrpart a, aeroporto ap, luogoaeroporto lap
where comp = 'MagicFly'
	and a.partenza = ap.codice
	and ap.codice = lap.aeroporto;

-- alternativa con join

select distinct 
	ap.codice as codiceIATA, 
	ap.nome as aeroporto, 
	lap.citta, 
	lap.nazione
from arrpart a
	join aeroporto ap
		on a.partenza = ap.codice
	join luogoaeroporto lap
		on ap.codice = lap.aeroporto
where comp = 'MagicFly';


--9 Quali sono i voli che partono da un qualunque aeroporto della città di ‘Roma’ e
-- atterrano ad un qualunque aeroporto della città di ‘New York’ ? Restituire: codice
-- del volo, nome della compagnia, e aeroporti di partenza e arrivo.

select ap.codice, ap.comp, ap.partenza, ap.arrivo
from arrpart ap, luogoaeroporto lap, luogoaeroporto laa
where ap.partenza = lap.aeroporto
	and ap.arrivo = laa.aeroporto
	and lap.citta = 'Roma'
	and laa.citta = 'New York';


--10  Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo
-- voli della stessa compagnia) da un qualunque aeroporto della città di ‘Roma’ ad un
-- qualunque aeroporto della città di ‘New York’? Restituire: nome della compagnia,
-- codici dei voli, e aeroporti di partenza, scalo e arrivo.


-- primo volo (compagnia e aeroporti di partenza e arrivo) -> arrpart
-- luogo dell'aeroporto di partenza del primo volo -> luogoaeroporto
-- secondo volo (compagnia e aeroporti di partenza e arrivo) -> arrpart
-- luogo dell'aeroporto di partenza del secondo volo -> luogoaeroporto


select v1.comp as compagnia, 
	v1.codice as volo1, 
	v2.codice as volo2, 
	v1.partenza as partenza, 
	v1.arrivo as scalo, 
	v2.arrivo as arrivo
from arrpart v1, arrpart v2, luogoaeroporto lap, luogoaeroporto laa
where v1.arrivo = v2.partenza 
	and v1.comp = v2.comp
	and v1.partenza = lap.aeroporto 
	and v2.arrivo = laa.aeroporto 
	and lap.citta = 'Roma' 
	and laa.citta = 'New York';

-- 11 Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’, 
-- atterrano all’aeroporto ‘JFK’, e di cui si conosce l’anno di fondazione?
select distinct comp from arrpart
v, compagnia c where partenza = 'FCO' and arrivo = 'JFK'
and c.nome = v.comp and c.annofondaz is not null;