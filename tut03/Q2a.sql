CREATE TABLE subject (
    subject_code char(8) CHECK (subject_code ~ '[A-Z]{4}[0-9]{4}'),
    PRIMARY KEY (subject_code)
);

CREATE TABLE teacher (
    staff_number integer PRIMARY KEY,
    teaches char(8),
    semester char(4),
    FOREIGN KEY (teaches) REFERENCES subject (subject_code)
);
