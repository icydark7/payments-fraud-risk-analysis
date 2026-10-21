-- Explore fraud labels by transaction type and simulated time step.

SELECT
    type,
    COUNT(*) AS total_transactions,
    SUM(isfraud) AS fraud_transactions,
    ROUND(100.0 * SUM(isfraud) / COUNT(*), 4) AS fraud_rate_pct
FROM payments_fraud
GROUP BY type
ORDER BY fraud_rate_pct DESC;

-- Highest fraud counts by simulated step. A step is not a real timestamp.
SELECT
    step,
    COUNT(*) AS total_transactions,
    SUM(isfraud) AS fraud_transactions
FROM payments_fraud
GROUP BY step
ORDER BY fraud_transactions DESC
LIMIT 5;

-- Highest observed fraud rates for steps with at least 100 transactions.
SELECT
    step,
    total_transactions,
    fraud_transactions,
    ROUND(100.0 * fraud_transactions / total_transactions, 4) AS fraud_rate_pct
FROM (
    SELECT
        step,
        COUNT(*) AS total_transactions,
        SUM(isfraud) AS fraud_transactions
    FROM payments_fraud
    GROUP BY step
    HAVING COUNT(*) >= 100
) AS step_summary
ORDER BY fraud_rate_pct DESC
LIMIT 10;
