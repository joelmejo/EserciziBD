-- 1. Quanti sono gli strutturati di ogni fascia?

select posizione, count(*)
from persona
group by posizione;

--       posizione       | count 
-- ----------------------+-------
--  Professore Ordinario |     6
--  Professore Associato |     8
--  Ricercatore          |     7
-- (3 rows)

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?

select count(*)
from persona
where stipendio >= 40000

-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?

select count(*)
from progetto
where fine < CURRENT_DATE and budget > 50000

-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto
-- ‘Pegasus’ ?

select avg(ap.oreDurata) as mediaOre, max(ap.oreDurata) as massimoOre, min(ap.oreDurata) as minimoOre
from progetto p, attivitaProgetto ap
where ap.progetto = p.id and p.nome = 'Pegasus'

-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto
-- ‘Pegasus’ da ogni singolo docente?

select s.id, s.nome, s.cognome, avg(oreDurata) as mediaOre, max(oreDurata) as massimoOre, min(oreDurata) as minimoOre
from persona s, attivitaProgetto ap, progetto p
where p.nome = 'Pegasus' 
    and p.id = ap.progetto
    and ap.persona = s.id
group by s.nome, s.cognome

-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?

select s.id, s.nome, s.cognome, sum(oreDurata)
from persona s, attivitanonprogettuale anp
where anp.tipo = 'Didattica'
    and anp.persona = s.id

-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?

select avg(stipendio) as media, max(stipendio) as massimo, min(stipendio) as minimo
from persona
where posizione = 'Ricercatore'

-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori
-- associati e dei professori ordinari?

select posizione, avg(stipendio) as mediaStipendio, max(stipendio) as massimoStipendio, min(stipendio) as minimoStipendio
from persona
group by posizione

-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?

select p.id, p.nome, sum(oreDurata)
from persona s, progetto p, attivitaProgetto ap
where s.nome = 'Ginevra'
    and s.cognome = 'Riva'
    and s.id = ap.persona
    and ap.progetto = p.id
group by p.id, p.nome

-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?

select distinct p.id, p.nome
from progetto p, attivitaProgetto ap1, attivitaProgetto ap2
where p.id = ap1.progetto
    and p.id = ap2.progetto
    and ap1.persona <> ap2.persona

-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?

select s.id, s.nome, s.cognome
from persona s, attivitaProgetto ap1, attivitaProgetto ap2
where ap1.persona = ap2.persona
    and s.id = ap1.persona
    and ap1.progetto <> ap2.progetto