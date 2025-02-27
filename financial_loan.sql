create database bank_loan
use bank_loan
select * from financial_loan
SELECT * FROM financial_loan;
SELECT * FROM financial_loan;
SHOW TABLES;


select * from financial_loan
drop table financial_loan
#total_loan_application
select count(id) as Total_loan_applications from financial_loan

#MTD total_loan_application
SELECT COUNT(id) AS MTD_Total_loan_application  
FROM financial_loan 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12;


#PMTD total_loan_application
SELECT COUNT(id) AS MTD_Total_loan_application  
FROM financial_loan 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11


#total funded application
select sum(loan_amount) as Total_funded_amount from financial_loan

#month total funded amount
SELECT sum(loan_amount) AS MTD_Total_funded_amount
FROM financial_loan 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12 
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

#PMTD total funded amount

#total amount received 
select sum(total_payment) as Total_amount_received from financial_loan

#MTD Total_Amount_Received 

SELECT sum(total_payment) AS MTD_Total_amount_recevied
FROM financial_loan 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

#PMTD Total amount received
SELECT sum(total_payment) AS PMTD_Total_amount_received
FROM financial_loan 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

#average interest rate ---> find 2 decimal we can use the round function  eg:select round( avg(int_rate), 2) *  100 as average_interest_rate from financial_bank_loan
select avg(int_rate)*  100 as average_interest_rate from financial_loan

#mtd average interest rate
SELECT round( avg(int_rate), 4) * 100 AS MTD_Average_interest_rate
FROM financial_loan 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12 
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

#PMTD 
SELECT round( avg(int_rate), 4) * 100 AS PMTD_Average_Interest_rate
FROM financial_loan 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11 
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

----------------------------------------------
#average debt to income

select round( avg(dti), 4) * 100 as average_dti from financial_loan
#MTD 
SELECT round( avg(dti), 4) * 100 AS MTD_Average_dti
FROM financial_loan 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12 
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

#PMTD
SELECT round( avg(dti), 4) * 100 AS PMTD_average_dti
FROM financial_loan 
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;


#find good loan percentage
select
   (count(case when loan_status ='Fully paid' or loan_status ='current' then id end)* 100)
    /
    count(id) as Good_Loan_percertage from financial_bank_loan
#bad loan percertage
select
   (count(case when loan_status ='Charged off' then id end)* 100.0)
    /
    count(id) as bad_Loan_percertage from financial_bank_loan;
    
#find good loan application
select count(id) as Good_loan_application from financial_bank_loan where loan_status = 'Fully paid' or loan_status =' current'
#find bad loan application
select count(id) as bad_loan_application from financial_bank_loan where loan_status = 'Charged off'

#find good fund date amount
select sum(loan_amount) as Good_loan_funded_amount from financial_bank_loan where loan_status = 'Fully paid' or loan_status =' current'
#find bad fund date amount
select sum(loan_amount) as bad_loan_funded_amount from financial_bank_loan where loan_status = 'Charged off'

#find total received amount
select sum(total_payment) as Good_loan_recieved_amount from financial_bank_loan where loan_status = 'Fully paid' or loan_status =' current'
#find bad total received amount
select sum(total_payment) as bad_loan_recieved_amount from financial_bank_loan where loan_status =  'Charged off'

#loan status 
select 
   loan_status, 
   count(id) as total_loan_application,
   sum(total_payment) as total_amount_recevied,
   sum(loan_amount)as total_funded_Amount,
   avg(int_rate * 100) as interest_rate,
   avg(dti * 100) as DTI
      from
       financial_bank_loan
   group by 
      loan_status
      
      
 #MTD 
 SELECT loan_status,
 sum(total_payment) as total_amount_recevied,
 sum(loan_amount)as total_funded_Amount from financial_bank_loan
 WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12 
 group by loan_status
 
#month
 SELECT  
    MONTHNAME(issue_date) AS month_name,  
    COUNT(id) AS total_loan_application,  
    SUM(loan_amount) AS total_funded_amount,  
    SUM(total_payment) AS total_received_amount  
FROM financial_bank_loan  
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)  
ORDER BY MONTH(issue_date);

#Regional analysis by state

select address_state,
    COUNT(id) AS total_loan_application,  
    SUM(loan_amount) AS total_funded_amount,  
    SUM(total_payment) AS total_received_amount  
from financial_bank_loan   
group by address_state
order by sum(loan_amount) desc

#loan term analysis

select
	term,
    COUNT(id) AS total_loan_application,  
    SUM(loan_amount) AS total_funded_amount,  
    SUM(total_payment) AS total_received_amount  
from financial_bank_loan   
group by term
order by term

#find Employeee Lenght Analysis
select
	emp_length,
    COUNT(id) AS total_loan_application,  
    SUM(loan_amount) AS total_funded_amount,  
    SUM(total_payment) AS total_received_amount  
from financial_bank_loan   
group by emp_length
order by emp_length

#loan purpose breakdown 
select
	purpose,
    COUNT(id) AS total_loan_application,  
    SUM(loan_amount) AS total_funded_amount,  
    SUM(total_payment) AS total_received_amount  
from financial_bank_loan   
group by purpose
order by count(id) desc

#Home ownership 
select
	home_ownership,
    COUNT(id) AS total_loan_application,  
    SUM(loan_amount) AS total_funded_amount,  
    SUM(total_payment) AS total_received_amount  
from financial_bank_loan   
group by home_ownership
order by count(id) desc	

select* from financial_bank_loan

UPDATE financial_bank_loan
SET issue_date = STR_TO_DATE(issue_date, '%d/%m/%Y');



SELECT issue_date FROM financial_bank_loan LIMIT 10;

UPDATE financial_bank_loan 
SET issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y');


ALTER TABLE financial_bank_loan 
MODIFY COLUMN issue_date DATE;

Alter table financial_bank_loan 
alter column issue_date varchar(20);

ALTER TABLE financial_bank_loan 
MODIFY COLUMN issue_date VARCHAR(20);
