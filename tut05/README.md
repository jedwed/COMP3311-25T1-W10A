# Tut05

## Today: SQL & PL/pgSQL functions

- SQL Functions: Takes input, executes a list of SQL statement(s) & returns the **last** query of the list
  - Can create 'parameterized views'
- PL/pgSQL: A procedural language for PostgreSQL: can define more advanced functions, contains common programming constructs such as if statements, for loops, etc.

```sql
CREATE OR REPLACE FUNCTION functionName(arg1 arg1Type, ...) RETURNS returnType
AS $$
    {function body}
$$ language ( sql | plpgsql);
```

## PL/pgSQL

- `:=` for assignment, `=` for comparison (no double equals `==` comparison operator)
- `SELECT attr INTO variable`: storing useful information obtained from queries into variables for future use
- `found` special PostgreSQL variable: set after each query, true if query returned at least one row
- Debugging: `RAISE NOTICE 'Value of variable x: %', x;`
