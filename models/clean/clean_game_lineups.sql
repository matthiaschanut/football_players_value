SELECT
    t1.*EXCEPT(type),
    CASE
        WHEN t2.type = 'Substitutions' AND t1.player_id = t2.player_id THEN 'starting_lineup'
        WHEN t2.type = 'Substitutions' AND t1.player_id = t2.player_in_id THEN 'substitutes'
        ELSE t1.type
    END as type,
    t3.date
FROM {{ ref('stg_game_lineups') }} t1
LEFT JOIN {{ ref('stg_game_events') }} t2 ON t1.game_id = t2.game_id
LEFT JOIN {{ ref('clean_games') }} t3 ON t1.game_id = t3.game_id
ORDER BY t3.date ASC
