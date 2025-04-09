CREATE TABLE users (
    user_id serial,
    username text,
    password text,
    balance numeric
);

INSERT INTO users (username, password, balance) VALUES ('user1', 'password1', 5002.30);
INSERT INTO users (username, password, balance) VALUES ('user2', 'password2', 1001.30);
INSERT INTO users (username, password, balance) VALUES ('user3', 'password3', 2003.30);
INSERT INTO users (username, password, balance) VALUES ('user4', 'verysecurepasswordihopethisdoesntgetleaked', 9999.30);
