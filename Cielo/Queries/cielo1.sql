-- 1. Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?
select codice, comp from volo where durataMinuti > 180;

-- codice |   comp    
-- --------+-----------
--     132 | MagicFly
--     263 | Caimanair
--     534 | Apitalia
--    1265 | Apitalia
--      24 | Apitalia
--     134 | MagicFly
--     265 | Caimanair
--     536 | Apitalia
-- (8 rows)

-- 2. Quali sono le compagnie che hanno voli che superano le 3 ore?

select distinct comp from volo where durataMinuti > 180;

--  comp    
-- -----------
--  Caimanair
--  MagicFly
--  Apitalia
-- (3 rows)

-- 3. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto
-- con codice ‘CIA’ ?

select codice, comp from arrpart where partenza = 'CIA';

-- codice |   comp    
-- --------+-----------
--     263 | Caimanair
--     534 | Apitalia
-- (2 rows)

-- 4. Quali sono le compagnie che hanno voli che arrivano all’aeroporto con codice ‘FCO’ ?

select distinct comp from arrpart where arrivo = 'FCO';

--   comp    
-- -----------
--  Apitalia
--  Caimanair
--  MagicFly
-- (3 rows)

-- 5. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto
-- ‘FCO’ e arrivano all’aeroporto ‘JFK’ ?

select distinct codice ,comp from arrpart where partenza = 'FCO' and arrivo = 'JFK';

-- codice |   comp    
-- --------+-----------
--     134 | MagicFly
--     265 | Caimanair
--     536 | Apitalia
-- (3 rows)

-- 6. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ e
-- atterrano all’aeroporto ‘JFK’ ?

select distinct comp from arrpart where partenza = 'FCO' and arrivo = 'JFK';

-- comp    
-- -----------
--  Apitalia
--  Caimanair
--  MagicFly
-- (3 rows)

-- 7. Quali sono i nomi delle compagnie che hanno voli diretti dalla città di ‘Roma’
-- alla città di ‘New York’ ?

select distinct comp from arrpart where partenza in (select aeroporto from luogoaeroporto where citta = 'Roma') and arrivo in (select aeroporto from luogoaeroporto where citta = 'New York');

--  comp    
-- -----------
--  Apitalia
--  Caimanair
--  MagicFly
-- (3 rows)

-- 8. Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali partono voli
-- della compagnia di nome ‘MagicFly’ ?

select distinct a.codice, a.nome, l.citta from aeroporto a, luogoaeroporto l where a.codice = l.aeroporto and a.codice in (select distinct partenza from arrpart where comp = 'MagicFly');

--  codice |            nome             |  citta   
-- --------+-----------------------------+----------
--  FCO    | Aeroporto di Roma Fiumicino | Roma
--  HTR    | Heathrow Airport, London    | London
--  JFK    | JFK Airport                 | New York
-- (3 rows)

-- 9. Quali sono i voli che partono da un qualunque aeroporto della città di ‘Roma’ e
-- atterrano ad un qualunque aeroporto della città di ‘New York’ ? Restituire: codice
-- del volo, nome della compagnia, e aeroporti di partenza e arrivo.

select * from arrpart where partenza in (select aeroporto from luogoaeroporto where citta = 'Roma') and arrivo in (select aeroporto from luogoaeroporto where citta = 'New York');

--  codice |   comp    | arrivo | partenza 
-- --------+-----------+--------+----------
--     534 | Apitalia  | JFK    | CIA
--     134 | MagicFly  | JFK    | FCO
--     265 | Caimanair | JFK    | FCO
--     536 | Apitalia  | JFK    | FCO
-- (4 rows)

-- 10. Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo
-- voli della stessa compagnia) da un qualunque aeroporto della città di ‘Roma’ ad un
-- qualunque aeroporto della città di ‘New York’ ? Restituire: nome della compagnia,
-- codici dei voli, e aeroporti di partenza, scalo e arrivo.

select arr1.comp, arr1.codice, arr1.partenza, arr1.arrivo as scalo, arr2.codice, arr2.arrivo from arrpart arr1, arrpart arr2
    where (arr1.partenza in (select aeroporto from luogoaeroporto where citta = 'Roma') and arr1.arrivo not in 
        (select aeroporto from luogoaeroporto where citta = 'New York')) and (arr1.arrivo = arr2.partenza and arr2.arrivo in 
        (select aeroporto from luogoaeroporto where citta = 'New York')) and (arr1.comp = arr2.comp);

-- 11. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’,
-- atterrano all’aeroporto ‘JFK’, e di cui si conosce l’anno di fondazione?

select comp from arrpart where comp in (select nome from compagnia) and partenza = 'FCO' and arrivo = 'JFK';

--    comp    
-- -----------
--  MagicFly
--  Caimanair
--  Apitalia
-- (3 rows)