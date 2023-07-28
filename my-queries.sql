USE fcc;

-- Find all employess ordered by salary
SELECT * FROM employee ORDER BY salary DESC;

-- Find all employees ordered by sex then name
SELECT * FROM employee ORDER BY sex, first_name;

-- Find the first 5 employees in the table
SELECT * FROM employee LIMIT 5;

-- Find first and last names of all employees
SELECT first_name AS 'Forename', last_name AS 'Surname' FROM employee;

-- Find out all the different genders
SELECT DISTINCT sex FROM employee;

-- ----- SQL FUNCTIONS (aggregates)
-- Find the number of employees (counts rows that have actual values)
SELECT COUNT(emp_id) FROM employee;

-- Find number of female employees born after 1970
SELECT COUNT(sex) FROM employee WHERE sex='F' AND birth_day > '1970-01-01';

-- Find the average of all employee salaries
SELECT AVG(salary) FROM employee;

-- Find the average of all male salaries
SELECT AVG(salary) FROM employee WHERE sex = 'M';

-- Find the sum of all employee salaries
SELECT SUM(salary) FROM employee;

-- Find out how many males and how many females there are
SELECT COUNT(sex), sex FROM employee GROUP BY sex;

-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id FROM works_with GROUP BY emp_id;

-- Find out the total number of sales made to each client
SELECT SUM(total_sales), client_id FROM works_with GROUP BY client_id;

-- ----- SQL Wildcards
-- Wildcard %: any amount
-- Wildcard _: single occurance
-- Wildcard LIKE keyword used

-- Find any clients who are an LLC
SELECT * FROM client WHERE client_name LIKE '%LLC%';

-- Find any supplier with Label in their name
SELECT * FROM branch_supplier WHERE client_name LIKE '%LLC%';
