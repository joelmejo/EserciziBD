-- 1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome
-- ‘Pegasus’ ?

select nome, inizio, fine 
from WP
where progetto = (select id from Progetto where nome = 'Pegasus');

-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno
-- una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?

select distinct nome, cognome, posizione
from Persona
where id in (select persona from AttivitaProgetto where progetto =
                (select id from Progetto where nome = 'Pegasus'))
order by cognome DESC;

-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di
-- una attività nel progetto ‘Pegasus’ ?

select nome, cognome, posizione
from Persona
where id in (select persona from AttivitaProgetto where progetto = 
                (select id from Progetto where nome = 'Pegasus')
            group by persona
            having count(*) >= 2);

-- 4. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto almeno una assenza per malattia?

select distinct nome, cognome, posizione
from Persona
where posizione = 'Professore Ordinario' and id in 
    (select persona from Assenza where tipo = 'Malattia');

-- 5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto più di una assenza per malattia?

select nome, cognome, posizione
from Persona
where posizione = 'Professore Ordinario' and id in 
    (select persona from Assenza where tipo = 'Malattia'
    group by persona
    having count(*) >= 2);

-- 6. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno
-- un impegno per didattica?

select distinct nome, cognome, posizione
from Persona
where posizione = 'Ricercatore' and id in
    (select persona from AttivitaNonProgettuale where tipo = 'Didattica');

-- 7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un
-- impegno per didattica?

select nome, cognome, posizione
from Persona
where posizione = 'Ricercatore' and id in
    (select persona from AttivitaNonProgettuale where tipo = 'Didattica'
    group by persona
    having count(id) >= 2);

-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali?

select distinct p.nome, p.cognome
from Persona p
join AttivitaProgetto a on p.id = a.persona
join AttivitaNonProgettuale n on p.id = n.persona and a.giorno = n.giorno;

-- 9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali? Si richiede anche di proiettare il
-- giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di
-- entrambe le attività.

select distinct p.nome, p.cognome, a.giorno, pr.nome as nome_progetto, n.tipo, 
    sum(a.oreDurata + n.oreDurata) as oreDurata
from Persona p
join AttivitaProgetto a on p.id = a.persona
join Progetto pr on a.progetto = pr.id
join AttivitaNonProgettuale n on p.id = n.persona and a.giorno = n.giorno;

-- 10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali?

select distinct p.nome, p.cognome
from Persona p
join AttivitaProgetto a on p.id = a.persona
join Assenza s on p.id = s.persona and a.giorno = s.giorno;

-- 11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il
-- nome del progetto, la causa di assenza e la durata in ore della attività progettuale.

select distinct p.nome, p.cognome, a.giorno, pr.nome as nome_progetto, s.tipo, a.oreDurata
from Persona p
join AttivitaProgetto a on p.id = a.persona
join Progetto pr on a.progetto = pr.id
join Assenza s on p.id = s.persona and a.giorno = s.giorno;

-- 12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?

select w.*
from WP w, WP v
where w.nome = v.nome and w.progetto != v.progetto