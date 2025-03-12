create table Employees (
      eid     integer,
      ename   text,
      age     integer,
      salary  real,
      primary key (eid)
);
create table Departments (
      did     integer,
      dname   text,
      budget  real,
      manager integer references Employees(eid) not null,
      primary key (did)
);
create table WorksIn (
      eid     integer references Employees(eid),
      did     integer DEFAULT 1 references Departments(did) ON DELETE CASCADE,
      percent real,
      primary key (eid,did)
);
