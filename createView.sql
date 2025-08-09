CREATE VIEW CustomerSummary AS
SELECT 
    r.customerId,
    p.modelName,
    CAST(SUM(julianday(r.dateBack) - julianday(r.dateOut) + 1) AS INTEGER) AS daysRented,
    CASE 
        WHEN strftime('%m-%d', r.dateBack) >= '07-01' THEN 
            strftime('%Y', r.dateBack) || '/' || substr(strftime('%Y', date(r.dateBack, '+1 year')), 3, 2)
        ELSE 
            (CAST(strftime('%Y', r.dateBack) AS INTEGER) - 1) || '/' || substr(strftime('%Y', r.dateBack), 3, 2)
    END AS taxYear,
    SUM(r.rentalCost) AS rentalCost
FROM 
    rentalContract r
    LEFT JOIN Phone ph ON r.IMEI = ph.IMEI
    LEFT JOIN PhoneModel p ON ph.modelNumber = p.modelNumber AND ph.modelName = p.modelName
WHERE 
    r.dateBack IS NOT NULL
GROUP BY 
    r.customerId, taxYear, p.modelName;
