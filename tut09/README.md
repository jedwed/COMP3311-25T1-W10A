# Tut09

## Today: Relational Design Theory

- **Good database design**
  - Meets requirements
  - Reduces **redundancy**
    - Leads to **more efficient storage** (don't store redundant data)
    - Minimizes probability of **data corruption/inconsistency**
    - However, redundancy might lead to improved performance (saves the overhead of joining tables together)

### Functional Dependency (fd)

- Describes relationships between **sets of attributes**
- Determinant X -> Dependent Y
  - X determines Y
  - Y is functionally dependent on X
- X -> Y if for all tuples t1 & t2 in relation R: `t1[x] = t2[x] => t1[y] = t2[y]`
- In more casual terms: X -> Y if every X value has **only one corresponding Y value**

### Inference Rules

Armstrong's 3 rules

1. Reflexivity: `X -> X`
2. Augmentation: `X -> Y => XZ -> YZ`
3. Transitivity: `X -> Y, Y -> Z => X -> Z`

The following rules can be derived from the rules above, but are useful

4. Additivity: `X -> Y, X -> Z => X -> YZ`
5. Projectivity: `X -> YZ => X -> Y, X -> Z`
6. Pseudotransitivity: `X -> Y, YZ -> W => XZ -> W`

### Closures

- Closures on fds: set of all derivable fds
- However, the set of all derivable fds is very large: grows exponentially!
- Hence, we define closures on set of attributes instead
- X+ = {set of derivable attributes}

To computer closure `X+`:

1. Initialise closure set `{X}` (reflexivity, trivially attibrute X is deriavable from attribute X)
2. For all fds `A -> B`: If A is a subset of the closure set, add B to closure
3. Repeat step 2 until no more attributes can be added to the closure
   (ie. closure set is unchanged after a loop over all fds)

### Superkey and candidate key

- A superkey of relation R is a set of attributes whose closure is all attributes in relation R
- A candidate key is a minimal superkey
  - Candidate for a primary key

### Normalisation and Normal Forms

- Normalisation is decomposing a relation into smaller relations to remove redundancy
- Normal forms 1NF...5NF, 1NF has most redundancy (caveman single table spreadsheet), 5NF least redundant
- The normal forms we're concerned with in this course are 3NF and Boyce-Codd Normal Form (BCNF aka. 3.5NF)
  - These are the most common normal forms
- A database schema is in xNF if all its relations are in xNF

#### 3NF and BCNF

3 Conditions on fds:

1. X -> Y is trivial (Y is a subset of X) (eg. X -> X and XY -> Y are trivial fds)
2. X is a superkey
3. Y is a subset of a candidate key (primary attribute)

- A schema is in 3NF if for all fds, either 1. or 2. or 3. hold
- A schema is in BCNF if for all fds, either 1. or 2. hold
- Note: BCNF (aka. 3.5NF) is a more strict version of 3NF

#### 3NF Decomposition

3 Steps

1. Compute minimal cover
2. For all fds in minimal cover `A -> B`, create a new relation by flattening
   (ie. create a new table with attributes `AB`)
3. If none of newly created relations contain any candidate key, create a new relation with attributes of any candidate key

##### Minimal Cover

Minimal cover of F = Fc: Basis set of fds such that (Fc)+ = F+ (note we're dealing with fd closures now, not attribute closures)

3 Steps

1. Convert fds into canonical form (A -> BC becomes A -> B, A -> C)
2. Reduce multi-attribute determinants (reduce LHS)
3. Remove and redundant fds

<https://www.cs.emory.edu/~cheung/Courses/377/Syllabus/9-NormalForms/FD-equi-3.html> is a pretty useful website (though sometimes steps 2. and 3. can be done more simply by inspection)

#### BCNF Decomposition

Unfortunately, steps aren't as linear as 3NF decomposition

```
while exists a relation Ri not in BCNF:
    find fd X -> Y in Ri that violates the conditions for BCNF
    replace/decompose Ri to two new relations (Ri - Y) and (XY)
```
