CREATE TRIGGER ComputeRentalCost
AFTER UPDATE ON rentalContract
FOR EACH ROW
WHEN NEW.dateBack IS NOT NULL AND OLD.dateBack IS NULL
BEGIN
    UPDATE rentalContract
    SET rentalCost = (
        SELECT (baseCost + dailyCost * (julianday(NEW.dateBack) - julianday(NEW.dateOut)+1))
        FROM PhoneModel
        JOIN Phone ON Phone.modelNumber = PhoneModel.modelNumber AND Phone.modelName = PhoneModel.modelName
        WHERE Phone.IMEI = NEW.IMEI
    )
    WHERE customerId = NEW.customerId AND IMEI = NEW.IMEI AND dateOut = NEW.dateOut;
END;
