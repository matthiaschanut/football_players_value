SELECT 
    * EXCEPT(country_name, domestic_league_code),
    CASE 
        WHEN country_name IS NULL THEN "International"
        ELSE country_name
        END AS country_name,
    CASE
        WHEN domestic_league_code IS NULL THEN "Int"
        ELSE domestic_league_code
        END AS domestic_league_code 
FROM `transfermarkt-391212.kaggle_data.competitions` 