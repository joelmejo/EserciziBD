-- 1)
SELECT DISTINCT cognome
FROM Persona;

-- 2)
SELECT nome, cognome
FROM Persona
WHERE posizione = 'Ricercatore';

-- 3)
SELECT *
FROM Persona
WHERE posizione = 'Professore Associato' and cognome like 'V%';

-- 4)
SELECT *
FROM Persona
WHERE (posizione = 'Professore Associato' or posizione = 'Professore Ordinario') and cognome like 'V%';

-- 5)
SELECT *
FROM Progetto
WHERE fine < CURRENT_DATE;

-- 6)
SELECT nome
FROM Progetto
ORDER BY inizio ASC;

-- 7)
select nome
from WP
order by nome ASC;

-- 8)
SELECT DISTINCT tipo
FROM Assenza;

-- 9)
SELECT DISTINCT tipo
FROM AttivitaProgetto;

-- 10)
SELECT DISTINCT giorno
FROM AttivitaNonProgettuale
WHERE tipo = 'Didattica'
ORDER BY giorno ASC;