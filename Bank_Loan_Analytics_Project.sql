--------------------  Bank Loan Analytics Project -----------------------------

-- Creating new database name bank_data --
CREATE DATABASE bank_data;
USE bank_data;
DESC loan_data;

-- Shows Total Loan Amount Funded, Total Loans, Total Collection,Total Interest --

SELECT 
    CONCAT('₹', FORMAT(SUM(loan_amount), 2)) AS Total_Loan_Funded, 
    FORMAT(COUNT(loan_amount), 0) AS Total_Loans, 
    CONCAT('₹', FORMAT(SUM(total_pymnt), 2)) AS Total_Collection, 
    CONCAT('₹', FORMAT(SUM(total_rrec_int), 2)) AS Total_Interest
FROM loan_data;

-- Shows Top 10 Branch-wise performance (Total_Collection) From Highest to Lowest--

SELECT Branch_name, CONCAT('₹', FORMAT(SUM(total_pymnt), 2))  AS Total_Revenue_Collection
FROM loan_data
GROUP BY Branch_name
ORDER BY SUM(total_pymnt) DESC
LIMIT 10;

-- Shows Bottom 5 Branch-wise performance (Total_Collection)--

SELECT Branch_name, CONCAT('₹', FORMAT(SUM(total_pymnt), 2))  AS Total_Revenue_Collection
FROM loan_data
GROUP BY Branch_name
ORDER BY SUM(total_pymnt) 
LIMIT 5;

-- Shows State-WISE Loan Amount Aproved Highest to Lowest--

SELECT State_name, CONCAT('₹', FORMAT(SUM(loan_amount), 2))  AS Total_Loan_Amount
FROM loan_data
GROUP BY State_name
ORDER BY SUM(loan_amount) DESC
;

-- Shows Religion-WISE Loan Amount Aproved Highest to Lowest--

SELECT Religion, CONCAT('₹', FORMAT(SUM(loan_amount), 2))  AS Total_Loan_Amount
FROM loan_data
GROUP BY Religion
ORDER BY SUM(loan_amount) DESC;


-- Shows Purpose-WISE Loan Amount Aproved Highest to Lowest--

SELECT Purpose_Category, CONCAT('₹', FORMAT(SUM(loan_amount), 2))  AS Total_Loan_Amount
FROM loan_data
GROUP BY Purpose_Category
ORDER BY SUM(loan_amount) DESC;

-- Loan Disbursement Over-time (YEAR-WISE) --

SELECT Year(disbursement_date) AS YEAR, CONCAT('₹', FORMAT(SUM(loan_amount), 2))  AS Total_Loan_Amount
FROM loan_data
GROUP BY YEAR
ORDER BY YEAR ;

-- Count of Total Default Loan and Amount--

SELECT COUNT(*) AS default_loan_count, 
CONCAT('₹', FORMAT(SUM(loan_amount), 2)) AS default_loan_amount
FROM loan_data
WHERE Is_Default_Loan = 'Y';


-- Count of Delinquent Clients--

SELECT COUNT(DISTINCT client_id) AS delinquent_clients
FROM loan_data
WHERE Is_Delinquent_Loan = 'Y';


-- Delinquent Loans Rate--

SELECT 
CONCAT(ROUND((SUM(CASE WHEN Is_Delinquent_Loan = 'Y' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2
    ), '%') AS delinquent_loan_rate
FROM loan_data;


-- Default Loan Rate

SELECT CONCAT(ROUND((SUM(CASE WHEN Is_Default_Loan = 'Y' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2
    ), '%') AS default_loan_rate
FROM 
    loan_data;


-- Loan Status-Wise Loans ,loan_amount--

SELECT loan_status, COUNT(*) AS total_loans,
CONCAT('₹', FORMAT(SUM(loan_amount), 2)) AS total_loan_amount
FROM loan_data
GROUP BY loan_status
ORDER BY total_loans DESC;


-- Age Group-Wise Loan--

SELECT age,COUNT(*) AS total_loans,
CONCAT('₹', FORMAT(SUM(loan_amount), 2)) AS total_loan_amount
FROM loan_data
GROUP BY age
ORDER BY age;

-- Count verified,non-verified and source varified percentage Loan--

SELECT verification_status, COUNT(*) AS no_verified_loans,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percent_loans
FROM loan_data
WHERE verification_status IN ('Not Verified', 'Verified', 'Source Verified')
GROUP BY verification_status;


























































































































































































































































