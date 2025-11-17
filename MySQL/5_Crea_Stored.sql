USE project_work;

DROP PROCEDURE IF EXISTS `ACQUISTA_BIGLIETTO`;
DELIMITER //

CREATE PROCEDURE `ACQUISTA_BIGLIETTO`(
    IN  p_ID_Stazione_Partenza INT,
    IN  p_ID_Stazione_Arrivo   INT,
    IN  p_ID_Orario            INT,
    IN  p_ID_Passeggero        INT,
    IN  p_ID_Tipo_Biglietto    INT,
    IN  p_numPasseggeri        INT,
    OUT p_BIT_ACQUISTO_EFFETTUATO TINYINT,
    OUT p_MESSAGGIO            VARCHAR(255)
)
proc:BEGIN
    -- =========================
    -- DICHIARAZIONI (sempre all’inizio)
    -- =========================
    DECLARE v_NUM_POSTI_LIBERI INT DEFAULT 0;
    DECLARE v_i                 INT DEFAULT 1;
    DECLARE v_done              TINYINT DEFAULT 0;

    DECLARE v_CUR_ID_ORARIO INT;
    DECLARE v_CUR_ID_TRATTA INT;

    DECLARE v_ID_ORARIO_BIGLIETTO INT;
    DECLARE v_ID_TRATTA_BIGLIETTO INT;
    DECLARE v_COSTO_BIGLIETTO     DECIMAL(19,4) DEFAULT 0.0;
    DECLARE v_PREN_ID             INT;
    DECLARE v_BIGL_ID             INT;
    DECLARE v_PERC_SCONTO         DECIMAL(18,2) DEFAULT 0.0;
    DECLARE v_prev_arrivo TIME;
	DECLARE v_numPasseggeri INT DEFAULT 0;
    -- Cursore 1: per verifica disponibilità
    DECLARE cur_check CURSOR FOR
        SELECT ORAR_ID, TRAT_ID FROM tmp_appo_calcola_tratta;

    -- Cursore 2: per emissione biglietti
    DECLARE cur_emit CURSOR FOR
        SELECT ORAR_ID, TRAT_ID, TRAT_COSTO FROM tmp_appo_calcola_tratta;

    -- Handler per fine cursore
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    -- Handler errori (rollback + messaggio)
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK;
        SET p_BIT_ACQUISTO_EFFETTUATO = 0;
        SET p_MESSAGGIO = 'Errore durante l\'acquisto (transazione annullata).';
    END;
    




    -- =========================
    -- LOGICA
    -- =========================
    SET p_BIT_ACQUISTO_EFFETTUATO = 0;
    SET p_MESSAGGIO = '';


	-- appena inizia la logica:
	SET v_numPasseggeri = GREATEST(0, CAST(COALESCE(p_numPasseggeri,0) AS UNSIGNED));

	-- guardia (facoltativa ma utile)
	IF v_numPasseggeri < 1 THEN
	  SET p_BIT_ACQUISTO_EFFETTUATO = 0;
	  SET p_MESSAGGIO = 'Numero passeggeri non valido (NULL o < 1)';
	  LEAVE proc;
	END IF;

    -- Temp table
    DROP TEMPORARY TABLE IF EXISTS tmp_appo_calcola_tratta;
    CREATE TEMPORARY TABLE tmp_appo_calcola_tratta (
        ORAR_ID INT,
        TRAT_ID INT,
        TRAT_COSTO DECIMAL(19,4),
        ORAR_Ora_Arrivo TIME
    ) ENGINE=Memory;

    -- Segmento di partenza
    -- 1) Primo inserimento (partenza)
INSERT INTO tmp_appo_calcola_tratta (ORAR_ID, TRAT_ID, TRAT_COSTO, ORAR_Ora_Arrivo)
SELECT oo.ORAR_ID, ptt.TRAT_ID, ptt.TRAT_COSTO, oo.ORAR_Ora_Arrivo
FROM `PW_TRAT_Tratte` AS ptt
JOIN `PW_ORAR_Orari` AS oo
  ON oo.ORAR_TRAT_ID = ptt.TRAT_ID
WHERE ptt.TRAT_STAZ_ID_Partenza = p_ID_Stazione_Partenza
  AND oo.ORAR_ID = p_ID_Orario;

-- 2) Leggi l'ora di arrivo del primo segmento in una variabile

SELECT ORAR_Ora_Arrivo
INTO v_prev_arrivo
FROM tmp_appo_calcola_tratta
LIMIT 1;

-- 3) Secondo inserimento (arrivo) usando la variabile al posto della subquery
INSERT INTO tmp_appo_calcola_tratta (ORAR_ID, TRAT_ID, TRAT_COSTO, ORAR_Ora_Arrivo)
SELECT poo.ORAR_ID, ptt.TRAT_ID, ptt.TRAT_COSTO, poo.ORAR_Ora_Arrivo
FROM `PW_TRAT_Tratte` AS ptt
JOIN `PW_ORAR_Orari` AS poo
  ON ptt.TRAT_ID = poo.ORAR_TRAT_ID
