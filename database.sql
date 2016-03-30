DROP TABLE IF EXISTS OrderPallet;
DROP TABLE IF EXISTS OrderPastry;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Pallets;
DROP TABLE IF EXISTS Ingredients;
DROP TABLE IF EXISTS StockEvents;
DROP TABLE IF EXISTS RawMaterials;
DROP TABLE IF EXISTS Pastries;

CREATE TABLE Pastries (
    name varchar(255) NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE RawMaterials (
    name varchar(255) NOT NULL,
    unit varchar(255) NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE StockEvents (
    id int NOT NULL AUTO_INCREMENT,
    material_name varchar(255) NOT NULL,
    amount int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (material_name) REFERENCES RawMaterials(name)
);

CREATE TABLE Ingredients (
    id int NOT NULL AUTO_INCREMENT,
    pastry_name varchar(255) NOT NULL,
    material_name varchar(255) NOT NULL,
    amount int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pastry_name) REFERENCES Pastries(name),
    FOREIGN KEY (material_name) REFERENCES RawMaterials(name)
);

CREATE TABLE Pallets (
    id int NOT NULL AUTO_INCREMENT,
    barcode_id varchar(255) NOT NULL UNIQUE,
    created_at datetime NOT NULL,
    blocked_at datetime,
    PRIMARY KEY (id)
);

CREATE TABLE Customers (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL UNIQUE,
    address varchar(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Orders (
    id int NOT NULL AUTO_INCREMENT,
    customer_id int NOT NULL,
    delivery_date datetime NOT NULL,
    delivery_address varchar(255) NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

CREATE TABLE OrderPallet (
    pallet_id int NOT NULL,
    order_id int NOT NULL,
    FOREIGN KEY (pallet_id) REFERENCES Pallets(id),
    FOREIGN KEY (order_id) REFERENCES Orders(id)
);

CREATE TABLE OrderPastry (
    order_id int NOT NULL,
    pastry_name varchar(255) NOT NULL,
    amount int NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (pastry_name) REFERENCES Pastries(name)
);