# Tut03

## Today: ER -> Relational Mapping, SQL DDL, ER -> SQL Mapping

### Revision

Requirements -> ER Model -> Relational Model -> Database Schema

- ER Model - conceptual level model
- Relational Model - implementation level model
- Relational Model consists of **Relations** (which are tables)

### ER -> Relational Mapping

- Entity set -> Relation/Table
- Attribute -> Attribute
- Relationship -> depends on **cardinality**:
  - M:N Relationship -> Relation/Table
  - 1:M and 1:1 Relationship -> Foreign Key on chosen one of the two participating entities
    - 1:M -> Foreign key on the M-side entity
    - 1:1 -> Foreign key on the side of the entity with total participation.
      - If both sides or neither sides have total participation: either is fine
- Inheritance: 3 styles
  - Single table with nulls
  - OO Style: Object-oriented styles
    Table per entity, copy the parent entity attributes into all the inheriting entites
  - ER Style: Table per entity, the inheriting entities reference the parent entity via a foreign key
- Q2, Q3, Q4, Q12

## SQL DDL

- SQL DDL: SQL Data Definition Language, a sublanguage
  - SQL commands that can define a database schema (`CREATE`, `DROP`, etc.)
- Every single relation/table in the relational model can be translated into an SQL table
  - Some domains(types) + constraints that you have to determine
  - Some details lost in translation during ER -> Relational mapping, consult ER diagram
    - eg. Entities with total participation in a relationship should have a constraint that the foreign key is `not null`

```sql
create table TableName (
    attribute1 datatype,
    attribute2 datatype,
    -- A single primary key could be declared like this:
    -- "attribute1 datatype primary key,"
    -- Composite primary keys muts be declared like this:
    primary key (attribute1, attribute2)
    foreign key (attribute2) references OtherTable(otherTablePrimaryKey)
);
```

### Creating a database for Q2b

1. Start your PostgreSQL server by typing `p1` into your terminal
2. Type `createdb <db_name>` into your terminal to create a new database (eg. `createdb unsw`)
3. Type `psql <db_name> -f Q2b_schema.sql` into your terminal to populate the schema with the defined tables
4. Type `psql <db_name> -f Q2b_data.sql` into your terminal to populate the tables with tuples
5. Type `psql <db_name>` to access the database
   - `\d` will display information about your schema
   - Try running some SQL commands in the database!
6. When done, type `p0` into your terminal to stop the server
