SELECT
    t1.player_id,
    t3.season,
    t1.name,
    t1.current_age,
    --t1.current_club_name,
    --t1.position,
    t1.sub_position,
    SUM(t2.goals) as sum_goals,
    SUM(t2.assists) as sum_assists,
    SUM(t2.yellow_cards) as sum_yellow_cards,
    SUM(t2.red_cards) as sum_red_cards,
    ROUND((SUM(t2.minutes_played)/t5.team_min_played),2) as perc_min_played,
    AVG(t4.tot_pts) as avg_pts
FROM {{ ref('stg_players') }} t1
LEFT JOIN {{ ref('stg_appearances') }} t2 ON t1.player_id = t2.player_id
LEFT JOIN {{ ref('stg_games') }} t3 ON t2.game_id = t3.game_id
LEFT JOIN {{ ref('int_scoring_system') }} t4 ON t2.game_id = t4.game_id AND t1.player_id = t4.player_id
JOIN {{ ref('int_min_played_by_team') }} t5 ON t2.player_club_id = t5.club_id AND t3.season = t5.season
GROUP BY t1.player_id,t1.name,t1.current_age,t1.sub_position,t3.season,t5.team_min_played