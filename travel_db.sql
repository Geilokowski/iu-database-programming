SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS journey;
DROP TABLE IF EXISTS journey_companion;
DROP TABLE IF EXISTS transport_device;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS journey_x_journey_companion;
DROP TABLE IF EXISTS journey_x_transport_device;
DROP TABLE IF EXISTS journey_x_city;
DROP TABLE IF EXISTS journey_x_country;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE journey
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    journey_begin DATE,
    journey_end   DATE
);

CREATE TABLE journey_companion
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
    id         INT PRIMARY KEY AUTO_INCREMENT,
    city_name  VARCHAR(50) NOT NULL,
    country_id INT         NOT NULL,
    CONSTRAINT city_country_fk FOREIGN KEY (country_id) REFERENCES country (id)
);

CREATE TABLE journey_x_journey_companion
(
    id                   INT PRIMARY KEY AUTO_INCREMENT,
    journey_id           INT NOT NULL,
    journey_companion_id INT NOT NULL,
    CONSTRAINT journey_x_journey_companion_journey_fk FOREIGN KEY (journey_id) REFERENCES journey (id),
    CONSTRAINT journey_x_journey_companion_journey_companion_fk FOREIGN KEY (journey_companion_id) REFERENCES journey_companion (id)
);

CREATE TABLE journey_x_transport_device
(
    id                  INT PRIMARY KEY AUTO_INCREMENT,
    journey_id          INT NOT NULL,
    transport_device_id INT NOT NULL,
    CONSTRAINT journey_x_transport_journey_fk FOREIGN KEY (journey_id) REFERENCES journey (id),
    CONSTRAINT journey_x_transport_transport_device_fk FOREIGN KEY (transport_device_id) REFERENCES transport_device (id)
);

CREATE TABLE journey_x_country
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    journey_id INT NOT NULL,
    country_id INT NOT NULL,
    CONSTRAINT journey_x_country_journey_fk FOREIGN KEY (journey_id) REFERENCES journey (id),
    CONSTRAINT journey_x_country_country_fk FOREIGN KEY (country_id) REFERENCES country (id)
);

CREATE TABLE journey_x_city
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    journey_id INT NOT NULL,
    city_id    INT NOT NULL,
    CONSTRAINT journey_x_city_journey_fk FOREIGN KEY (journey_id) REFERENCES journey (id),
    CONSTRAINT journey_x_city_city_fk FOREIGN KEY (city_id) REFERENCES city (id)
);