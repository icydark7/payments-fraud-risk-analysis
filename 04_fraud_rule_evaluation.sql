-- Evaluate simple, illustrative transaction-review rules.
-- These are exploratory, not production-ready fraud controls.

-- Rule 1: Flag every TRANSFER.
WITH rule_results AS (
    SELECT
        COUNT(*) AS total_transactions,
        SUM(isfraud) AS actual_fraud,
        SUM(CASE WHEN type = 'TRANSFER' THEN 1 ELSE 0 END) AS flagged_transactions,
        SUM(CASE WHEN type = 'TRANSFER' AND isfraud = 1 THEN 1 ELSE 0 END) AS fraud_caught
    FROM payments_fraud
)
SELECT
    'R1: All TRANSFER' AS rule_name,
    flagged_transactions,
    fraud_caught,
    ROUND(100.0 * fraud_caught / actual_fraud, 2) AS recall_pct,
    ROUND(100.0 * fraud_caught / flagged_transactions, 2) AS precision_pct,
    ROUND(100.0 * flagged_transactions / total_transactions, 2) AS flag_rate_pct
FROM rule_results;

-- Rule 2: Flag TRANSFER transactions above 200,000.
WITH rule_results AS (
    SELECT
        COUNT(*) AS total_transactions,
        SUM(isfraud) AS actual_fraud,
        SUM(CASE WHEN type = 'TRANSFER' AND amount > 200000 THEN 1 ELSE 0 END) AS flagged_transactions,
        SUM(CASE WHEN type = 'TRANSFER' AND amount > 200000 AND isfraud = 1 THEN 1 ELSE 0 END) AS fraud_caught
    FROM payments_fraud
)
SELECT
    'R2: TRANSFER > 200K' AS rule_name,
    flagged_transactions,
    fraud_caught,
    ROUND(100.0 * fraud_caught / actual_fraud, 2) AS recall_pct,
    ROUND(100.0 * fraud_caught / flagged_transactions, 2) AS precision_pct,
    ROUND(100.0 * flagged_transactions / total_transactions, 2) AS flag_rate_pct
FROM rule_results;

-- Rule 3: Flag all TRANSFER and CASH_OUT transactions.
WITH rule_results AS (
    SELECT
        COUNT(*) AS total_transactions,
        SUM(isfraud) AS actual_fraud,
        SUM(CASE WHEN type IN ('TRANSFER', 'CASH_OUT') THEN 1 ELSE 0 END) AS flagged_transactions,
        SUM(CASE WHEN type IN ('TRANSFER', 'CASH_OUT') AND isfraud = 1 THEN 1 ELSE 0 END) AS fraud_caught
    FROM payments_fraud
)
SELECT
    'R3: TRANSFER or CASH_OUT' AS rule_name,
    flagged_transactions,
    fraud_caught,
    ROUND(100.0 * fraud_caught / actual_fraud, 2) AS recall_pct,
    ROUND(100.0 * fraud_caught / flagged_transactions, 2) AS precision_pct,
    ROUND(100.0 * flagged_transactions / total_transactions, 2) AS flag_rate_pct
FROM rule_results;

-- Rule 4: Flag TRANSFER or CASH_OUT transactions above 200,000.
WITH rule_results AS (
    SELECT
        COUNT(*) AS total_transactions,
        SUM(isfraud) AS actual_fraud,
        SUM(CASE WHEN type IN ('TRANSFER', 'CASH_OUT') AND amount > 200000 THEN 1 ELSE 0 END) AS flagged_transactions,
        SUM(CASE WHEN type IN ('TRANSFER', 'CASH_OUT') AND amount > 200000 AND isfraud = 1 THEN 1 ELSE 0 END) AS fraud_caught
    FROM payments_fraud
)
SELECT
    'R4: TRANSFER/CASH_OUT > 200K' AS rule_name,
    flagged_transactions,
    fraud_caught,
    ROUND(100.0 * fraud_caught / actual_fraud, 2) AS recall_pct,
    ROUND(100.0 * fraud_caught / flagged_transactions, 2) AS precision_pct,
    ROUND(100.0 * flagged_transactions / total_transactions, 2) AS flag_rate_pct
FROM rule_results;

-- Recall = fraud caught / all fraud-labeled transactions.
-- Precision = fraud-labeled transactions among flagged / all flagged.
-- Flag rate = flagged transactions / all transactions.
