USE project_work;
DELIMITER $$

CREATE  FUNCTION project_work.`PW_Num_posti_liberi`(
    idOrario INT,
    idTratta INT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE NumPostiTOT INT DEFAULT 0;
    DECLARE NumPostiOCCUPATI INT DEFAULT 0;

    -- Posti totali
    SELECT IFNULL(SUM(pcc.CARR_Num_Posti), 0)
      INTO NumPostiTOT
      FROM `PW_ORAR_Orari` AS poo
      JOIN `PW_TREN_Treni` AS ptt
        ON poo.ORAR_TREN_ID = ptt.TREN_ID
      JOIN `PW_CARR_Carrozze` AS pcc
        ON ptt.TREN_ID = pcc.CARR_TREN_ID
     WHERE poo.ORAR_ID = idOrario
       AND poo.ORAR_TRAT_ID = idTratta;

    -- Posti occupati (biglietti emessi su quell’orario e tratta)
    SELECT IFNULL(COUNT(*), 0)
      INTO NumPostiOCCUPATI
      FROM `PW_BIOR_Bieglietti_Orari` AS bbo
      JOIN `PW_ORAR_Orari` AS poo
        ON bbo.BIOR_ORAR_ID = poo.ORAR_ID
     WHERE poo.ORAR_ID = idOrario
       AND poo.ORAR_TRAT_ID = idTratta;

    RETURN IFNULL(NumPostiTOT - NumPostiOCCUPATI, 0);
END$$

DELIMITER ;
