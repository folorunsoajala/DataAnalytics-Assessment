-- Q3: Account Inactivity Alert

WITH inflow_dates AS (
    SELECT 
        plan_id,
        MAX(transaction_date) AS last_transaction_date
    FROM savings_savingsaccount
    GROUP BY plan_id
),
inactivity_check AS (
    SELECT 
        p.id AS plan_id,
        p.owner_id,
        CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        i.last_transaction_date,
        DATEDIFF(CURDATE(), i.last_transaction_date) AS inactivity_days
    FROM plans_plan p
    LEFT JOIN inflow_dates i ON p.id = i.plan_id
    WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1
)
SELECT *
FROM inactivity_check
WHERE inactivity_days > 365;
