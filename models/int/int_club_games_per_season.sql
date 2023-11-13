SELECT
    t1.club_id,
    t1.game_id,
    t2.season
FROM {{ ref('stg_club_games') }} t1
LEFT JOIN {{ ref('stg_games') }} t2 ON t1.game_id = t2.game_id