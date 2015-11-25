--4) Create an Object_type called marine_animal_ty that has attributes,
-- scientific_name, common_name, max_size, food_preference and
-- geographic_range. Then use this type to re-create both marine_fish and
-- marine_invertebrate tables as in the exam specification (page 1). (10 pts)

PROMPT ================================
PROMPT |        Running Part 4        |
PROMPT ================================

--Note: No sql dependencies

DROP TABLE marine_fish_tb;
DROP TABLE marine_invertebrates_tb;
DROP TYPE marine_animal_ty;

CREATE TYPE marine_animal_ty
AS OBJECT ( scientific_name  VARCHAR(30),
            common_name      VARCHAR(30),
            max_size         NUMBER (5,2),
            food_preference  VARCHAR(30),
            geographic_range VARCHAR(30) );
/

CREATE TABLE marine_fish_tb
    (
      animal_ty marine_animal_ty,
      fish_species VARCHAR(20),
      CONSTRAINT marine_fish_pk PRIMARY KEY (animal_ty.scientific_name)
    );

  CREATE TABLE marine_invertebrates_tb
    (
      animal_ty marine_animal_ty,
      invertebrate_group VARCHAR(30),
      CONSTRAINT marine_invertebrates_pk PRIMARY KEY (animal_ty.scientific_name)
    );

  PROMPT #Testing each table with objects

  INSERT INTO marine_fish_tb VALUES ( marine_animal_ty ('Chaetodon','butterfly fish',22.0,'sea anemones','Atlantic'), 'Percoidea' );
  INSERT INTO marine_fish_tb VALUES ( marine_animal_ty ('Scaridae','parrot fish',50.0,'algae','Indo-Pacific'), 'Labroidei' );
  INSERT INTO marine_invertebrates_tb VALUES ( marine_animal_ty ('Nudibranch','sea slugs',60.0,'algae','intertidal zone'), 'Nudibranchia' );
  INSERT INTO marine_invertebrates_tb VALUES ( marine_animal_ty ('Diadema','black sea urchin',12.0,'algae','Caribbean'), 'Diadematidae' );

  PROMPT #Returning the results
  SELECT * FROM marine_fish_tb;
  SELECT * FROM marine_invertebrates_tb;
