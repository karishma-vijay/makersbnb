CREATE TABLE users(
id SERIAL PRIMARY KEY,
email text,
password text)
; 

CREATE TABLE listings
    (id SERIAL PRIMARY KEY,
    name text,
    description text,
    price decimal(15,2),
    date_from DATE,
    date_to DATE,
    user_id int,
    constraint fk_user foreign key(user_id)
        references users(id)
        on delete cascade
    );

CREATE TABLE bookings
    (id SERIAL PRIMARY KEY,
    approval boolean,
    listing_id int,
    user_id int,
    check_in DATE,
    check_out DATE,
    constraint fk_listing_id foreign key(listing_id)
        references listings(id)
        on delete cascade,
    constraint fk_user foreign key(user_id)
        references users(id)
        on delete cascade
    );