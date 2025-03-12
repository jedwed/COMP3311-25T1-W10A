# Tut04

## News: Assignment 1 Released

- Due 21:59:59 Friday 28th June 2024 (Week 5)
- Prac01-Prac05 are all useful for assignment 1

## Today: SQL Constraints, Updates, Queries

## SQL Sublanguages (DDL, DML, DQL)

A reminder that a lot of SQL syntax can be easily found in PostgreSQL documentation, a google search, lecture slides etc.

### SQL Data Definition Language (DDL)

- `CREATE {table/view}`
- `ALTER {table/view}`
- `DROP {table/view}`

### SQL Data Manipulation Language (DML)

- `INSERT INTO`
- `UPDATE`
- `DELETE`
  - May threaten referential integrity. 3 approaches to solve:
    1. prevent deletion (default PostgreSQL behaviour)
    2. `ON DELETE CASCADE` (if referenced item is deleted, referencing item is also deleted)
    3. `ON DELETE SET default` (sets to user-defined default value or `NULL`)

### SQL Data Query Language

- `SELECT`

  - `ORDER BY`
  - `GROUP BY`
    - Often used with **aggregates**:
      - `COUNT`
      - `MAX`, `MIN`
      - `STRING_AGG`
  - Often times, the data you want is **split across multiple tables**. To retrieve it, use `JOIN`
  - 4 types of joins: ![types of joins](https://learnsql.com/blog/learn-and-practice-sql-joins/2.png)
  - Default: `INNER JOIN`
  - Set operations: used to combine queries
    - `UNION`, `INTERSECT`, `EXCEPT`
  - For complex queries: useful to break it down into smaller sub-queries
    - SQL **Views** can define helpful abstractions

## Tutorial Questions Covered

- Q1-3, Q10-13, Q15-16
