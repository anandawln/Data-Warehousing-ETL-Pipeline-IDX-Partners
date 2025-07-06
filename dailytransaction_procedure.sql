CREATE OR AlTER PROCEDURE DailyTransactions (
@start_date date,
@end_date date)
AS
BEGIN
	SELECT 
		CAST(TransactionDate as date) AS Date,
		COUNT(*) AS TotalTransactions,
		SUM(Amount) AS TotalAmount
	FROM FactTransaction
	WHERE CAST (TransactionDate as date) >= @start_date and CAST(TransactionDate as date) <= @end_date
	GROUP BY CAST(TransactionDate as date)
END

EXEC DailyTransactions '2024-01-17', '2024-01-20'
