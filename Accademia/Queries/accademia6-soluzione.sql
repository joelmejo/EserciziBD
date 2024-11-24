--1 Quanti sono gli strutturati di ogni fascia?

select posizione, count(*) as numero
from persona
group by posizione;

--2 Quanti sono gli strutturati con stipendio ≥ 40000?

select count(*) as numero
from persona
where stipendio >= 40000;

--3 Quanti sono i progetti già finiti che superano il budget di 50000?
select count(*) as numero
from progetto
where budget > 50000
	and fine <= 'current_date';

--4. Qual è la media, il massimo e il minimo delle ore delle attività relative 
	-- al progetto ‘Pegasus’ ?
select avg(oredurata) as media, max(oredurata) as massimo, min(oredurata) as minimo
from progetto p, attivitaprogetto ap
where ap.progetto = p.id 
	and p.nome = 'Pegasus';


-- Query 5-9 lasciate come esercizio



--10
select pro.nome as progetto
from Progetto pro, AttivitaProgetto ap
where pro.id = ap.progetto
group by pro.nome
having count(distinct ap.persona) >= 2;


-- 11) Quali sono i professori associati che hanno lavorato
-- su piu ’ di un progetto?
select p.id, p.nome, p.cognome 
from persona p, attivitaprogetto ap
where p.id = ap.persona
	and p.posizione = 'Professore Associato'
group by p.id, p.nome, p.cognome
having count(distinct ap.progetto) > 1;




