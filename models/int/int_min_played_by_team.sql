SELECT
    t2.season,
    t1.club_id,
    COUNT(DISTINCT t1.game_id)*90 as team_min_played
FROM {{ ref('stg_club_games') }} t1
JOIN {{ ref('stg_games') }} t2 ON t1.game_id = t2.game_id 
GROUP BY club_id,season
ORDER BY club_id ASC

