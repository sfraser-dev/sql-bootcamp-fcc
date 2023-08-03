USE fcc;

-- Find all employess ordered by salary (this is a "prompt" question)
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
SELECT * FROM branch_supplier WHERE supplier_name LIKE '%Label%';

-- Find any employ born in October (date is in format 2000-01-01)
SELECT * FROM employee WHERE birth_day LIKE '____-10-__';

-- Find any clients who might be schools
SELECT * FROM client WHERE client_name LIKE '%chool%';

-- ----- SQL Unions (a "weak" join, combines two select statements)
-- Find a list of employee and branch names
SELECT first_name FROM employee;  -- just emplyee names
SELECT branch_name FROM branch;   -- just name of branches
SELECT first_name FROM employee UNION SELECT branch_name FROM branch;   -- Union
SELECT first_name FROM employee UNION SELECT branch_name FROM branch UNION SELECT client_name FROM client;

-- Find a list of all clients & branch suppliers' names
SELECT client_name FROM client UNION SELECT supplier_name FROM branch_supplier; 

-- Find a list of all money spent or earned by the company
SELECT total_sales AS 'Spent / Earned Money' FROM works_with UNION SELECT salary FROM employee;

-- ----- SQL Join
-- Find all branches and the names of their managers
SELECT branch_name AS 'Branch', first_name 'First Name', last_name AS 'Surname'
FROM employee
INNER JOIN branch ON emp_id = mgr_id;

SELECT branch_name AS 'Branch', first_name 'First Name', last_name AS 'Surname'
FROM employee
LEFT JOIN branch ON emp_id = mgr_id;

SELECT branch_name AS 'Branch', first_name 'First Name', last_name AS 'Surname'
FROM employee
RIGHT JOIN branch ON emp_id = mgr_id;

-- ----- Nested Query (more advanced but used a lot, uses IN keyword, not ON like Joins)
-- Multiple select statements to get specific piece of information
-- Find names of all employees that have sold over 30000 to a single client
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
	-- This executes first, returns a list of emp_ids
	SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);

-- Find all clients who are handled by the branch that Michael
-- Scott manages. Assume you know Michaels' ID (102)
-- No IN keyword, now using equality "="
SELECT client_name
FROM client
WHERE branch_id = (
	-- This executes first, returns a branch_id
	SELECT branch_id
    FROM branch
    WHERE mgr_id = 102
    LIMIT 1  -- just return one
);

-- ----- On delete (set null and cascade)
-- DELETE FROM employee WHERE emp_id = 102;
-- DELETE FROM branch WHERE branch_id = 2;