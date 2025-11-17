USE project_work;
CREATE OR REPLACE VIEW  `project_work`.`pw_vi_elenco_prenotazioni` AS
    SELECT 
        `project_work`.`pw_pren_prenotazioni`.`PREN_ID` AS `PREN_ID`,
        IFNULL(`project_work`.`pw_pass_passeggeri`.`PASS_ragione_sociale`,
                CONCAT(`project_work`.`pw_pass_passeggeri`.`PASS_nome`,
                        ' ',
                        `project_work`.`pw_pass_passeggeri`.`PASS_cognome`)) AS `Nominativo`,
        `project_work`.`pw_pren_prenotazioni`.`PREN_Data_Prenotazione` AS `PREN_Data_Prenotazione`,
        `project_work`.`pw_tren_treni`.`TREN_Numero` AS `TREN_Numero`,
        `project_work`.`pw_orar_orari`.`ORAR_DATA_Partenza` AS `ORAR_DATA_Partenza`,
        `project_work`.`pw_orar_orari`.`ORAR_Ora_Partenza` AS `ORAR_Ora_Partenza`,
        `project_work`.`pw_orar_orari`.`ORAR_Data_Arrivo` AS `ORAR_Data_Arrivo`,
        `project_work`.`pw_orar_orari`.`ORAR_Ora_Arrivo` AS `ORAR_Ora_Arrivo`,
        `staz_partenza`.`STAZ_Nome` AS `STAZ_Partenza`,
        `staz_arrivo`.`STAZ_Nome` AS `STAZ_Arrivo`,
        `project_work`.`pw_bigl_biglietti`.`BIGL_QR_Code` AS `BIGL_QR_Code`
    FROM
        ((((((((`project_work`.`pw_pren_prenotazioni`
        JOIN `project_work`.`pw_bigl_biglietti` ON ((`project_work`.`pw_bigl_biglietti`.`BIGL_PREN_ID` = `project_work`.`pw_pren_prenotazioni`.`PREN_ID`)))
        JOIN `project_work`.`pw_bior_bieglietti_orari` ON ((`project_work`.`pw_bior_bieglietti_orari`.`BIOR_BIGL_ID` = `project_work`.`pw_bigl_biglietti`.`BIGL_ID`)))
        JOIN `project_work`.`pw_orar_orari` ON ((`project_work`.`pw_orar_orari`.`ORAR_ID` = `project_work`.`pw_bior_bieglietti_orari`.`BIOR_ORAR_ID`)))
        JOIN `project_work`.`pw_trat_tratte` ON ((`project_work`.`pw_trat_tratte`.`TRAT_ID` = `project_work`.`pw_orar_orari`.`ORAR_TRAT_ID`)))
        JOIN `project_work`.`pw_staz_stazioni` `staz_partenza` ON ((`staz_partenza`.`STAZ_Id` = `project_work`.`pw_trat_tratte`.`TRAT_STAZ_ID_Partenza`)))
        JOIN `project_work`.`pw_staz_stazioni` `staz_arrivo` ON ((`staz_arrivo`.`STAZ_Id` = `project_work`.`pw_trat_tratte`.`TRAT_STAZ_ID_Arrivo`)))
        JOIN `project_work`.`pw_tren_treni` ON ((`project_work`.`pw_orar_orari`.`ORAR_TREN_ID` = `project_work`.`pw_tren_treni`.`TREN_ID`)))
        JOIN `project_work`.`pw_pass_passeggeri` ON ((`project_work`.`pw_pass_passeggeri`.`PASS_id` = `project_work`.`pw_pren_prenotazioni`.`PREN_PASS_ID`)));