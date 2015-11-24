-- Populate with arbitrary values for the table

PROMPT ================================
PROMPT |      Generating Values       |
PROMPT ================================

-- Insert to marine_dish table
--Notes: max_size is in cm
--All values here are dummy values and do not reflect actual data (Family class is not right just arbitrary values)
INSERT INTO marine_fish VALUES ('Chaetodon','butterfly fish','Percoidea',22.0,'sea anemones','Atlantic');
INSERT INTO marine_fish VALUES ('Scaridae','parrot fish','Labroidei',50.0,'algae','Indo-Pacific');
INSERT INTO marine_fish VALUES ('Amblyglyphidodon','Maldives damselfish','Pomacentridae',8.3,'zooplankton','Indian Ocean');
INSERT INTO marine_fish VALUES ('Zebrasoma','yellow tang','Acanthuridae',20.0,'benthic','Indo-Pacific');
INSERT INTO marine_fish VALUES ('Batrachoididae','toad fish','Batrachoidiformes',7.5,'sea worms','Amazon River');
INSERT INTO marine_fish VALUES ('Holacanthus','queen angelfish','Pomacanthidae',45.0,'sponges','caribean');
INSERT INTO marine_fish VALUES ('Synchiropus','mandarinfish','Callionymidae',15.7,'ostracods','Indo-Pacific');
INSERT INTO marine_fish VALUES ('Antennarius','striated frogfish',' 	Antennariidae',22.0,'Carnivore','Indian Ocean');
INSERT INTO marine_fish VALUES ('Scorpaenopsis','tasseled scorpionfish','Scorpaenidae',35.0,'Carnivor','Indian Ocean');
INSERT INTO marine_fish VALUES ('Gobiidae','goby','Gobiodei',30.0,'algae','Atlandic');

-- Insert to add_fish table
INSERT INTO add_fish VALUES ('Chaetodon',TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO add_fish VALUES ('Scaridae',TO_DATE('2004/03/07 01:05:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO add_fish VALUES ('Amblyglyphidodon',TO_DATE('2005/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO add_fish VALUES ('Zebrasoma',TO_DATE('2006/04/05 18:20:45', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO add_fish VALUES ('Batrachoididae',TO_DATE('2007/05/20 12:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO add_fish VALUES ('Holacanthus',TO_DATE('2008/04/03 05:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO add_fish VALUES ('Synchiropus',TO_DATE('2009/11/03 11:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO add_fish VALUES ('Antennarius',TO_DATE('2010/06/03 08:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO add_fish VALUES ('Scorpaenopsis',TO_DATE('2011/12/03 12:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO add_fish VALUES ('Gobiidae',TO_DATE('2012/12/12 12:12:12', 'yyyy/mm/dd hh24:mi:ss'));

-- Insert to order_organism
INSERT INTO order_organism VALUES ('Chaetodon',20,TO_DATE('2003/06/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO order_organism VALUES ('Scaridae',10,TO_DATE('2004/08/07 01:05:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO order_organism VALUES ('Amblyglyphidodon',15,TO_DATE('2005/08/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO order_organism VALUES ('Zebrasoma',50,TO_DATE('2005/04/05 18:20:45', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO order_organism VALUES ('Batrachoididae',20,TO_DATE('2008/05/20 12:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO order_organism VALUES ('Holacanthus',25,TO_DATE('2009/04/03 05:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO order_organism VALUES ('Synchiropus',15,TO_DATE('2010/11/03 11:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO order_organism VALUES ('Antennarius',10,TO_DATE('2011/12/12 12:12:12', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO order_organism VALUES ('Scorpaenopsis',12,TO_DATE('2012/12/12 12:12:12', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO order_organism VALUES ('Gobiidae',13,TO_DATE('2012/12/12 12:12:12', 'yyyy/mm/dd hh24:mi:ss'));

-- Insert to marine_invertebrates
INSERT INTO marine_invertebrates VALUES ('Nudibranch','sea slugs','Nudibranchia',60.0,'algae','intertidal zone');
INSERT INTO marine_invertebrates VALUES ('Diadema','black sea urchin','Diadematidae',12.0,'algae','Caribbean');

-- Insert to aquatic_organism_stock
INSERT INTO aquatic_organism_stock VALUES (1000,'Chaetodon',10,8.99);
INSERT INTO aquatic_organism_stock VALUES (1001,'Scaridae',5,15.99);
INSERT INTO aquatic_organism_stock VALUES (1002,'Amblyglyphidodon',8,20.99);
INSERT INTO aquatic_organism_stock VALUES (1003,'Zebrasoma',4,5.99);
INSERT INTO aquatic_organism_stock VALUES (1004,'Batrachoididae',11,11.99);
INSERT INTO aquatic_organism_stock VALUES (1005,'Holacanthus',7,25.99);
INSERT INTO aquatic_organism_stock VALUES (1006,'Synchiropus',0,50);
INSERT INTO aquatic_organism_stock VALUES (1007,'Antennarius',2,45);
INSERT INTO aquatic_organism_stock VALUES (1008,'Scorpaenopsis',0,2.50);
INSERT INTO aquatic_organism_stock VALUES (1009,'Gobiidae',0,1.99);
INSERT INTO aquatic_organism_stock VALUES (2000,'Nudibranch',5,16.99);
INSERT INTO aquatic_organism_stock VALUES (2001,'Diadema',8,11.99);
