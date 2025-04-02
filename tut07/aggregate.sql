CREATE TYPE my_mean_state AS (totalsum numeric, count integer);

CREATE OR REPLACE FUNCTION my_mean_sfunc(
    curr_state my_mean_state, 
    value numeric
) RETURNS my_mean_state AS $$
DECLARE
    res_state my_mean_state;
BEGIN
    res_state.totalsum := curr_state.totalsum + value;
    res_state.count := curr_state.count + 1;
    RETURN res_state;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION my_mean_finalfunc(
    final_state my_mean_state
) RETURNS numeric AS $$
BEGIN
    RETURN final_state.totalsum / final_state.count;
END
$$ LANGUAGE plpgsql;

CREATE AGGREGATE my_mean (numeric) (
    sfunc = my_mean_sfunc,
    stype = my_mean_state,
    initcond = '(0, 0)',
    finalfunc = my_mean_finalfunc
)
