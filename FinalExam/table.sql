-- Generate the tables required for exam

PROMPT ================================
PROMPT |      Generating Tables       |
PROMPT ================================

--Remove old tables
DROP TABLE marine_fish;
DROP TABLE add_fish;
DROP TABLE order_organism;
DROP TABLE marine_invertebrates;
DROP TABLE aquatic_organism_stock;
--Create tables
CREATE TABLE marine_fish
  (
    scientific_name  VARCHAR(30) PRIMARY KEY,
    common_name      VARCHAR(30),
    fish_species     VARCHAR(20),
    max_size         NUMBER (5,2),
    food_preference  VARCHAR(30),
    geographic_range VARCHAR(30)
  );
CREATE TABLE add_fish
  (
    scientific_name VARCHAR(30) PRIMARY KEY,
    add_date        DATE
  );
CREATE TABLE order_organism
  (
    scientific_name VARCHAR(30),
    quantity        NUMBER,
    order_date      DATE
  );
CREATE TABLE marine_invertebrates
  (
    scientific_name    VARCHAR(30) PRIMARY KEY,
    common_name        VARCHAR(30),
    invertebrate_group VARCHAR(30),
    max_size           NUMBER (5,2),
    food_preference    VARCHAR(30),
    geographic_range   VARCHAR(30)
  );
CREATE TABLE aquatic_organism_stock
  (
    stock_id        NUMBER CONSTRAINT aquatic_organism_stock_id_pk PRIMARY KEY,
    scientific_name VARCHAR(30),
    number_in_stock NUMBER,
    current_price   NUMBER(5,2)
  );
