select * from financial_loan

--KPI
--Total Loan Applications
select count(id) as total_application from  financial_loan

--MTD Loan Applications
select count(id) as MTD_total_application from  financial_loan where month(issue_date)=12 and YEAR(issue_date)=2021
--PMTD Loan Applications
select count(id) as PMTD_total_application from  financial_loan where month(issue_date)=11 and YEAR(issue_date)=2021

--Total Funded Amount
SELECT SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT FROM financial_loan
--MTD Total Funded Amount
SELECT SUM(loan_amount) AS TOTAL_MONTH_WISE_FUNDED_AMOUNT FROM financial_loan WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021
--PMTD Total Funded Amount
SELECT SUM(loan_amount) AS TOTAL_PRE_MONTH_WISE_FUNDED_AMOUNT FROM financial_loan WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021

--Total Amount Received(Collected)
SELECT SUM(total_payment) AS TOTAL_AMOUNT_RECEIVED FROM financial_loan
--MTD Total Amount Received
SELECT SUM(total_payment) AS TOTAL_AMOUNT_RECEIVED_MONTH_WISE FROM financial_loan WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021
--PMTD Total Amount Received
SELECT SUM(total_payment) AS TOTAL_AMOUNT_RECEIVED_PRE_MONTH_WISE FROM financial_loan WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021

--Average Interest Rate
SELECT ROUND(AVG(int_rate),4)*100 AS INTEREST_RATE FROM financial_loan
--MTD Average Interest
SELECT ROUND(AVG(int_rate),4)*100 AS MONTHLY_INTEREST_RATE FROM financial_loan WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021
--PMTD Average Interest
SELECT ROUND(AVG(int_rate),4)*100 AS PRE_MONTH_INTEREST_RATE FROM financial_loan WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021

--Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS DTI_RATE FROM financial_loan
--MTD Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS MONTHLY_DTI_RATE FROM financial_loan WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021
--PMTD Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS PRE_MONTH_DTI_RATE FROM financial_loan WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021



--GOOD LOAN ISSUED

--Good Loan Percentage
SELECT (COUNT(CASE WHEN loan_status='Fully Paid' OR loan_status='Current' THEN id END)*100)
/
COUNT(id) AS GOOD_LOAN_PERCENTAGE
FROM financial_loan

--Good Loan Applications
SELECT COUNT(id) as good_loan_application FROM financial_loan WHERE loan_status='Fully Paid' OR loan_status='Current'
--Good Loan Funded Amount
SELECT sum(loan_amount) as good_loan_amount FROM financial_loan WHERE loan_status='Fully Paid' OR loan_status='Current'
--Good Loan Amount Received
SELECT sum(total_payment) as good_loan_recived_amount FROM financial_loan WHERE loan_status='Fully Paid' OR loan_status='Current'


--BAD LOAN ISSUED

--Bad Loan Percentage
SELECT (COUNT(CASE WHEN loan_status='Charged Off' THEN id END)*100)
/
COUNT(id) AS BAD_LOAN_PERCENTAGE
FROM financial_loan
 
 --Bad Loan Applications
SELECT COUNT(id) as BAD_LOAN FROM financial_loan WHERE loan_status='Charged Off'
--Bad Loan Funded Amount
SELECT SUM(loan_amount) as BAD_LOAN_AMOUNT FROM financial_loan WHERE loan_status='Charged Off'
--Bad Loan Amount Received
SELECT sum(total_payment) as BAD_loan_recived_amount FROM financial_loan WHERE loan_status='Charged Off'




--LOAN STATUS

SELECT loan_status,
COUNT(id) AS TOTAL_APPLICATION,
SUM(total_payment) AS TOTAL_RECIVABLE,
SUM(loan_amount) AS TOTAL_LOAN_AMOUNT,
AVG (int_rate*100) AS INTEREST_RATE,
AVG(dti*100) AS DTI
FROM financial_loan
GROUP BY loan_status

SELECT LOAN_STATUS,
SUM(total_payment) AS MTD_TOTAL_AMOUNT_RECEIVED,
SUM(loan_amount) AS MTD_TOTAL_FUNDED_AMOUNT
FROM financial_loan
WHERE MONTH(issue_date)=12
GROUP BY loan_status


--BANK LOAN REPORT | OVERVIEW
--MONTH
SELECT DATENAME(MONTH,issue_date) as month,
       COUNT(id) AS TOTAL_APPLICATION,
	   SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	   sum(total_payment) as total_recivable
FROM financial_loan
 group by DATENAME(MONTH,issue_date)
 order by TOTAL_APPLICATION desc 


 --STATE
 SELECT address_state,
       COUNT(id) AS TOTAL_APPLICATION,
	   SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	   sum(total_payment) as total_recivable
FROM financial_loan
 group by address_state
 order by TOTAL_APPLICATION desc 

 --TERM
 SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term



 --EMPLOYEE LENGTH
 SELECT emp_length,
       COUNT(id) AS TOTAL_APPLICATION,
	   SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	   sum(total_payment) as total_recivable
FROM financial_loan
 group by emp_length
 order by emp_length  


 --PURPOSE
 SELECT purpose,
       COUNT(id) AS TOTAL_APPLICATION,
	   SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	   sum(total_payment) as total_recivable
FROM financial_loan
 group by purpose
 order by TOTAL_APPLICATION desc 

 --HOME OWNERSHIP
 SELECT home_ownership,
       COUNT(id) AS TOTAL_APPLICATION,
	   SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	   sum(total_payment) as total_recivable
FROM financial_loan
 group by home_ownership
 order by TOTAL_APPLICATION desc 

 --Grade
 SELECT grade,
       COUNT(id) AS TOTAL_APPLICATION,
	   SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	   sum(total_payment) as total_recivable
FROM financial_loan
 group by grade
 order by TOTAL_APPLICATION desc

 select address_state,COUNT(loan_status) from financial_loan group by address_state  order by COUNT(loan_status) desc
 select * from financial_loan

 select COUNT(loan_status),address_state from financial_loan where loan_status='Charged Off' group by address_state order by COUNT(loan_status) desc