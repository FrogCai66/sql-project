CREATE TABLE PhoneModel (
    modelNumber TEXT PRIMARY KEY,
    modelName TEXT,
    storage INTEGER,
    colour TEXT,
    baseCost REAL,
    dailyCost REAL
);


CREATE TABLE Customer (
    customerId INTEGER PRIMARY KEY,
    customerName TEXT,
    customerEmail TEXT
);


CREATE TABLE Phone (
    modelNumber TEXT,
    modelName TEXT,
    IMEI TEXT,
    PRIMARY KEY (IMEI),
    FOREIGN KEY (modelNumber, modelName) REFERENCES PhoneModel(modelNumber, modelName),
    CHECK (
        (CAST(substr(IMEI, 1, 1) AS INT)
        + CAST(substr(IMEI, 3, 1) AS INT)
        + CAST(substr(IMEI, 5, 1) AS INT)
        + CAST(substr(IMEI, 7, 1) AS INT)
        + CAST(substr(IMEI, 9, 1) AS INT)
        + CAST(substr(IMEI, 11, 1) AS INT)
        + CAST(substr(IMEI, 13, 1) AS INT)
        + CAST(substr(IMEI, 15, 1) AS INT)
        + (CAST(substr(IMEI, 2, 1) AS INT) * 2) % 10 + (CAST(substr(IMEI, 2, 1) AS INT) * 2) / 10
        + (CAST(substr(IMEI, 4, 1) AS INT) * 2) % 10 + (CAST(substr(IMEI, 4, 1) AS INT) * 2) / 10
        + (CAST(substr(IMEI, 6, 1) AS INT) * 2) % 10 + (CAST(substr(IMEI, 6, 1) AS INT) * 2) / 10
        + (CAST(substr(IMEI, 8, 1) AS INT) * 2) % 10 + (CAST(substr(IMEI, 8, 1) AS INT) * 2) / 10
        + (CAST(substr(IMEI, 10, 1) AS INT) * 2) % 10 + (CAST(substr(IMEI, 10, 1) AS INT) * 2) / 10
        + (CAST(substr(IMEI, 12, 1) AS INT) * 2) % 10 + (CAST(substr(IMEI, 12, 1) AS INT) * 2) / 10
        + (CAST(substr(IMEI, 14, 1) AS INT) * 2) % 10 + (CAST(substr(IMEI, 14, 1) AS INT) * 2) / 10
        ) % 10 = 0
    )
);


CREATE TABLE rentalContract (
    customerId INTEGER,
    IMEI TEXT,
    dateOut TEXT,
    dateBack TEXT,
    rentalCost REAL,
    PRIMARY KEY (customerId, IMEI, dateOut),
    FOREIGN KEY (customerId) REFERENCES Customer(customerId) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (IMEI) REFERENCES Phone(IMEI) ON DELETE SET NULL
);
