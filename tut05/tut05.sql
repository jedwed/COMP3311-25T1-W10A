-- Q2: Write a PLpgSQL function that "spreads" the letters in some text.
-- 'My text' -> 'M y  T e x t'
CREATE OR REPLACE FUNCTION spread(input text) RETURNS text AS $$
DECLARE
    res text := '';
BEGIN
    FOR i IN 1..char_length(input) LOOP
        res := res || substring(input from i for 1) || ' ';
    END LOOP;
    RETURN trim(res);
END
$$ LANGUAGE plpgsql;

-- Q3
CREATE OR REPLACE FUNCTION seq(n integer) RETURNS setof integer AS $$
BEGIN
    FOR i IN 1..n LOOP
        RETURN NEXT i;
    END LOOP;
    RETURN;
END
$$ LANGUAGE plpgsql;
