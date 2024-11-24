\echo '1) Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome "Pegasus"?\n'


select wp.id, wp.nome, wp.inizio, wp.fine
from wp, progetto p
where wp.progetto = p.id
	and p.nome = 'Pegasus';


\echo '2) Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una attività nel progetto "Pegasus", ordinati per cognome decrescente?\n'

select distinct s.id, s.nome, s.cognome, s.posizione
from attivitaprogetto ap, progetto p, persona s
where ap.progetto = p.id 
	and ap.persona = s.id
	and p.nome = 'Pegasus';


\echo '2) Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di una attività nel progetto "Pegasus"?\n'

-- equivalente: Quali sono il nome, il cognome e la posizione degli strutturati che
-- hanno almeno due attività distinte nel progetto 'Pegasus'?

-- equivalente: Quali sono il nome, il cognome e la posizione degli strutturati che
-- hanno almeno una coppia di attività distinte nel progetto 'Pegasus'?


select distinct s.id, s.nome, s.cognome, s.posizione
from attivitaprogetto a1, attivitaprogetto a2, persona s, progetto p
where a1.id <> a2.id 
	and a1.progetto = a2.progetto
	and a1.persona = a2.persona
	and a1.persona = s.id
	and a1.progetto = p.id
	and p.nome = 'Pegasus';


\echo '4) Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto almeno una assenza per malattia?n'
select distinct s.id, nome, cognome, posizione 
from assenza a, persona s
where a.persona = s.id
	and tipo = 'Malattia' 
	and posizione = 'Professore Ordinario';


\echo '5) Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto più di una assenza per malattia?\n'

select distinct s.id, s.nome, s.cognome
from persona s, assenza a1, assenza a2
where a1.persona = s.id
        and a2.persona = s.id
        and a1.id <> a2.id
        and a1.tipo = 'Malattia'
        and a2.tipo = 'Malattia'
        and s.posizione = 'Professore Ordinario';

\echo '6) Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno un impegno per didattica?\n'

select distinct p.id, p.nome, p.cognome
from persona p, attivitanonprogettuale a
where p.id = a.persona
	and a.tipo = 'Didattica'
	and p.posizione = 'Ricercatore';

\echo '7)  Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un impegno per didattica?\n'

select distinct s.id, s.nome, s.cognome
from persona s, attivitanonprogettuale anp1, attivitanonprogettuale anp2
where anp1.id <> anp2.id
	and anp1.tipo = 'Didattica'
	and anp2.tipo = 'Didattica'
	and anp1.persona = s.id
	and anp2.persona = s.id
	and s.posizione = 'Ricercatore';

\echo '8)  Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali?\n'

select distinct p.id, p.nome, p.cognome
from persona p, attivitaprogetto ap, attivitanonprogettuale anp
where
	p.id = ap.persona
	and p.id = anp.persona
	and ap.giorno = anp.giorno;

\echo '9) Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di entrambe le attività.\n'

select distinct 
	p.id, p.nome, p.cognome, 
	ap.giorno as giorno,
	pr.nome as prj, 
	ap.oredurata as h_prj,
	anp.tipo as att_noprj,
	anp.oredurata as h_noprj
from persona p, attivitaprogetto ap, attivitanonprogettuale anp, progetto pr 
where
	p.id = ap.persona
	and p.id = anp.persona
	and ap.giorno = anp.giorno
	and ap.progetto = pr.id;


\echo '10) Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali?\n'
select distinct s.id, s.nome, s.cognome
from persona s, attivitaprogetto ap, assenza asse
where s.id = ap.persona
	and asse.persona = s.id
	and ap.giorno = asse.giorno;


\echo '11) Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, la causa di assenza e la durata in ore della attività progettuale.\n'

select s.id, s.nome, s.cognome, 
	ap.giorno,
	asse.tipo as causa_assenza,
	pr.nome as progetto,
	ap.oredurata as ore_att_prj
from persona s, attivitaprogetto ap, assenza asse, progetto pr
where s.id = ap.persona
	and asse.persona = s.id
	and ap.giorno = asse.giorno
	and pr.id = ap.progetto;

\echo '12) Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?\n'

select distinct w.nome as nome
from wp w, wp v
where w.nome = v.nome
	and w.progetto <> v.progetto;