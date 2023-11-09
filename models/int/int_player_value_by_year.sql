SELECT
    t1.player_id,
    t2.first_name,
    t2.last_name,
    t2.name,
    t2.date_of_birth,
    DATE_DIFF(t1.date, t2.date_of_birth, YEAR) AS age
FROM {{ ref('stg_player_valuations') }} t1
LEFT JOIN {{ ref('stg_players') }} t2 ON t1.player_id = t2.player_id
ORDER BY name ASC, age ASC