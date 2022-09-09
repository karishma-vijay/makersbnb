TRUNCATE TABLE listings RESTART IDENTITY;

INSERT INTO listings (name, description, date_from, date_to, price, user_id) VALUES ('bnb1', 'nice', '2022-09-09', '2022-10-09', 75.00, 1);
INSERT INTO listings (name, description, date_from, date_to, price, user_id) VALUES ('bnb2', 'cosy', '2022-07-09', '2022-08-09', 125.00, 2);
INSERT INTO listings (name, description, date_from, date_to, price, user_id) VALUES ('bnb3', 'fun', '2022-06-09', '2022-07-09', 100.00, 3);
