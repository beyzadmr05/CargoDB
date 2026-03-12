SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Packages;
DROP TABLE IF EXISTS ShipmentStatusHistory;
DROP TABLE IF EXISTS Shipments;
DROP TABLE IF EXISTS Status_Types;
DROP TABLE IF EXISTS Branches;
DROP TABLE IF EXISTS Customers;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(120) NOT NULL,
    Phone VARCHAR(30) NOT NULL,
    Email VARCHAR(120),
    CreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE Branches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(120) NOT NULL,
    city VARCHAR(80) NOT NULL,
    address_line VARCHAR(250) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE Status_Types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_code VARCHAR(50) NOT NULL,
    status_name VARCHAR(100) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (status_code)
) ENGINE=InnoDB;

CREATE TABLE Shipments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tracking_number VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    recipient_name VARCHAR(120) NOT NULL,
    recipient_phone VARCHAR(30) NOT NULL,
    recipient_address VARCHAR(300) NOT NULL,
    origin_branch_id INT NOT NULL,
    current_branch_id INT NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (tracking_number),
    FOREIGN KEY (customer_id) REFERENCES Customers(id),
    FOREIGN KEY (origin_branch_id) REFERENCES Branches(id),
    FOREIGN KEY (current_branch_id) REFERENCES Branches(id)
) ENGINE=InnoDB;

CREATE TABLE ShipmentStatusHistory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    shipment_id INT NOT NULL,
    status_type_id INT NOT NULL,
    branch_id INT NOT NULL,
    note VARCHAR(200),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (shipment_id) REFERENCES Shipments(id),
    FOREIGN KEY (status_type_id) REFERENCES Status_Types(id),
    FOREIGN KEY (branch_id) REFERENCES Branches(id)
) ENGINE=InnoDB;

CREATE TABLE Packages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    shipment_id INT NOT NULL,
    package_no INT NOT NULL,
    weight_kg DECIMAL(10,2) NOT NULL,
    length_cm DECIMAL(10,2) NOT NULL,
    width_cm DECIMAL(10,2) NOT NULL,
    height_cm DECIMAL(10,2) NOT NULL,
    volumetric_weight DECIMAL(10,2) NOT NULL,
    billable_weight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (shipment_id, package_no),
    FOREIGN KEY (shipment_id) REFERENCES Shipments(id)
) ENGINE=InnoDB;