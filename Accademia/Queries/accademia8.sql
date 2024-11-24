-- 1. Quali sono le persone (id, nome e cognome) che hanno avuto assenze solo nei
-- giorni in cui non avevano alcuna attività (progettuali o non progettuali)?

With P_Ass_Ap As (
Select a.id
From Assenza a, attivitaProgettuale ap
Where a.persona = ap.persona And
A.giorno = ap.giorno 
), P_Ass_Anp As(
Select a.id
From Assenza a, attivitaNonProgettuale anp
Where a.persona = anp.persona And
A.giorno = anp.giorno
),
Select distinct p.id, p.nome, p.cognome
From persona p, assenza a, P_Ass_Ap pap, P_Ass_Anp panp
Where p.id = a.persona And a.id not in pap And a.id not in panp;

-- 2. Quali sono le persone (id, nome e cognome) che non hanno mai partecipato ad
-- alcun progetto durante la durata del progetto “Pegasus”?

-- 3. Quali sono id, nome, cognome e stipendio dei ricercatori con stipendio maggiore
-- di tutti i professori (associati e ordinari)?

-- 4. Quali sono le persone che hanno lavorato su progetti con un budget superiore alla
-- media dei budget di tutti i progetti?

-- 5. Quali sono i progetti con un budget inferiore allala media, ma con un numero
-- complessivo di ore dedicate alle attività di ricerca sopra la media?