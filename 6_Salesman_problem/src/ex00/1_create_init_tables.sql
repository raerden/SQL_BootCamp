CREATE TABLE IF NOT EXISTS cities
    (id SERIAL PRIMARY KEY,
    city VARCHAR(30) NOT NULL UNIQUE);

INSERT INTO cities (city) VALUES 
    ('a'),
    ('b'),
    ('c'),
    ('d');

CREATE TABLE IF NOT EXISTS costs
    (id SERIAL PRIMARY KEY,
    point1 INTEGER NOT NULL,
    point2 INTEGER NOT NULL,
    cost BIGINT,
    CONSTRAINT fk_costs_point1 FOREIGN KEY (point1) REFERENCES cities(id),
    CONSTRAINT fk_costs_point2 FOREIGN KEY (point2) REFERENCES cities(id));

INSERT INTO costs (point1, point2, cost) VALUES
    (1, 2, 10),
    (1, 3, 15),
    (1, 4, 20),
    (2, 3, 35),
    (2, 4, 25),
    (3, 4, 30);