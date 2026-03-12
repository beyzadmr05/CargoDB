CREATE INDEX idx_shipments_tracking
ON Shipments(tracking_number);

CREATE INDEX idx_packages_shipment
ON Packages(shipment_id);

CREATE INDEX idx_status_history_shipment
ON ShipmentStatusHistory(shipment_id);

CREATE INDEX idx_status_history_status
ON ShipmentStatusHistory(status_type_id);