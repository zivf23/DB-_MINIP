-- Query 1: Display all customers with an email containing the domain "gmail.com" FROM ClientView

SELECT * 
FROM ClientView
WHERE Email LIKE '%gmail.com';

--Query 2: Displaying the number of customers according to the first letter of the last name FROM ClientView

SELECT LEFT(LastName, 1) AS FirstLetter, COUNT(*) AS NumberOfClients
FROM ClientView
GROUP BY LEFT(LastName, 1)
ORDER BY FirstLetter;

--Query 1: Displaying all banks with a phone number that contains the digits '123'
SELECT * 
FROM BankView
WHERE Bank_Phone_Number LIKE '%123%';

 -- Query 2: Counting the number of banks according to the first phone number from BankView
SELECT LEFT(Bank_Phone_Number, 1) AS FirstDigit, COUNT(*) AS NumberOfBanks
FROM BankView
GROUP BY LEFT(Bank_Phone_Number, 1)
ORDER BY FirstDigit;
