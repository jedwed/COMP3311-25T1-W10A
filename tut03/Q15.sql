
CREATE TABLE teams (
    team_name text PRIMARY KEY,
    captain text
);

CREATE TABLE players (
    player_name text PRIMARY KEY,
    plays_for text NOT NULL REFERENCES teams (team_name)
);

ALTER TABLE teams ADD FOREIGN KEY (captain) REFERENCES players (player_name);


CREATE TABLE fans (
    fan_name text PRIMARY KEY
);

CREATE TABLE favourite_players (
    fan_name text REFERENCES fans (fan_name),
    player_name text REFERENCES players (player_name),
    PRIMARY KEY (fan_name, player_name)
);

CREATE TABLE favourite_teams (
    fan_name text REFERENCES fans (fan_name),
    team_name text REFERENCES teams (team_name),
    PRIMARY KEY (fan_name, team_name)
);

CREATE TABLE team_colours (
    team_name text REFERENCES teams (team_name),
    colour text,
    PRIMARY KEY (team_name, colour) 
);

CREATE TABLE favourite_colours (
    fan_name text REFERENCES fans (fan_name),
    colour text,
    PRIMARY KEY (fan_name, colour)
);
