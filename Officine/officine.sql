CREATE TABLE Nazione (
    nome varchar not null,
    PRIMARY KEY (nome)
)

CREATE TABLE  Regione (
    nome varchar not null,
    nazione varchar not null,
    PRIMARY KEY (nome, nazione),
    FOREIGN KEY nazione 
        references Nazione(nome)
)

CREATE TABLE Citta (
    nome varchar not null,
    regione varchar not null,
    nazione varchar not null,
    PRIMARY KEY (nome, regione, nazione),
    FOREIGN KEY (regione, nazione)
        references Regione(nome, nazione)
)

CREATE TABLE Marca (
    nome varchar not null,
    PRIMARY KEY (nome)
)

CREATE TABLE TipoVeicolo (
    nome varchar not null,
    PRIMARY KEY (nome)
)

CREATE TABLE Modello (
    nome varchar not null,
    marca varchar not null,
    tipo_veicolo varchar not null,
    PRIMARY KEY (nome, marca),
    FOREIGN KEY marca
        references Marca(nome),
    FOREIGN KEY tipo_veicolo
        references TipoVeicolo(nome)
)

CREATE TABLE Persona (
    cf Codfis not null,
    nome varchar not null,
    indirizzo Indirizzo not null,
    telefono varchar not null,
    citta varchar not null,
    regione varchar not null,
    nazione varchar not null,
    PRIMARY KEY (cf),
    FOREIGN KEY (citta, regione, nazione)
        references Citta(nome, regione, nazione)
)

CREATE TABLE Staff (
    persona Codfis not null,
    PRIMARY KEY (persona),
    FOREIGN KEY persona
        references Persona(cf),
    --v. Incl. persona occorre in Veicolo(cliente) 
)

CREATE TABLE Dipendente (
    persona Codfis not null,
    assunzione date not null,
    officina integer not null,
    PRIMARY KEY(persona),
    FOREIGN KEY persona
        references Staff(persona)
    FOREIGN KEY officina
        references Officina(id)
)

CREATE TABLE Direttore (
    persona Codfis not null,
    nascita date not null,
    PRIMARY KEY(persona),
    FOREIGN KEY persona
        references Staff(persona)
)

CREATE TABLE Cliente (
    persona Codfis not null,
    PRIMARY KEY (persona),
    FOREIGN KEY persona
        references Persona(cf),
    --v. Incl. persona occorre in Veicolo(cliente) 
)

CREATE TABLE Veicolo (
    targa varchar not null,
    immatricolazione integer not null,
    modello varchar not null,
    marca varchar not null,
    cliente Codfis not null,
    PRIMARY KEY (targa),
    FOREIGN KEY (modello, marca)
        references Modello(nome, marca),
    FOREIGN KEY cliente 
        references Cliente(persona)
)

CREATE TABLE Officina (
    id integer not null,
    nome varchar not null,
    indirizzo Indirizzo not null,
    citta varchar not null,
    regione varchar not null,
    nazione varchar not null,
    direttore Codfis not null,
    PRIMARY KEY (id),
    FOREIGN KEY (citta, regione, nazione)
        references Citta(nome, regione, nazione),
    FOREIGN KEY direttore
        references Direttore(persona)
)

CREATE TABLE Riparazione (
    codice integer not null,
    inizio timestamp not null,
    riconsegna timestamp,
    officina integer not null,
    PRIMARY KEY (codice),
    FOREIGN KEY officina
        references Officina(id)
)