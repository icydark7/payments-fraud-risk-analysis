# Payments Fraud Risk Analysis Using SQL

## Project Overview
This project uses PostgreSQL to analyze a synthetic mobile-money transaction dataset, identify patterns in fraud-labeled transactions, and evaluate simple rule-based approaches for transaction review.

## Business Objective
The objective is to establish baseline fraud metrics, investigate patterns by transaction type and simulated time, and compare monitoring rules using recall, precision, and flag rate.

## Tools Used
- PostgreSQL
- pgAdmin
- SQL

## Dataset
**PaySim — Synthetic Financial Datasets for Fraud Detection**

Source: https://www.kaggle.com/datasets/ealaxi/paysim1

The dataset contains simulated mobile-money transactions. It is not Amazon transaction data or a direct representation of real-world fraud. The `isFraud` field is treated as the dataset's reference label.

The raw CSV is not included in this repository because of its large size. Download it from the source and import it into PostgreSQL to run the queries.

## SQL Files
- `01_data_quality_checks.sql` — checks row count, missing values, transaction types, and fraud-label counts.
- `02_fraud_overview.sql` — calculates baseline fraud metrics and transaction amounts.
- `03_fraud_patterns.sql` — analyzes fraud labels by transaction type and simulated step.
- `04_fraud_rule_evaluation.sql` — evaluates four illustrative transaction-review rules.

## Key Findings
The analysis covered **6,362,620 transactions**, including **8,213 fraud-labeled transactions**.

- The observed fraud rate was approximately **0.1291%**.
- All fraud-labeled transactions in this dataset occurred in the `TRANSFER` and `CASH_OUT` categories.
- The average transaction amount was substantially higher for fraud-labeled transactions than for transactions not labeled as fraud.
- The `step` field represents simulated hourly increments, not real calendar timestamps.

### Fraud Rule Comparison

| Rule | Recall | Precision | Flag Rate |
|---|---:|---:|---:|
| All `TRANSFER` | 49.88% | 0.77% | 8.38% |
| `TRANSFER` above 200,000 | 33.36% | 0.67% | 6.43% |
| `TRANSFER` or `CASH_OUT` | 100.00% | 0.30% | 43.54% |
| `TRANSFER` / `CASH_OUT` above 200,000 | 66.61% | 0.46% | 18.82% |

### Interpretation
The rule flagging both `TRANSFER` and `CASH_OUT` captured all fraud-labeled transactions in this dataset, but flagged a large share of all transactions. Narrower rules reduced the review volume but missed more fraud-labeled transactions.

This demonstrates the trade-off between fraud detection and the operational workload associated with reviewing flagged transactions.

## Limitations
- The dataset is synthetic and may not represent real-world payment fraud.
- Findings are specific to this dataset and its labels.
- Transaction value associated with fraud labels is not necessarily confirmed financial loss.
- The rules are exploratory examples, not production-ready fraud controls.
- No machine-learning model is included.

## How to Run
1. Download the PaySim CSV from the dataset source.
2. Create a PostgreSQL database and import the CSV into a table named `payments_fraud`.
3. Run the SQL files in numerical order using pgAdmin or another PostgreSQL client.

## Conclusion
This project demonstrates SQL-based transaction monitoring, fraud-pattern analysis, and rule evaluation, with a focus on interpreting metrics and balancing fraud detection against review workload.
