DROP DATABASE IF EXISTS nbadb;
CREATE DATABASE nbadb;
USE nbadb;

CREATE TABLE Country(
	abbrev char(3),
    coordinates varchar(50),
    name varchar(20),
    currency varchar(4),
    PRIMARY KEY (abbrev)
);


CREATE TABLE HasMascot (
    name varchar(20),
    appearance varchar(30)
);


CREATE TABLE Sponsorships(
    id integer,
    name varchar(20) UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE City(
    id integer,
    abbrev varchar(4),
    name varchar(20),
    coordinates varchar(50),
    gdp INTEGER,
    population INTEGER,
    country char(3),
    PRIMARY KEY (id),
    FOREIGN KEY (country) REFERENCES Country (abbrev)
);

CREATE TABLE TeamPlaysIn (
    id integer,
    cityID integer,
    name varchar(20) UNIQUE,
    logo varchar(20),
    PRIMARY KEY (id, cityID),
    FOREIGN KEY (cityID) REFERENCES City(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE PlayerPlaysFor(
    id integer,
    teamID integer,
    number INTEGER,
    name varchar(20),
    position varchar(3),
    zscore FLOAT,
    PRIMARY KEY (id),
    FOREIGN KEY (teamID) REFERENCES TeamPlaysIn(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Coach(
    id integer,
    name varchar(20),
    years integer,
    specialization varchar(20),
    teamID integer,
    PRIMARY KEY (id),
    FOREIGN KEY (teamID) REFERENCES TeamPlaysIn (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Funds(
    teamID integer,
    sponsorID integer,
    amount integer,
    PRIMARY KEY(teamID, sponsorID),
    FOREIGN KEY (teamID) REFERENCES TeamPlaysIn (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (sponsorID) REFERENCES Sponsorships (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Stadium(
    teamID integer,
    name varchar(24),
    PRIMARY KEY (teamID),
    FOREIGN KEY (teamID) REFERENCES TeamPlaysIn(id)
);

CREATE TABLE Game(
    id integer,
    teamA integer,
    teamB varchar(24),
    winner varchar(24),
    PRIMARY KEY (id),
    FOREIGN KEY (teamA) REFERENCES Stadium(teamID)
);


CREATE TABLE TeamPlaysGame(
    gameID integer,
    teamID integer,
    PRIMARY KEY (gameID, teamID),
    FOREIGN KEY (gameID) REFERENCES Game(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (teamID) REFERENCES TeamPlaysIn(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE SeasonOf(
    year integer,
    teamID integer,
    standing varchar(20),
    PRIMARY KEY (year, teamID),
    FOREIGN KEY (teamID) REFERENCES TeamPlaysIn(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);