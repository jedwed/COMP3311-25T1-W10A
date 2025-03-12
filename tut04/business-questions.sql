/*
 * Q2 
 * A new government initiative to get more young people into work 
 * cuts the salary levels of all workers under 25 by 20%. 
 * Write an SQL statement to implement this policy change.
 */

UPDATE
    employees
SET
    salary = salary * 0.8
WHERE
    age < 25;




/*
 * Q3
 * The company has several years of growth and high profits, 
 * and considers that the Sales department is primarily responsible for this. 
 * Write an SQL statement to give all employees in the Sales department a 10% pay rise.
 */

-- View: similar to helper functions, provides useful abstractions which
-- you can re-use + make code more readable
CREATE VIEW sales_employees AS
    SELECT
        w.eid
    FROM
        worksIn AS w
    JOIN
        departments as d
        ON w.did = d.did
    WHERE
        d.dname = 'Sales';

UPDATE
    employees
SET
    salary = salary * 1.1
WHERE
    eid IN (
        -- Subquery for employees in sales department
        SELECT
            eid
        FROM
            sales_employees
    );    


