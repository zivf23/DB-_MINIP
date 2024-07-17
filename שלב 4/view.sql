-- View for our Database  - Client with selected attributes
CREATE VIEW ClientView AS
SELECT ClientID_, FirstName, LastName, Email
FROM Client;

-- View for friend Database  - Bank with selected attributes
CREATE VIEW BankView AS
SELECT BankID, BankName, BankPhoneNumber
FROM Bank;