WITH sq1 AS (
    SELECT 
        *EXCEPT(date_of_birth),
        CAST(date_of_birth AS DATE) as date_of_birth,
    FROM `transfermarkt-391212.kaggle_data.players`
    )

SELECT
    *,
    DATE_DIFF(CURRENT_DATE,date_of_birth,YEAR) as current_age
FROM sq1
WHERE name IS NOT NULL