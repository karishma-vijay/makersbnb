TRUNCATE TABLE users, listings, bookings RESTART IDENTITY;

INSERT INTO users (email, password) VALUES ('sebastian@here', 'password1');
INSERT INTO users (email, password) VALUES ('karishma@here', 'password1');
INSERT INTO users (email, password) VALUES ('james@here', 'password1');
INSERT INTO users (email, password) VALUES ('michael@here', 'password1');

INSERT INTO listings (name, description, date_from, date_to, price, user_id) VALUES ('bnb1', 'nice', '2022-09-09', '2022-10-09', 75.00, 1);
INSERT INTO listings (name, description, date_from, date_to, price, user_id) VALUES ('bnb2', 'cosy', '2022-07-09', '2022-08-09', 125.00, 2);
INSERT INTO listings (name, description, date_from, date_to, price, user_id) VALUES ('bnb3', 'fun', '2022-06-09', '2022-07-09', 100.00, 3);

INSERT INTO bookings (approval, listing_id, user_id, check_in, check_out) VALUES (true, 1, 1, '2022-09-15', '2022-09-22');
INSERT INTO bookings (approval, listing_id, user_id, check_in, check_out) VALUES (true, 2, 3, '2022-07-15', '2022-07-22');
INSERT INTO bookings (approval, listing_id, user_id, check_in, check_out) VALUES (false, 3, 4, '2022-06-15', '2022-06-22');

