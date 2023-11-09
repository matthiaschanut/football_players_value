SELECT
    t1.player_id,
    t2.first_name,
    t2.last_name,
    t2.name,
    t1.date,
    DATE_DIFF(t1.date, t2.date_of_birth, YEAR) AS age,
    t1.market_value_in_eur
FROM {{ ref('stg_player_valuations') }} t1
LEFT JOIN {{ ref('stg_players') }} t2 ON t1.player_id = t2.player_id
WHERE NAME IS NOT NULL
ORDER BY name ASC, age ASC