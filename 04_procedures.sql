-- Eski procedure varsa sil
DROP PROCEDURE IF EXISTS sp_add_package;
DROP PROCEDURE IF EXISTS sp_set_shipment_status;

DELIMITER $$

-- =================================
-- PACKAGE EKLEME PROCEDURE
-- =================================
CREATE PROCEDURE sp_add_package(
    IN p_shipment_id INT,
    IN p_barcode VARCHAR(50),
    IN p_weight DECIMAL(10,2),
    IN p_desi DECIMAL(10,2)
)
BEGIN

    DECLARE v_count INT;

    -- shipment var mı kontrol
    SELECT COUNT(*)
    INTO v_count
    FROM Shipments
    WHERE id = p_shipment_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shipment not found';
    END IF;

    -- paketi ekle
    INSERT INTO Packages
    (
        shipment_id,
        package_barcode,
        weight_kg,
        desi
    )
    VALUES
    (
        p_shipment_id,
        p_barcode,
        p_weight,
        p_desi
    );

END$$


-- =================================
-- SHIPMENT STATUS DEĞİŞTİRME
-- =================================
CREATE PROCEDURE sp_set_shipment_status(
    IN p_shipment_id INT,
    IN p_new_status_code VARCHAR(50),
    IN p_branch_id INT,
    IN p_note VARCHAR(200)
)
BEGIN

    DECLARE v_new_status_id INT;

    -- status id bul
    SELECT id
    INTO v_new_status_id
    FROM Status_Types
    WHERE code = p_new_status_code
    LIMIT 1;

    IF v_new_status_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid status code';
    END IF;

    -- shipment status güncelle
    UPDATE Shipments
    SET current_status_type_id = v_new_status_id
    WHERE id = p_shipment_id;

    -- history kaydı
    INSERT INTO ShipmentStatusHistory
    (
        shipment_id,
        status_type_id,
        branch_id,
        note
    )
    VALUES
    (
        p_shipment_id,
        v_new_status_id,
        p_branch_id,
        p_note
    );

END$$

DELIMITER ;