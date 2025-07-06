CREATE OR ALTER PROCEDURE BalancePerCustomer (@name varchar(50))
AS
BEGIN
	SELECT 
		c.CustomerName CustomerName,
		a.AccountType AccountType,
		a.Balance Balance,
		a.Balance + COALESCE(SUM(CASE WHEN tr.TransactionType = 'Deposit' THEN tr.Amount ELSE -tr.Amount END),0) AS CurrentBalance
	FROM FactTransaction tr
	LEFT JOIN DimAccount a on tr.AccountID = a.AccountID
	LEFT JOIN DimCustomer c on a.CustomerID = c.CustomerID
	WHERE c.CustomerName LIKE '%' + @name + '%'
	AND a.status = 'active'
	GROUP BY
	c.CustomerName,
	a.AccountType,
	a.Balance
END

EXEC BalancePerCustomer @name = 'Shelly'