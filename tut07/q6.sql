CREATE TABLE R(
    a int, 
    b int, 
    c text
    -- we want primary key (a, b)
    -- (a, b ) is unique
    -- Neither a nor b can be null
);

CREATE OR REPLACE FUNCTION primary_key_check() RETURNS trigger AS $$
BEGIN
    -- Check that neither a nor b is null
    IF NEW.a IS NULL OR NEW.b IS NULL THEN
        RAISE EXCEPTION 'Primary key cannot be null';
    END IF;

    -- Preventing false negatives
    IF TG_OP = 'UPDATE' AND OLD.a = NEW.a AND OLD.b = NEW.b THEN
        RETURN NEW;
    END IF;

    -- Primary key (a,b) doesn't already exist in table
    IF EXISTS (
        SELECT 
            *
        FROM
            r
        WHERE
            a = NEW.a AND b = NEW.b
    ) THEN
        RAISE EXCEPTION 'Primary key (a,b) already exists';
    END IF;
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER primary_key_trigger
    BEFORE INSERT OR UPDATE
    ON r
    FOR EACH ROW
    EXECUTE FUNCTION primary_key_check();


