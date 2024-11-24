\echo '1) Quali sono i cognomi distinti di tutti gli strutturati?\n'

select distinct cognome
from Persona;


\echo '2) Quali sono i Ricercatori (con nome e cognome)?\n'

select id, nome, cognome
from Persona
where posizione = 'Ricercatore';


\echo '3) Quali sono i Professori Associati il cui cognome\n   comincia con la lettera ''V''?\n'

select id, nome, cognome
from Persona
where posizione = 'Professore Associato'
  and cognome like 'V%';


\echo '4) Quali sono i Professori (sia Associati che Ordinari)\n   il cui cognome comincia con la lettera ''V''?\n'

select id, nome, cognome
from Persona
where posizione in ('Professore Associato', 'Professore Ordinario')
  -- L'operatore 'in' può essere usato per decidere se il valore dell'attributo
  -- 'posizione' è tra quelli di una lista ordinata di valori separati da virgole.
  -- Vedremo altri usi dell'operatore 'in' più avanti.
  and cognome like 'V%';


\echo '5) Quali sono i Progetti gia'' terminati alla data odierna?\n'

select *
from Progetto
where fine < CURRENT_DATE;


\echo '6) Quali sono i nomi di tutti i Progetti ordinati in ordine\n   crescente di data di inizio?\n'

select id, nome
from Progetto
order by inizio asc;


\echo '7) Quali sono i nomi dei WP ordinati in ordine crescente\n   (per nome)?\n'

select id, nome
from WP
order by nome asc;


\echo '8) Quali sono (distinte) le cause di assenza di tutti\n   gli strutturati?\n'

select distinct tipo
from Assenza;


\echo '9) Quali sono (distinte) le tipologie di attivita'' di\n   progetto di tutti gli strutturati?\n'

select distinct tipo
from AttivitaProgetto;


\echo '10) Quali sono i giorni distinti nei quali del personale\n    ha effettuato attivita'' non progettuali di tipo ''Didattica''?\n    Dare il risultato in ordine crescente.\n'

select distinct giorno
from AttivitaNonProgettuale
where tipo = 'Didattica'
order by giorno;