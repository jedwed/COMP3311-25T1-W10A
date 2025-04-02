
# Tut07

## Today: Constraints, Triggers and Aggregates

- Constraints we've seen so far: `NOT NULL`, `UNIQUE`, `CHECK`
- We may require more complex constraints (constraints involving multiple tables) -> schema level constraints

### Assertions

- Checks schema level constraints
- Expensive: check occurs for every modification on involved tables
- _Note: PostgreSQL (and most RDBMS) doesn't support assertions_

### Triggers

- A stored procedure which is automatically 'triggered' by an event
- Provides more granular control over when checks occur
- Can also be used to **enforce/maintain** constraints as opposed to checking them
- `BEFORE`, `AFTER`
- `for each row`, `for each statement`
- Special variables: `old`, `new`, `TG_OP` (<https://www.postgresql.org/docs/current/plpgsql-trigger.html>)
- If an exception is raised by a trigger: **ROLLBACK** changes
- Q10

### Aggregates

- Reduce a set of values into a single value
- Examples we've seen: `MAX()`, `MIN()`, `COUNT()`, `STRING_AGG()`, often used in conjunction with `GROUP BY`
- Can define your own aggregate (similar to `.reduce()` or `fold()` in other languages)
  - Achieved using a state + state transition function
