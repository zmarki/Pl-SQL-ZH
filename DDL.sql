
CREATE TABLE termek(
termek_ID VARCHAR2(10),
termek_name VARCHAR2(20),
netto_ár NUMBER(4)
);
ALTER TABLE termek
ADD CONSTRAINT termek_pk
    PRIMARY KEY (termek_id);

CREATE TABLE alapa_tipus(
tipus_id VARCHAR2(10),
tipus_name VARCHAR2(20),
helyseg VARCHAR2(20)
);

ALTER TABLE alapa_tipus
ADD CONSTRAINT alapa_tipus_pk
    PRIMARY KEY (tipus_id);

CREATE TABLE hasznal(
termek_id varchar(10),
alapa_id Number(6),
mennyit INT
);

CREATE TABLE alapanyag(
alapa_id NUMBER(6),
alapa_name VARCHAR2(30),
me_egység VARCHAR(11),
mennyiseg NUMBER(6),
tipus_id VARCHAR2(10)
);

ALTER TABLE alapanyag
ADD CONSTRAINT alapanyag_pk
    PRIMARY KEY (alapa_id);

    
ALTER TABLE alapanyag
ADD CONSTRAINT alapa_alapatip_fk
  FOREIGN KEY (tipus_id)
  REFERENCES alapa_tipus(tipus_id);

ALTER TABLE hasznal
ADD CONSTRAINT hasznal_termek_fk
  FOREIGN KEY (termek_id)
  REFERENCES termek(termek_id);

ALTER TABLE hasznal
ADD CONSTRAINT hasznal_alapa_fk
  FOREIGN KEY (alapa_id)
  REFERENCES alapanyag(alapa_id);
  
ALTER TABLE hasznal
ADD CONSTRAINT hasznal_pk
    PRIMARY KEY (termek_id, alapa_id);

create or replace view alapa_nez as select alapa_name as alapanyag, tipus_name as tipus from alapanyag inner join alapa_tipus USING(tipus_id);

create table naplo (id number(8), mod_date date, mod_user VARCHAR(100), mod_alapa_id number not null, mod_alapa_name varchar2(30), mod_tipus varchar(20),
old_mennyiség number(8), new_mennyiség number(8));

ALTER TABLE naplo
ADD CONSTRAINT naplo_pk
    PRIMARY KEY (id);
    
Insert into alapa_tipus  (tipus_id,tipus_name,helyseg) values ('HUTO','hideg árú','hûtõ');
Insert into alapa_tipus  (tipus_id,tipus_name,helyseg) values ('RAKI','száraz árú','raktár');
Insert into alapa_tipus  (tipus_id,tipus_name,helyseg) values ('PULT','darab árú','pult');
Insert into alapa_tipus  (tipus_id,tipus_name,helyseg) values ('PINC','Borok','pince');
Insert into alapa_tipus  (tipus_id,tipus_name,helyseg) values ('HUTO2','Tejtermék','Tejes hûtõ');
Insert into alapa_tipus  (tipus_id,tipus_name,helyseg) values ('HUTO3','Hús árú','Húsos hûtõ');

Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('1', 'Tojás', 'db', '10', 'HUTO');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('2', 'Túrós batyu', 'db', '10', 'PULT');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('3', 'Csokis Croissant', 'db', '7', 'PULT');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('4', 'Marha comb', 'g', '5000', 'HUTO3');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('5', 'Sertés oldalas', 'g', '2300', 'HUTO3');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('6', 'Tej', 'cl', '24000', 'HUTO2');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('7', 'Laktozmentes tej', 'cl', '1000', 'HUTO2');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('8', 'St.Andrea Aligvárom', 'dl', '15', 'PULT');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('9', 'Laposa 4hegy', 'dl', '30', 'PULT');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('10', 'CocaCola 0,25', 'db', '24', 'PULT');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('11', 'Kakukfû', 'g', '100', 'RAKI');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('12', 'Burgonya', 'g', '5000', 'RAKI');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('13', 'Pirospaprika', 'g', '500', 'RAKI');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('14', 'Bors', 'g', '254', 'RAKI');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('15', 'Kávé', 'g', '30000', 'RAKI');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('16', 'Csemege uborka', 'g', '230', 'HUTO');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('17', 'Marlenka', 'db', '12', 'HUTO');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('18', 'Kakaós csiga', 'db', '5', 'PULT');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('19', 'Csomag kávé 200g-os', 'db', '3', 'PULT');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('20', 'Liszt', 'g', '10000', 'RAKI');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('21', 'Hagyma', 'g', '1500', 'RAKI');
Insert INTO alapanyag (alapa_id, alapa_name, me_egység, mennyiseg, tipus_id) VALUES ('22', 'Csicseri borso', 'g', '2500', 'RAKI');


INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('LEV01', 'Harira', '900'); 
INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('LEV02', 'Marhagulyás', '800'); 
INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('LEV03', 'Halászlé', '1100'); 
INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('FOZ01', 'Borso fõzelék', '600'); 
INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('FOZ02', 'Krumpli fõzelék', '500'); 
INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('KV01', 'Latte', '700'); 
INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('KV02', 'Flat White', '900'); 
INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('KV03', 'Ír kávé', '1200');
INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('MEN01', 'BBQ oldalas', '2200'); 
INSERT INTO termek (termek_id, termek_name, netto_ár) VALUES ('MEN02', 'Marhapofa ragú', '3200'); 


INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('1','LEV01','200');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('12','LEV01','100');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('21','LEV01','200');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('22','LEV01','350');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('22','LEV03','150');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('4','LEV03','500');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('13','LEV03','10');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('20','FOZ01','100');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('20','FOZ02','100');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('15','KV01','8');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('6','KV01','200');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('15','KV02','19');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('6','KV02','180');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('15','KV03','15');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('5','MEN01','500');
INSERT INTO hasznal (alapa_id,termek_id, mennyit) VALUES ('4','MEN02','500');

