-- ER Style
CREATE TABLE P (
    id integer PRIMARY KEY,
    a text
);


CREATE TABLE R (
    id integer PRIMARY KEY REFERENCES P (id),
    b text
);

CREATE TABLE S (
    id integer PRIMARY KEY REFERENCES P (id),
    c text
);

CREATE TABLE T (
    id integer PRIMARY KEY REFERENCES P (id),
    d text
);

-- OO Style
CREATE TABLE P (
    id integer PRIMARY KEY REFERENCES P (id),
    a text
);

CREATE TABLE R (
    id integer PRIMARY KEY REFERENCES P (id),
    a text,
    b text
)

CREATE TABLE S (
    id integer PRIMARY KEY REFERENCES P (id),
    a text,
    c text
)

CREATE TABLE T (
    id integer PRIMARY KEY REFERENCES P (id),
    a text,
    d text
)


-- Single Table w/ Nulls
CREATE TABLE P (
    id integer PRIMARY KEY,
    a text,
    b text,
    c text,
    d text,
    subclass text
)

-- NOTE: No way to enforce disjoint constraint without 
-- global constraints (e.g. triggers) we cover later in the course
