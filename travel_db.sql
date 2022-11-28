DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS trip_companion;
DROP TABLE IF EXISTS transport_device;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS trip_x_trip_companion;
DROP TABLE IF EXISTS trip_x_transport_device;
DROP TABLE IF EXISTS trip_x_city;
DROP TABLE IF EXISTS trip_x_country;

CREATE TABLE trip
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    trip_begin DATE,
    trip_end   DATE
);

CREATE TABLE trip_companion
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(20),
    last_name  varchar(20),
    nickname   varchar(20),
    birthday   DATE
);

CREATE TABLE transport_device
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(50) NOT NULL
);

CREATE TABLE country
(
    id               INT PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(50) NOT NULL,
    note             TEXT,
    population_count INT
);

CREATE TABLE city
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(50) NOT NULL
);

CREATE TABLE trip_x_trip_companion
(
    id                INT PRIMARY KEY AUTO_INCREMENT,
    trip_id           INT NOT NULL,
    trip_companion_id INT NOT NULL,
    FOREIGN KEY (trip_id) REFERENCES trip(id),
    FOREIGN KEY (trip_companion_id) REFERENCES trip_companion(id)
);

CREATE TABLE trip_x_transport_device
(
    id                  INT PRIMARY KEY AUTO_INCREMENT,
    trip_id             INT NOT NULL,
    transport_device_id INT NOT NULL,
    FOREIGN KEY (trip_id) REFERENCES trip(id),
    FOREIGN KEY (transport_device_id) REFERENCES transport_device(id)
);

CREATE TABLE trip_x_country
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    trip_id    INT NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (trip_id) REFERENCES trip(id),
    FOREIGN KEY (country_id) REFERENCES country(id)
);

CREATE TABLE trip_x_city
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    trip_id INT NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (trip_id) REFERENCES trip(id),
    FOREIGN KEY (city_id) REFERENCES city(id)
);