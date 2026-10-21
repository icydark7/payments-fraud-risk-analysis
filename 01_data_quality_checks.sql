-- Payments Fraud Risk Analysis | PostgreSQL
-- Check row count, missing values, transaction categories, and fraud labels.

SELECT COUNT(*) AS total_transactions
FROM payments_fraud;

SELECT
    COUNT(*) FILTER (WHERE step IS NULL) AS missing_step,
    COUNT(*) FILTER (WHERE type IS NULL) AS missing_type,
    COUNT(*) FILTER (WHERE amount IS NULL) AS missing_amount,
    COUNT(*) FILTER (WHERE isfraud IS NULL) AS missing_fraud_label
FROM payments_fraud;

SELECT type, COUNT(*) AS transaction_count
FROM payments_fraud
GROUP BY type
ORDER BY transaction_count DESC;

SELECT isfraud, COUNT(*) AS transaction_count
FROM payments_fraud
GROUP BY isfraud
ORDER BY isfraud;
