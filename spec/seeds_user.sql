TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (email, password) VALUES ('sebastian@here', 'password1');
INSERT INTO users (email, password) VALUES ('karishma@here', 'password1');
INSERT INTO users (email, password) VALUES ('james@here', 'password1');
INSERT INTO users (email, password) VALUES ('michael@here', 'password1');