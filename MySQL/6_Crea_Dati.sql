# Questo script popola il database con un insieme minimo di dati di esempio, 
# sufficienti a verificare il corretto funzionamento delle viste, delle funzioni e delle stored procedure sviluppate.
# I valori inseriti non rappresentano dati reali, ma hanno il solo scopo di facilitare i test 
# e dimostrare il comportamento delle componenti logiche del sistema

USE project_work;

-- Stati prenotazione
delete from PW_STAT_Stati_Prenotazione;
INSERT INTO PW_STAT_Stati_Prenotazione(STAT_Descrizione,stat_id)
VALUES ('Confermata',1);
# Questo script popola il database con un insieme minimo di dati di esempio, 
# sufficienti a verificare il corretto funzionamento delle viste, delle funzioni e delle stored procedure sviluppate.
# I valori inseriti non rappresentano dati reali, 
# ma hanno il solo scopo di facilitare i test e dimostrare il comportamento delle componenti logiche del sistema

-- Tipologie biglietti
delete from PW_TBIG_Tipologia_Biglietti;
INSERT INTO PW_TBIG_Tipologia_Biglietti (TBIG_Descrizione,TBIG_ANNI,TBIG_Perc_sconto,TBIG_ID)
VALUES ('Ordinario', NULL, 0,1),
       ('Over 60', 61, 20,2),
       ('under 10', 10, 20,3);

-- Treni
delete from PW_TREN_Treni;
INSERT INTO PW_TREN_Treni (TREN_modello, TREN_Numero,TREN_ID)
VALUES ('FRECCIA GIALLA 1000', '9568',1),
       ('FRECCIA GIALLA 1000', '9569',2),
       ('FRECCIA GIALLA 500',  '9584',3),
       ('FRECCIA GIALLA 500',  '9585',4);

-- Classi
delete from PW_CLAS_Classi;
INSERT INTO PW_CLAS_Classi (CLAS_Descrizione,CLAS_ID)
VALUES ('Unica',1);

-- Carrozze (per numero treno)
delete from PW_CARR_Carrozze;
INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 1, 1,1 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9568';
INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 2, 1,2 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9568';
INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 3, 1,3 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9568';

INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 1, 1,4 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9569';
INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 2, 1,5 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9569';
INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 3, 1,6 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9569';

INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 1, 1,7 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9585';
INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 2, 1,8 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9585';
INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 3, 1,9 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9585';

INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 1, 1,10 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9584';
INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 2, 1,11 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9584';
INSERT INTO PW_CARR_Carrozze (CARR_TREN_ID, CARR_Num_Posti, CARR_Numero, CARR_CLAS_ID,CARR_ID)
SELECT tt.`TREN_ID`, 20, 3, 1,12 FROM `PW_TREN_Treni` tt WHERE tt.`TREN_Numero` = '9584';

-- Province
delete from PW_PROV_Province;
INSERT INTO PW_PROV_Province (PROV_Descrizione,PROV_ID)
VALUES ('Torino',1),('Milano',2),('Bologna',3),('Firenze',4),('Roma',5),('Napoli',6),('Salerno',7);

-- Comuni
delete from PW_COMU_COMUNI;
INSERT INTO PW_COMU_COMUNI (COMU_DESCRIZIONE, COMU_CAP, COMU_PROV_ID,COMU_ID)
VALUES ('Torino', '1010', 1,1),
       ('Milano', '2010', 2,2),
       ('Bologna','4010', 3,3),
       ('Firenze','5010', 4,4),
       ('Roma',   '0010', 5,5),
       ('Napoli', '8010', 6,6),
       ('Salerno','8410', 7,7);

