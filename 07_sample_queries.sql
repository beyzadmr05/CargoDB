USE cargodb;


-- 1) Tüm gönderileri listele
SELECT *
FROM Shipments;


-- 2) Tracking number ile kargo bul
SELECT *
FROM Shipments
WHERE tracking_number = 'TRK10001';


-- 3) Tracking summary view üzerinden kargo bul
SELECT *
FROM vw_shipment_tracking_summary
WHERE tracking_number = 'TRK10001';


-- 4) Bir kargonun tüm timeline'ı
SELECT
    s.tracking_number,
    st.status_code,
    st.status_name,
    b.branch_name,
    h.note,
    h.created_at
FROM ShipmentStatusHistory h
JOIN Shipments s
    ON s.id = h.shipment_id
JOIN Status_Types st
    ON st.id = h.status_type_id
LEFT JOIN Branches b
    ON b.id = h.branch_id
WHERE s.tracking_number = 'TRK10001'
ORDER BY h.created_at;


-- 5) Şubeye göre oluşturulan gönderi sayısı
SELECT
    b.branch_name,
    COUNT(s.id) AS shipment_count
FROM Branches b
LEFT JOIN Shipments s
    ON s.origin_branch_id = b.id
GROUP BY b.branch_name
ORDER BY shipment_count DESC, b.branch_name;


-- 6) Son durumuna göre gönderi sayıları
SELECT
    last_status_code,
    last_status_name,
    COUNT(*) AS shipment_count
FROM vw_shipment_tracking_summary
GROUP BY last_status_code, last_status_name
ORDER BY shipment_count DESC, last_status_name;


-- 7) Belirli bir müşteriye ait gönderiler
SELECT
    s.id,
    s.tracking_number,
    c.FullName AS customer_name,
    s.recipient_name,
    s.recipient_phone,
    s.created_at
FROM Shipments s
JOIN Customers c
    ON c.id = s.customer_id
WHERE c.id = 1
ORDER BY s.created_at DESC;


-- 8) Mevcut şubeye göre gönderiler
SELECT
    s.id,
    s.tracking_number,
    b.branch_name AS current_branch_name,
    s.created_at
FROM Shipments s
JOIN Branches b
    ON b.id = s.current_branch_id
ORDER BY s.created_at DESC;


-- 9) Status history kayıtlarını listele
SELECT
    h.id,
    h.shipment_id,
    st.status_code,
    st.status_name,
    b.branch_name,
    h.note,
    h.created_at
FROM ShipmentStatusHistory h
JOIN Status_Types st
    ON st.id = h.status_type_id
LEFT JOIN Branches b
    ON b.id = h.branch_id
ORDER BY h.created_at DESC;


-- 10) Paket sayısı en fazla olan gönderiler
SELECT
    s.tracking_number,
    COUNT(p.id) AS package_count
FROM Shipments s
LEFT JOIN Packages p
    ON p.shipment_id = s.id
GROUP BY s.id, s.tracking_number
ORDER BY package_count DESC, s.tracking_number;

SELECT *
FROM vw_shipment_tracking_summary;