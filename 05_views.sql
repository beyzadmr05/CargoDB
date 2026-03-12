CREATE OR REPLACE VIEW vw_shipment_tracking_summary AS
SELECT
    s.id AS shipment_id,
    s.tracking_number,
    st.status_code AS last_status_code,
    st.status_name AS last_status_name,
    b.branch_name AS last_branch_name,
    h.note AS last_note,
    h.created_at AS last_status_time
FROM Shipments s

JOIN (
    SELECT shipment_id, MAX(id) AS last_history_id
    FROM ShipmentStatusHistory
    GROUP BY shipment_id
) last_status
    ON last_status.shipment_id = s.id

JOIN ShipmentStatusHistory h
    ON h.id = last_status.last_history_id

JOIN Status_Types st
    ON st.id = h.status_type_id

LEFT JOIN Branches b
    ON b.id = h.branch_id;