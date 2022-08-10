DELIMITER $$
--
-- Procedures
--
CREATE PROCEDURE `sp_UpdateAgeingProcessStatus` (IN `pKepi` VARCHAR(50), IN `pBarcode` VARCHAR(50), IN `pPartLot` VARCHAR(50), IN `pAssycode` VARCHAR(70))  BEGIN
	UPDATE t_handwork_process_items set ageing_process = 'Y' WHERE kepi_lot = pKepi AND barcode_serial = pBarcode AND part_lot = pPartLot and assy_code = pAssycode;

UPDATE t_smt_line_process_items set ageing_process = 'Y' WHERE kepi_lot = pKepi AND barcode_serial = pBarcode AND part_lot = pPartLot and assy_code = pAssycode;
END$$

CREATE PROCEDURE `sp_UpdateFTProcessStatus` (IN `pKepi` VARCHAR(50), IN `pBarcode` VARCHAR(50), IN `pPartLot` VARCHAR(50), IN `pAssycode` VARCHAR(70))  BEGIN
	UPDATE t_handwork_process_items set ft_process = 'Y' WHERE kepi_lot = pKepi AND barcode_serial = pBarcode AND part_lot = pPartLot and assy_code = pAssycode;

UPDATE t_smt_line_process_items set ft_process = 'Y' WHERE kepi_lot = pKepi AND barcode_serial = pBarcode AND part_lot = pPartLot and assy_code = pAssycode;
END$$

--
-- Functions
--
CREATE FUNCTION `fGetPartLocation` (`pBarcode` VARCHAR(50)) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci BEGIN
	DECLARE hasil varchar(50);
    
    SET hasil = (SELECT a.assy_location FROM t_part_location as a INNER JOIN t_warehouse_issuance as b on a.part_number = b.part_number WHERE b.barcode_serial = pBarcode);
    
    RETURN (hasil);
END$$

CREATE FUNCTION `fGetSMTAgeingProcess` (`pInd` VARCHAR(1), `pKepi` VARCHAR(50), `pQrcode` VARCHAR(50), `pLot` VARCHAR(50)) RETURNS VARCHAR(1) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci BEGIN
	DECLARE hasil varchar(1);
    DECLARE icount bigint;
    
 	if pInd = '1' THEN
    	SET icount = (SELECT count(*) FROM t_smt_line_process_items WHERE kepi_lot = pKepi and barcode_serial = pQrcode and part_lot = pLot);
    ELSEIF pInd = '2' THEN
    	SET icount = (SELECT COUNT(*) FROM t_handwork_process_items WHERE kepi_lot = pKepi and barcode_serial = pQrcode and part_lot = pLot);
    end if;
    
    if icount > 0 THEN
    	set hasil = 'Y';
    ELSE
    	set hasil = 'N';
    end if;
    
	RETURN (hasil);
END$$

DELIMITER ;