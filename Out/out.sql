CREATE TABLE Nazione (
    nome varchar PRIMARY KEY not null,
);

CREATE TABLE Regione (
    nome varchar not null,
    nazione varchar not null,
    PRIMARY KEY (nome, nazione),
    FOREIGN KEY nazione
        references Nazione(nome)
);

CREATE TABLE Citta (
    nome varchar not null,
    regione varchar not null,
    nazione varchar not null,
    PRIMARY KEY (regione, nazione)
        references Regione(nome, nazione)
);

CREATE TABLE Sede (
    id serial PRIMARY KEY not null,
    nome varchar not null,
    indirizzo Indirizzo not null,
    citta varchar not null,
    regione varchar not null,
    nazione varchar not null,
    FOREIGN KEY (citta, regione, nazione)
        references Citta(nome, regione, nazione)
);--v.incl id occorre in Sala(sede)

CREATE TABLE Sala (
    id serial PRIMARY KEY not null,
    nome varchar unique not null,
    sede integer not null,
    unique (nome, sede)
    FOREIGN KEY (sede)
        references Sede(id)
);--v.incl id occorre in Settore(sala)

CREATE TABLE Settore (
    id serial PRIMARY KEY not null,
    nome varchar not null,
    sala integer not null,
    sede integer not null,
    unique (nome, sala, sede)
    FOREIGN KEY sala
        references Sala(id)
);--v.incl id occorre in Posto(settore)

CREATE TABLE Posto (
    fila integer not null,
    colonna integer not null,
    settore integer unique not null,
    PRIMARY KEY (fila, colonna, settore),
    FOREIGN KEY settore
        references Settore(id)
);

CREATE TABLE Utente (
    nome varchar not null,
    cognome varchar not null,
    cf CodFis primary key not null
);

CREATE TABLE Genere (
    nome varchar primary key not null
);

CREATE TABLE Artista (
    id serial primary key not null,
    nome varchar not null,
    cognome varchar not null,
    nome_arte varchar
);

CREATE TABLE TipologiaSpettacolo (
    nome varchar primary key not null
);

CREATE TABLE Spettacolo (
    id serial primary key not null,
    nome varchar not null,
    durata_min integer not null,
    tipo varchar not null,
    genere varchar not null,
    FOREIGN KEY tipo
        references TipologiaSpettacolo(nome)
    FOREIGN KEY genere
        references Genere(nome)
);--v.incl id occorre in partecipa(spettacolo)

CREATE TABLE partecipa (
    artista integer not null,
    spettacolo integer not null,
    PRIMARY KEY (artista, spettacolo)
    FOREIGN KEY artista
        references Artista(id)
    FOREIGN KEY spettacolo
        references(id)
);

CREATE TABLE Evento (
    id serial primary key not null,
    data date not null,
    orario time not null,
    sala integer not null
);--v.incl id occorre in Tariffa(evento)

CREATE TABLE TipoTariffa (
    nome varchar primary key not null
);

CREATE TABLE Prenotazione (
    id serial primary key not null,
    istante timestamp not null,
    evento integer not null,
    utente CodFis not null,
    FOREIGN KEY evento
        references Evento(id),
    FOREIGN KEY utente
        references Utente(cf)
);--v.incl id occorre in pre_posto(prenotazione)

CREATE TABLE pre_posto (
    prenotazione integer not null,
    tipo_tariffa varchar not null,
    fila integer not null,
    colonna integer not null,
    settore integer not null,
    PRIMARY KEY (prenotazione, fila, colonna, settore)
    FOREIGN KEY prenotazione
        references Prenotazione(id)
    FOREIGN KEY tipo_tariffa
        references TipoTariffa(nome)
    FOREIGN KEY (fila, colonna, settore)
        references Posto(fila, colonna, settore)
);

CREATE TABLE Tariffa (
    id serial not null,
    prezzo Denaro not null,
    tipo_tariffa varchar not null,
    evento integer not null,
    settore integer not null,
    PRIMARY KEY (id, evento)
    unique (id, tipo_tariffa)
    unique (id, settore)
    FOREIGN KEY tipo_tariffa
        references TipoTariffa(nome)
    FOREIGN KEY evento
        references Evento(id),
    FOREIGN KEY settore
        references Settore(id)
);