CREATE OR REPLACE VIEW supplier_parts (sid, sname, address, pid, pname, colour, cost) AS SELECT 
        s.sid,
        s.sname,
        s.address,
        p.pid,
        p.pname,
        p.colour,
        c.cost
    FROM
        suppliers AS s
    JOIN
        catalog AS c
        ON s.sid = c.sid
    JOIN
        parts as p
        ON c.pid = p.pid;

/*
 * Q12
 * Find the names of suppliers who supply some red part.
 */
SELECT
    DISTINCT sname
FROM
    supplier_parts
WHERE
    colour = 'red';



/*
 * Q13
 * Find the sids of suppliers who supply some red or green part.
 */
SELECT
    DISTINCT sid
FROM
    supplier_parts
WHERE
    colour = 'red' OR colour = 'green';


/*
 * Q15
 * Find the sids of suppliers who supply some red part and some green part.
 *
 */

-- NOTE: using AND in the condition fails: the colour attribute cannot simultaneously be red and green
SELECT
    DISTINCT sid
FROM
    supplier_parts
WHERE
    colour = 'red'
INTERSECT 
SELECT
    DISTINCT sid
FROM
    supplier_parts
WHERE
    colour = 'green';



/*
 * Q16
 * Find the sids of suppliers who supply every part.
 */

-- METHOD 1
-- Find the number of parts each supplier supplies
-- If the number of parts a supplier supplies is equal to the number of parts in total, that supplier supplies every part
SELECT
    c.sid
FROM
    catalog AS c
GROUP BY
    c.sid
HAVING
    COUNT(*) = (
        SELECT
            COUNT(*)
        FROM
            parts
    );


-- METHOD 2
-- A supplier who supplies every part is equivalent to a supplier where there doesn't exist a part they don't supply
SELECT 
    DISTINCT sp.sid
FROM
    supplier_parts AS sp
WHERE 
    NOT EXISTS (
        -- Parts that the supplier hasn't supplied
        SELECT 
            pid
        FROM
            parts
        EXCEPT
        SELECT
            pid
        FROM
            catalog
        WHERE
            sid = sp.sid
    );
    

/*
 * Q22
 * Find the pids of the most expensive part(s) supplied by suppliers named "Yosemite Sham".
 */

SELECT 
    pid
FROM 
    supplier_parts
WHERE
    sname = 'Yosemite Sham' AND cost = (
        -- Subquery for the maximum cost
        SELECT
            MAX(cost)
        FROM
            supplier_parts
        WHERE
            sname = 'Yosemite Sham'
    );

-- NOTE: The following method is not recommended.
-- If there are multiple parts have the maximum cost, this query will only return one of them
-- SELECT 
--     pid
-- FROM
--     supplier_parts
-- WHERE
--     sname = 'Yosemite Sham'
-- ORDER BY
--     cost DESC
-- LIMIT 
--     1;