WHERE ptt.TRAT_STAZ_ID_Arrivo = p_ID_Stazione_Arrivo
  AND poo.ORAR_Ora_Partenza > v_prev_arrivo
ORDER BY poo.ORAR_Ora_Partenza
LIMIT 1;


    -- ===== Verifica disponibilità (cursore 1) =====
    SET v_done = 0;
    OPEN cur_check;
    read_check: LOOP
        FETCH cur_check INTO v_CUR_ID_ORARIO, v_CUR_ID_TRATTA;
        IF v_done = 1 THEN
            LEAVE read_check;
        END IF;

        SET v_NUM_POSTI_LIBERI = project_work.`PW_Num_posti_liberi`(v_CUR_ID_ORARIO, v_CUR_ID_TRATTA);
        IF v_NUM_POSTI_LIBERI < p_numPasseggeri THEN
            CLOSE cur_check;
            SET p_MESSAGGIO = 'Non esistono posti liberi per la soluzione di viaggio desiderata.';
            LEAVE proc;  -- esci dall’intera procedura
        END IF;
    END LOOP;
    CLOSE cur_check;

    -- ===== Transazione di acquisto =====
    START TRANSACTION;

    INSERT INTO `PW_PREN_Prenotazioni` (PREN_PASS_ID, PREN_Data_Prenotazione, PREN_STAT_ID)
    VALUES (p_ID_Passeggero, NOW(), 1);
    SET v_PREN_ID = LAST_INSERT_ID();

    SELECT COALESCE(TBIG_Perc_sconto, 0.0)
      INTO v_PERC_SCONTO
      FROM `PW_TBIG_Tipologia_Biglietti`
     WHERE TBIG_ID = p_ID_Tipo_Biglietto;

    -- Emissione biglietti (cursore 2)
    SET v_done = 0;
    OPEN cur_emit;
    emit_loop: LOOP
        FETCH cur_emit INTO v_ID_ORARIO_BIGLIETTO, v_ID_TRATTA_BIGLIETTO, v_COSTO_BIGLIETTO;
        IF v_done = 1 THEN
            LEAVE emit_loop;
        END IF;

        SET v_COSTO_BIGLIETTO = v_COSTO_BIGLIETTO - ((v_COSTO_BIGLIETTO / 100.0) * v_PERC_SCONTO);

        SET v_i = 1;
        WHILE v_i <= p_numPasseggeri DO
            INSERT INTO `PW_BIGL_Biglietti` (BIGL_PREN_ID, BIGL_TBIG_ID, BIGL_Prezzo, BIGL_QR_Code)
            VALUES (v_PREN_ID, p_ID_Tipo_Biglietto, v_COSTO_BIGLIETTO, NULL);
            SET v_BIGL_ID = LAST_INSERT_ID();

            INSERT INTO `PW_BIOR_Bieglietti_Orari` (BIOR_BIGL_ID, BIOR_ORAR_ID)
            VALUES (v_BIGL_ID, v_ID_ORARIO_BIGLIETTO);

            SET v_i = v_i + 1;
        END WHILE;
    END LOOP;
    CLOSE cur_emit;

    -- Messaggio finale
    SELECT 
        CONCAT(
            'Acquisto effettuato con successo per la soluzione desiderata. Partenza da ', ssPartenza.STAZ_Nome,
            ' il ', DATE_FORMAT(poo.ORAR_DATA_Partenza, '%d/%m/%Y'),
            ' alle ', TIME_FORMAT(poo.ORAR_Ora_Partenza, '%H:%i'),
            ' con destinazione ', ssArrivo.STAZ_Nome,
            '. Arrivo previsto il giorno ', DATE_FORMAT(poo.ORAR_Data_Arrivo, '%d/%m/%Y'),
            ' alle ore ', TIME_FORMAT(poo.ORAR_Ora_Arrivo, '%H:%i')
        )
    INTO p_MESSAGGIO
    FROM `PW_ORAR_Orari` AS poo
    JOIN `PW_TRAT_Tratte` AS ptt
      ON poo.ORAR_TRAT_ID = ptt.TRAT_ID
    JOIN `PW_STAZ_Stazioni` AS ssPartenza
      ON ptt.TRAT_STAZ_ID_Partenza = ssPartenza.STAZ_Id
    JOIN `PW_STAZ_Stazioni` AS ssArrivo
      ON ptt.TRAT_STAZ_ID_Arrivo = ssArrivo.STAZ_Id
    WHERE poo.ORAR_ID = p_ID_Orario
    LIMIT 1;

    COMMIT;

    SET p_BIT_ACQUISTO_EFFETTUATO = 1;
END//

DELIMITER ;
