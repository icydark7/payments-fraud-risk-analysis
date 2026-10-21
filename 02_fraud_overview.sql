-- Establish baseline fraud metrics.

SELECT isfraud, COUNT(*) AS transaction_count
FROM payments_fraud
GROUP BY isfraud
ORDER BY isfraud;

SELECT
    COUNT(*) AS total_transactions,
    SUM(isfraud) AS fraud_transactions,
    ROUND(100.0 * SUM(isfraud) / COUNT(*), 4) AS fraud_rate_pct
FROM payments_fraud;

SELECT
    isfraud,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_transaction_amount,
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM payments_fraud
GROUP BY isfraud
ORDER BY isfraud;
