-- Q2: Transaction Frequency Analysis

WITH monthly_transactions AS (
    SELECT 
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month,
        COUNT(*) AS monthly_txn_count
    FROM savings_savingsaccount
    GROUP BY owner_id, txn_month
),
average_transactions AS (
    SELECT 
        owner_id,
        AVG(monthly_txn_count) AS avg_txn_per_month
    FROM monthly_transactions
    GROUP BY owner_id
),
categorized_customers AS (
    SELECT 
        CASE 
            WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        ROUND(avg_txn_per_month, 1) AS avg_transactions_per_month
    FROM average_transactions
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM categorized_customers
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
