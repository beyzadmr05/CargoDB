INSERT INTO Customers (FullName, Phone, Email)
VALUES ('Beyza Demir', '05323844648', 'beyza@example.com');

INSERT INTO Branches (branch_name, city, address_line)
VALUES
('Kadıköy Şubesi', 'İstanbul', 'Rıhtım Cad. No:12 Kadıköy'),
('Çankaya Şubesi', 'Ankara', 'Atatürk Blv. No:45 Çankaya'),
('Konak Şubesi', 'İzmir', 'Gazi Blv. No:78 Konak');

INSERT INTO Status_Types (status_code, status_name, is_active)
VALUES
('CREATED', 'Gönderi oluşturuldu', 1),
('ACCEPTED', 'Şubede kabul edildi', 1),
('IN_TRANSIT', 'Transferde', 1),
('OUT_FOR_DELIVERY', 'Dağıtıma çıktı', 1),
('DELIVERED', 'Teslim edildi', 1),
('CANCELED', 'İptal edildi', 1),
('RETURNED', 'İade edildi', 1);

INSERT INTO Shipments
(tracking_number, customer_id, recipient_name, recipient_phone, recipient_address, origin_branch_id, current_branch_id)
VALUES
('TRK20260001', 1, 'Duhan Demir', '05345731685', 'Alsancak Mah. No:10, İzmir', 1, 1);

INSERT INTO ShipmentStatusHistory
(shipment_id, status_type_id, branch_id, note)
VALUES
(1, 1, 1, 'Initial status set to CREATED');

INSERT INTO Packages
(shipment_id, package_no, weight_kg, length_cm, width_cm, height_cm, volumetric_weight, billable_weight)
VALUES
(1, 1, 2.50, 30, 20, 10, (30 * 20 * 10) / 3000, GREATEST(2.50, (30 * 20 * 10) / 3000)),
(1, 2, 1.20, 25, 15, 8, (25 * 15 * 8) / 3000, GREATEST(1.20, (25 * 15 * 8) / 3000));


SELECT * FROM Customers;
SELECT * FROM Branches;
SELECT * FROM Status_Types;
SELECT * FROM Shipments;
SELECT * FROM ShipmentStatusHistory;
SELECT * FROM Packages;










