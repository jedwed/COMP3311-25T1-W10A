-- Q14
-- Given orgunit ID, print complete name based on rules:
-- University: UNSW
-- Faculty: Base name
-- School, Department, Centre, Institute: Prepend the orgunittype
-- Other orgunittypes are ignored
CREATE OR REPLACE FUNCTION unitName(_ouid integer) RETURNS TEXT AS $$
DECLARE
    _oname text;
    _otype text;
BEGIN

    SELECT
        o.longname,
        ot.name
    INTO
        _oname,
        _otype
    FROM
        orgunit AS o
    JOIN
        orgunittype AS ot
        ON o.utype = ot.id
    WHERE 
        o.id = _ouid;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No such ouid';
    END IF;

    -- Alternative way to error-check. 
    -- We could also select the COUNT(*) and check if it is zero.
    -- IF NOT EXISTS (
    --     SELECT 
    --         *
    --     FROM 
    --         orgunit
    --     WHERE 
    --         id = _ouid
    -- ) THEN 
    --     RAISE EXCEPTION 'Org unit doesnt exist';
    -- END IF;

    IF _otype = 'University' THEN
        RETURN 'UNSW';
    ELSIF _otype = 'Faculty' THEN
        RETURN _oname;
    ELSIF _otype = 'School' THEN
        RETURN 'School of ' || _oname;
    ELSE
        RETURN NULL;
    END IF;
END

$$ LANGUAGE plpgsql;

-- Q15
-- 
CREATE OR REPLACE FUNCTION unitId(_partName text) RETURNS setof integer AS $$
    SELECT
        id
    FROM 
        orgunit
    WHERE
        longname ILIKE '%' || _partName || '%';
$$ LANGUAGE sql;

-- Q16
CREATE OR REPLACE FUNCTION facultyof(_ouid integer) RETURNS integer AS $$
DECLARE
    _otype text;
    _ownerid integer;
BEGIN
    SELECT
        ot.name
    INTO
        _otype
    FROM
        orgunit AS o
    JOIN
        orgunittype AS ot
        ON o.utype = ot.id
    WHERE 
        o.id = _ouid;

    IF NOT found THEN
        RAISE EXCEPTION 'No org unit exists with id %', _ouid;
    END IF;
    
    -- Base Case
    IF _otype = 'Faculty' THEN
        RETURN _ouid;
    END IF;

    -- Recursive Case
    SELECT 
        owner
    INTO
        _ownerid
    FROM
        unitgroups
    WHERE
        member = _ouid;

    IF _ownerid IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN facultyof(_ownerid);
END
$$ LANGUAGE plpgsql;
