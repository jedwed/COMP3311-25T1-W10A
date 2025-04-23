# Tut09

## Today: Relational Algebra, Transaction Processing

## Relational Algebra

- Procedural query language
- Theoretical foundation for implemented RDBMS languages (SQL)
  - SQL code -> Relational algebra similar to how C code -> Machine code

### Operations

Operators take relations (tables) as inputs and produces relations as outputs

Common operators (this course uses its own custom notation, commonly greek letters are used instead)

- Projection: `Proj[attributes](Relation)`
  - _Selects_ attributes from the relation
- Selection: `Sel[expression](Relation)`
  - Filters out tuples in the relation via the expression
  - The fact that this operator is named Selection is a bit confusing, given that Selecting attributes is achieved using the Projection operator :/
- Join: 2 types
  - Natural join `R Join S`: joins tuples in R and S that are equal on common attributes
  - Theta join `R Join[expr] S`: the join we're used to seeing
- Rename: `Rename[schema](Relation)`
  - Reassigns the schema in the relation
    - Can be used to rename the relation name and/or attribute names

More complex operators:

- Set operators: Union, Intersection, Difference
- Cartesian product: R1 X R2: all pairwise combinations of tuples in R1 and R2
  - The output relation should have the attributes of both relations R1 and R2 combined
  - If R1 has `m` tuples and R2 has `n` tuples: There are `m` times (product) `n` tuples in R1 X R2
- Division: R1 Div R2
  - Inverse of cartesian product

---

## Transactions

A transaction is a bundled set of operations/tasks. It must be ACID:

- **A**tomic
- **C**onsistent
- **I**solated
- **D**urable

Example: Overly simplified bank withdrawal transaction

- One read from balance in account: R(B)
- Subtract read balance by amount withdrawn W: B = B - W
- Check B > 0, i.e. there isn't a negative balance after withdrawal
- If B > 0, one write to balance: W(B)

Similar enough process for bank deposits

## Transaction Scheduling

The order the operations in multiple scheduled transactions are performed

Scenario: Two people, Adam and Bob, share the same bank account with a balance of $1000.
Adam deposits $2000 and at the same time (**concurrently**), Bob withdraws $500.
Hence, the final balance should be 1000 + 2000 - 500 = 2500

T1 is Adam's transaction
T2 is Bob's transaction

| T1                 | T2                | Database balance after operation |
|--------------------|-------------------|----------------------------------|
| R(B),B = 1000      |                   | 1000                             |
| B = B + 2000, W(B) |                   | 3000                             |
|                    | R(B), B = 3000    | 3000                             |
|                    | B = B - 500, W(B) | 2500                             |

```
T1: R(B) W(B)
T2:           R(B) W(B)
```

The above schedule is a **Serial schedule**
A serial schedule: each scheduled transaction is executed to completion before starting the next: **non-interleaving**

### Concurrency

Serial schedules are slower: if there are multiple transactions at once, a transaction must wait for all transactions scheduled before to complete.
Thus, the scheduler often **interleaves** transactions to enhance performance

However, interleaving schedules are **potentially dangerous**. Consider the following interleaved scheduling of the scenario above:

| T1                 | T2                | Database balance after operation |
|--------------------|-------------------|----------------------------------|
| R(B),B = 1000      |                   | 1000                             |
|                    | R(B), B = 1000    | 1000                             |
| B = B + 2000, W(B) |                   | 3000                             |
|                    | B = B - 500, W(B) | 500                              |

```
T1: R(B)      W(B)
T2:      R(B)      W(B)
```

This caused the balance to be $500! This is because Bob's withdrawal transaction
completely overwrote Adam's deposit transaction.

We require our schedules to be **serializable**: equivalent to a serial schedule

### Serializable Schedules

Two types of serializability:

#### 1. Conflict Serializable

Conflicting operations: Consider two consecutive operations to a resource X across two threads T1 T2:

- T1: R(X), T2: R(X) does not conflict, both threads read the same X even if the order were to be swapped
- T1: R(X), T2: W(X) does conflict, since swapping the order of execution and having T2 write to X first would cause T1 to read a different value of X
- T1: W(X), T2: R(X) conflicts for the same reason as above
- T1: W(X), T2: W(X) does conflict, since swapping the order of execution means the final version of X would change
To check: build a precedence graph: a node for each transaction and an edge for each conflicting pair. A cycle in the graph means the schedule is **not** conflict serializable.

#### 2. View Serializable

All conflict serializable schedules are view serializable, but not vice versa.

Summary: In a view serializable schedule:

- Each thread should read the same version of each shared resource as in the serial schedule.
- Each resource should be written to last by the same thread as in the serial schedule.
