USE project_work;

CREATE OR REPLACE VIEW `PW_VI_ELENCO_ORARI` AS
SELECT 
    poo.`ORAR_ID`,
    Staz_Partenza.`STAZ_Id`   AS `STAZ_ID_Partenza`,
    Staz_Partenza.`STAZ_Nome` AS `Partenza`,
    Staz_Arrivo.`STAZ_Id`     AS `STAZ_ID_Arrivo`,
    Staz_Arrivo.`STAZ_Nome`   AS `Arrivo`,
    poo.`ORAR_DATA_Partenza`,
    poo.`ORAR_Ora_Partenza`,
    poo.`ORAR_Data_Arrivo`,
    poo.`ORAR_Ora_Arrivo`,
    ptt.`TREN_Numero`,
    project_work.`PW_Num_posti_liberi`(poo.`ORAR_ID`, ptt1.`TRAT_ID`) AS `NunPostiLiberi`
FROM project_work.`PW_TREN_Treni`   AS ptt
INNER JOIN project_work.`PW_ORAR_Orari` AS poo 
    ON ptt.`TREN_ID` = poo.`ORAR_TREN_ID`
INNER JOIN project_work.`PW_TRAT_Tratte` AS ptt1 
    ON poo.`ORAR_TRAT_ID` = ptt1.`TRAT_ID`
INNER JOIN project_work.`PW_STAZ_Stazioni` AS Staz_Partenza 
    ON ptt1.`TRAT_STAZ_ID_Partenza` = Staz_Partenza.`STAZ_Id`
INNER JOIN project_work.`PW_STAZ_Stazioni` AS Staz_Arrivo
    ON ptt1.`TRAT_STAZ_ID_Arrivo` = Staz_Arrivo.`STAZ_Id`;
