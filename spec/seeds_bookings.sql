TRUNCATE TABLE bookings RESTART IDENTITY;

INSERT INTO bookings (approval, listing_id, user_id, check_in, check_out) VALUES (true, 1, 1, '2022-09-15', '2022-09-22');
INSERT INTO bookings (approval, listing_id, user_id, check_in, check_out) VALUES (true, 2, 3, '2022-07-15', '2022-07-22');
INSERT INTO bookings (approval, listing_id, user_id, check_in, check_out) VALUES (false, 3, 4, '2022-06-15', '2022-06-22');

