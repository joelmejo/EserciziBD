-- 1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome
-- ‘Pegasus’ ?

-- MIA SOLUZIONE
-- select nome, inizio, fine 
-- from WP
-- where progetto = (select id from Progetto where nome = 'Pegasus');

select wp.nome, wp.inizio, wp.fine
from WP, Progetto p
where WP.progetto = p.id and p.nome = 'Pegasus';

--  nome |   inizio   |    fine    
-- ------+------------+------------
--  WP1  | 2012-01-01 | 2012-12-31
--  WP2  | 2012-01-01 | 2012-12-31
--  WP3  | 2013-01-01 | 2013-12-31
-- (3 rows)


-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno
-- una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?

-- MIA SOLUZIONE
-- select distinct nome, cognome, posizione
-- from Persona
-- where id in (select persona from AttivitaProgetto where progetto =
--                 (select id from Progetto where nome = 'Pegasus'))
-- order by cognome DESC;

select distinct s.nome, s.cognome, s.posizione
from AttivitaProgetto ap, Progetto p, Persona s
where ap.progetto = p.id and p.nome = 'Pegasus';

--    nome    |   cognome   |      posizione       
-- -----------+-------------+----------------------
--  Fiorella  | Martino     | Professore Associato
--  Ginevra   | Riva        | Professore Ordinario
--  Mario     | Rossi       | Ricercatore
--  Carla     | Martinelli  | Ricercatore
--  Andrea    | Verona      | Professore Associato
--  Silvia    | Donati      | Professore Ordinario
--  Paolo     | Valentini   | Professore Associato
--  Asia      | Giordano    | Professore Ordinario
--  Consolata | Ferrari     | Professore Associato
--  Guido     | Spensierato | Professore Associato
--  Davide    | Quadro      | Professore Ordinario
--  Anna      | Bianchi     | Ricercatore
--  Barbara   | Burso       | Ricercatore
--  Dario     | Basile      | Ricercatore
--  Emilio    | Greco       | Professore Associato
--  Aurora    | Bianchi     | Professore Associato
--  Carlo     | Zante       | Professore Ordinario
--  Elisa     | Longo       | Professore Associato
--  Gino      | Spada       | Ricercatore
--  Giulia    | Costa       | Ricercatore
--  Leonardo  | Vitali      | Professore Ordinario
-- (21 rows)


-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di
-- una attività nel progetto ‘Pegasus’ ?


-- SOLUZIONE TROVATA GRAZIE AD INTERNET
-- select nome, cognome, posizione
-- from Persona
-- where id in (select persona from AttivitaProgetto where progetto = 
--             (select id from Progetto where nome = 'Pegasus')
--             group by persona
--             having count(*) >= 2);


-- RISCRITTA
-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno 2
-- attività nel progetto ‘Pegasus’ ?

-- RISCRITTA
-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una
-- coppia di attività nel progetto ‘Pegasus’ ?

select distinct s.id, s.nome, s.cognome, s.posizione
from AttivitaProgetto a1, AttivitaProgetto a2, Persona s, Progetto p
where a1.id <> a2.id 
    and a1.progetto = a2.progetto 
    and a1.persona = a2.persona 
    and a1.persona = s.id 
    and a1.progetto = p.id
    and p.nome = 'Pegasus'; 

-- 4. Quali sono il nome, il cognome dei Professori Ordinari che hanno
-- fatto almeno una assenza per malattia?

-- MIA SOLUZIONE
-- select distinct nome, cognome, posizione
-- from Persona
-- where posizione = 'Professore Ordinario' and id in 
--     (select persona from Assenza where tipo = 'Malattia');

select s.id, s.nome, s.cognome
from assenza a, persona s
where a.persona = s.id
    and a.tipo = 'Malattia'
    and s.posizione = 'Professore Ordinario';

-- 5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto più di una assenza per malattia?

-- SOLUZIONE TROVATA GRAZIE AD INTERNET
-- select nome, cognome, posizione
-- from Persona
-- where posizione = 'Professore Ordinario' and id in 
--     (select persona from Assenza where tipo = 'Malattia'
--     group by persona
--     having count(*) >= 2);

select distinct s.id, s.nome, s.cognome
from persona s, assenza a1, assenza a2
where a1.persona = s.id
    and a2.persona = s.id
    and a1.id <> a2.id
    and a1.tipo = 'Malattia'
    and a2.tipo = 'Malattia'
    and s.posizione = 'Professore Ordinario';

--  id |  nome   | cognome 
-- ----+---------+---------
--  10 | Ginevra | Riva
-- (1 row)

-- 6. Quali sono il nome, il cognome dei Ricercatori che hanno almeno
-- un impegno per didattica?

select distinct s.id, s.nome, s.cognome
from Persona s, AttivitaNonProgettuale anp
where s.posizione = 'Ricercatore' 
    and  anp.tipo = 'Didattica'
    and anp.persona = s.id;

--  id |  nome   | cognome 
-- ----+---------+---------
--   0 | Anna    | Bianchi
--   1 | Mario   | Rossi
--   2 | Barbara | Burso
-- (3 rows)


-- 7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un
-- impegno per didattica?

-- SOLUZIONE TROVATA GRAZIE AD INTERNET
-- select nome, cognome, posizione
-- from Persona
-- where posizione = 'Ricercatore' and id in
--     (select persona from AttivitaNonProgettuale where tipo = 'Didattica'
--     group by persona
--     having count(id) >= 2);

select distinct s.nome, s.cognome, s.posizione
from persona s, AttivitaNonProgettuale anp1, AttivitaNonProgettuale anp2
where anp1.id <> anp2.id
    and s.posizione = 'Ricercatore'
    and anp1.tipo = 'Didattica'
    and anp2.tipo = 'Didattica'
    and anp1.persona = s.id
    and anp2.persona = s.id;

-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali?

-- select distinct p.nome, p.cognome
-- from Persona p
-- join AttivitaProgetto a on p.id = a.persona
-- join AttivitaNonProgettuale n on p.id = n.persona and a.giorno = n.giorno;

select distinct s.id, s.nome, s.cognome
from persona s, AttivitaProgetto ap, AttivitaNonProgettuale anp
where s.id = ap.persona
    and s.id = anp.persona
    and ap.giorno = anp.giorno;

-- 9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali? Si richiede anche di proiettare il
-- giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di
-- entrambe le attività.

select distinct 
    p.id as pers, p.nome as Nome, p.cognome as Cognome,
    pr.nome as prog_nome,
    anp.tipo as tipo,
    ap.oreDurata as durata_ap,
    anp.oreDurata as durata_anp,
    ap.giorno as giorno
from persona p, AttivitaProgetto ap, AttivitaNonProgettuale anp, progetto pr
where p.id = ap.persona
    and p.id = anp.persona
    and ap.giorno = anp.giorno
    and ap.progetto = pr.id;


-- 10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali?

select distinct s.id, s.nome, s.cognome
from persona s, AttivitaProgetto ap, assenza asse
where s.id = ap.persona
    and asse.persona = s.id
    and ap.giorno = asse.giorno;

-- 11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il
-- nome del progetto, la causa di assenza e la durata in ore della attività progettuale.

select s.id, s.nome, s.cognome,
    pr.nome,
    ap.giorno,
    asse.tipo,
    ap.oreDurata
from persona s, AttivitaProgetto ap, assenza asse, progetto pr
where s.id = ap.persona
    and asse.persona = s.id
    and ap.giorno = asse.giorno
    and pr.id = ap.progetto;

-- 12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?

select w.*
from WP w, WP v
where w.nome = v.nome and w.progetto <> v.progetto;