-- Stazioni
delete from PW_STAZ_Stazioni;
INSERT INTO PW_STAZ_Stazioni (STAZ_Nome, STAZ_Descrizione, STAZ_COMUNI_ID,STAZ_ID)
VALUES ('Torino Stura', NULL, 1,1),
	   ('Torino Porta Nuova', NULL, 1,2),
       ('Torino Porta Susa', NULL, 1,3),
       ('Milano Porta Garibaldi', NULL, 2,4),
       ('Milano Central', NULL, 2,5),
       ('Milano Rogoredo', NULL, 2,6),
       ('Bologna Centrale', NULL, 3,7),
       ('Firenze Campo di Marte', NULL, 4,8),
       ('Firenza Santa Maria Novella', NULL, 4,9),
       ('Roma Tiburtina', NULL, 5,10),
       ('Roma Termini', NULL, 5,11),
       ('Napoli Centrale', NULL, 6,12),
       ('Napoli Afragola', NULL, 6,13),
       ('Salerno Centrale', NULL, 7,14);

-- (facoltativo) verifica
SELECT * FROM `PW_STAZ_Stazioni`;

-- Tratte (direzioni "A → B")
delete from PW_TRAT_Tratte;
INSERT INTO PW_TRAT_Tratte
(TRAT_STAZ_ID_Partenza, TRAT_STAZ_ID_Arrivo, TRAT_Distanza_Km, TRAT_DURATA_PREVISTA, TRAT_COSTO)
VALUES
(2,4,0,0,0),(2,5,0,0,0),(2,6,0,0,0),(2,7,0,0,0),(2,8,0,0,0),
(2,9,0,0,0),(2,10,0,0,0),(2,11,0,0,0),(2,12,0,0,0),(2,13,0,0,0),
(2,14,0,0,0),
(3,4,0,0,0),(3,5,0,0,0),(3,6,0,0,0),(3,7,0,0,0),(3,8,0,0,0),
(3,9,0,0,0),(3,10,0,0,0),(3,11,0,0,0),(3,12,0,0,0),(3,13,0,0,0),
(3,14,0,0,0),
(4,7,0,0,0),(4,8,0,0,0),(4,9,0,0,0),(4,10,0,0,0),(4,11,0,0,0),
(4,12,0,0,0),(4,13,0,0,0),(4,14,0,0,0),
(5,7,0,0,0),(5,8,0,0,0),(5,9,0,0,0),(5,10,0,0,0),(5,11,0,0,0),
(5,12,0,0,0),(5,13,0,0,0),(5,14,0,0,0),
(6,7,0,0,0),(6,8,0,0,0),(6,9,0,0,0),(6,10,0,0,0),(6,11,0,0,0),
(6,12,0,0,0),(6,13,0,0,0),(6,14,0,0,0),
(7,8,0,0,0),(7,9,0,0,0),(7,10,0,0,0),(7,11,0,0,0),(7,12,0,0,0),
(7,13,0,0,0),(7,14,0,0,0),
(8,10,0,0,0),(8,11,0,0,0),(8,12,0,0,0),(8,13,0,0,0),(8,14,0,0,0),
(9,10,0,0,0),(9,11,0,0,0),(9,12,0,0,0),(9,13,0,0,0),(9,14,0,0,0),
(10,12,0,0,0),(10,13,0,0,0),(10,14,0,0,0),
(11,12,0,0,0),(11,13,0,0,0),(11,14,0,0,0),
(12,14,0,0,0),
(13,14,0,0,0);

-- Tratte inverse (B → A)

INSERT INTO `PW_TRAT_Tratte` (`TRAT_STAZ_ID_Partenza`, `TRAT_STAZ_ID_Arrivo`, `TRAT_Distanza_Km`, `TRAT_DURATA_PREVISTA`, `TRAT_COSTO`)
SELECT `TRAT_STAZ_ID_Arrivo`, `TRAT_STAZ_ID_Partenza`, `TRAT_Distanza_Km`, `TRAT_DURATA_PREVISTA`, `TRAT_COSTO`
FROM `PW_TRAT_Tratte`;

-- (facoltativo) verifica
SELECT * FROM `PW_TRAT_Tratte`;

