-- Add new customer age segments column
ALTER TABLE customer_churn_records
ADD COLUMN ageSegment INT;

UPDATE customer_churn_records
SET ageSegment =
  CASE
    WHEN age BETWEEN 18 AND 24 THEN 1  -- Teenagers
    WHEN age BETWEEN 25 AND 34 THEN 2  -- Young Adults
    WHEN age BETWEEN 35 AND 54 THEN 3  -- Middle Aged Adults
    WHEN age BETWEEN 55 AND 64 THEN 4  -- Late Middle Aged Adults
    WHEN age BETWEEN 65 AND 74 THEN 5  -- Seniors Early Retire
    WHEN age BETWEEN 75 AND 84 THEN 6  -- Seniors Active Retire
    WHEN age >= 85 THEN 7              -- Seniors Elderly
    ELSE 0                             -- Default for cases not covered
  END;
  
-- Add a new column for income brackets
ALTER TABLE customer_churn_records
ADD COLUMN incomeBracket VARCHAR(50);

UPDATE customer_churn_records
SET incomeBracket =
  CASE
    WHEN estimatedIncome < 50000 THEN 'Low Income'
    WHEN estimatedIncome >= 50000 AND estimatedIncome < 100000 THEN 'Middle Income'
    WHEN estimatedIncome >= 100000 THEN 'High Income'
    ELSE 'Unknown'
  END;
  
-- Churned and Not_Churned Percentage
select
    CAST((COUNT(CASE WHEN exited = true THEN 1 ELSE NULL END)::FLOAT / COUNT(*)) * 100 AS DECIMAL(10, 2)) AS churned_percentage, -- 20.38%
    CAST((COUNT(CASE WHEN exited = false THEN 1 ELSE NULL END)::FLOAT / COUNT(*)) * 100 AS DECIMAL(10, 2)) AS not_churned_percentage -- 79.62%
from customer_churn_records;

-- Export dataset to CSV
\COPY (SELECT * FROM your_table) TO PROGRAM 'cat > /path/to/output.csv' WITH CSV HEADER;