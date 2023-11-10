WITH sq1 AS (
    SELECT
        t1.player_id,
        t2.first_name,
        t2.last_name,
        t2.date_of_birth,
        t1.date,
        DATE_DIFF(t1.date, t2.date_of_birth, YEAR) AS age,
        t1.market_value_in_eur,
        t1.current_club_id,
        t1.last_season,
        t2.sub_position,
        t2.position,
        t2.city_of_birth,
        t2.country_of_citizenship,
        t2.current_club_name,
        t2.current_club_domestic_competition_id
    FROM {{ref('stg_player_valuations')}} t1
    LEFT JOIN {{ref('int_players')}} t2
    ON t1.player_id = t2.player_id
    WHERE position NOT IN ("Missing")
)

SELECT
    sq1.*,
    t2.name AS competition_name
FROM sq1
LEFT JOIN {{ref('int_competitions')}} t2
ON current_club_domestic_competition_id = competition_id
WHERE age <36



