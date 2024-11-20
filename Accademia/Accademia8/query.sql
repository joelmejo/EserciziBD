-- 1. Quali sono le persone (id, nome e cognome) che hanno avuto assenze solo nei
-- giorni in cui non avevano alcuna attivitÃ (progettuali o non progettuali)?
WITH ap (
    SELECT a.persona
    FROM Assenza a, AttivitaProgetto ap
    WHERE a.persona = ap.persona
        AND a.giorno = ap.giorno
),
anp (
    SELECT a.persona
    FROM Assenza a, AttivitaNonProgettettuale
    WHERE a.persona = anp.persona
        AND a.giorno = anp.giorno
),

SELECT p.id, p.nome, p.cognome
FROM Persona p, ap, anp
WHERE a.persona not in ap
    AND a.persona not in anp;