CREATE 	database SQL_portfolioproject

SELECT * FROM customer_churn;


-- Query 1: Considering the top 5 groups with the highest
-- average monthly charges among churned customers,
-- how can personalized offers be tailored based on age,
-- gender, and contract type to potentially improve
-- customer retention rates?

SELECT 
    CASE 
        WHEN Age BETWEEN 19 AND 29 THEN '19-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        WHEN Age BETWEEN 70 AND 79 THEN '70-79'
        WHEN Age BETWEEN 80 AND 89 THEN '80-89'
        ELSE 'Unknown'
    END AS Age_Group,
    Gender,
    Contract,
    round(AVG(`Monthly Charge`),2) AS Avg_Monthly_Charges
FROM 
    customer_churn
WHERE 
    `Churn Label` = 'Yes'    
GROUP BY 
    Age_Group, Gender, Contract
ORDER BY 
    Avg_Monthly_Charges DESC
LIMIT 5;


-- Query 2: What are the feedback or complaints from
-- those churned customers


SELECT `Customer ID`,`Churn Reason`
FROM customer_churn
WHERE `Churn Label` = 'Yes';


-- Query 3: How does the payment method influence churn behavior?

SELECT`Payment Method`, COUNT(*) AS total_customers
FROM customer_churn
WHERE `Churn Label` = 'Yes'
GROUP BY `Payment Method`
ORDER BY total_customers DESC;

SELECT 
    `Payment Method`, 
    COUNT(*) AS Total_Customers,
    COUNT(CASE WHEN `Churn Label` = 'Yes' THEN 1 END) AS Churned_Customers,
    COUNT(CASE WHEN `Churn Label` = 'No' THEN 1 END) AS Retained_Customers,
    (COUNT(CASE WHEN `Churn Label` = 'Yes' THEN 1 END) / COUNT(*)) * 100 AS Churn_Rate
FROM 
    customer_churn
GROUP BY 
    `Payment Method`
ORDER BY 
    Churn_Rate DESC;