-- Aggiornamenti distanza/durata/costo
UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 100, `TRAT_DURATA_PREVISTA` = 40,  `TRAT_COSTO` = 50
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) <= 2;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 150, `TRAT_DURATA_PREVISTA` = 70,  `TRAT_COSTO` = 80
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 3;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 160, `TRAT_DURATA_PREVISTA` = 70,  `TRAT_COSTO` = 85
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 4;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 200, `TRAT_DURATA_PREVISTA` = 90,  `TRAT_COSTO` = 100
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 5;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 260, `TRAT_DURATA_PREVISTA` = 130, `TRAT_COSTO` = 120
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 6;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 300, `TRAT_DURATA_PREVISTA` = 150, `TRAT_COSTO` = 150
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 7;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 340, `TRAT_DURATA_PREVISTA` = 170, `TRAT_COSTO` = 200
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 8;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 380, `TRAT_DURATA_PREVISTA` = 190, `TRAT_COSTO` = 220
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 9;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 500, `TRAT_DURATA_PREVISTA` = 230, `TRAT_COSTO` = 300
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 10;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 600, `TRAT_DURATA_PREVISTA` = 300, `TRAT_COSTO` = 380
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 11;

UPDATE `PW_TRAT_Tratte`
SET `TRAT_Distanza_Km` = 680, `TRAT_DURATA_PREVISTA` = 320, `TRAT_COSTO` = 390
WHERE ABS(`TRAT_STAZ_ID_Arrivo` - `TRAT_STAZ_ID_Partenza`) = 12;

-- Treni/stazioni di supporto (facoltativi per verifica)
SELECT * FROM `PW_TREN_Treni`;
SELECT * FROM `PW_STAZ_Stazioni`;

-- Orari (usa date ISO 'YYYY-MM-DD')
delete from PW_ORAR_Orari;
INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '06:00', '07:00'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9568'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 2 AND tr.`TRAT_STAZ_ID_Arrivo` = 4;

INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '06:10', '07:00'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9568'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 3 AND tr.`TRAT_STAZ_ID_Arrivo` = 4;

INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '06:00', '07:10'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9568'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 2 AND tr.`TRAT_STAZ_ID_Arrivo` = 5;

INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '06:10', '07:10'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9568'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 3 AND tr.`TRAT_STAZ_ID_Arrivo` = 5;

INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '06:00', '07:20'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9568'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 2 AND tr.`TRAT_STAZ_ID_Arrivo` = 6;

INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '06:10', '07:20'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9568'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 3 AND tr.`TRAT_STAZ_ID_Arrivo` = 6;

INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '06:10', '09:20'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9569'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 2 AND tr.`TRAT_STAZ_ID_Arrivo` = 7;

INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '09:40', '12:20'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9568'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 7 AND tr.`TRAT_STAZ_ID_Arrivo` = 11;

INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '08:40', '11:20'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9569'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 7 AND tr.`TRAT_STAZ_ID_Arrivo` = 11;

INSERT INTO PW_ORAR_Orari
(ORAR_TREN_ID, ORAR_TRAT_ID, ORAR_DATA_Partenza, ORAR_Data_Arrivo, ORAR_Ora_Partenza, ORAR_Ora_Arrivo)
SELECT t1.`TREN_ID`, tr.`TRAT_ID`, '2026-01-01', '2026-01-01', '10:40', '13:20'
FROM `PW_TRAT_Tratte` tr
JOIN `PW_TREN_Treni` t1 ON t1.`TREN_Numero` = '9585'
WHERE tr.`TRAT_STAZ_ID_Partenza` = 7 AND tr.`TRAT_STAZ_ID_Arrivo` = 11;

delete from PW_PASS_Passeggeri;
-- Passeggero di prova
INSERT INTO PW_PASS_Passeggeri
(PASS_nome, PASS_cognome, PASS_ragione_sociale, PASS_partita_iva, PASS_codice_fiscale,
 PASS_Data_Nascita, PASS_telefono, PASS_email, PASS_password_cifrata,
 PASS_COMU_ID_fiscale, PASS_Indirizzo_Fiscale, PASS_Cap_fiscale,
 PASS_COMU_ID_recapito, PASS_Indirizzo_recapito, PASS_Cap_recapito, PASS_Numero_Tessera)
VALUES
('Sara', 'Caruso', NULL, NULL, 'SRACRS189KJ8219L',
 '1978-05-17', '+393455655589', 'Sara_Project_work@gmail.com', 'JJHFDUUE987SKJE0',
 NULL, NULL, NULL, NULL, NULL, NULL, NULL);
