SELECT
    t1.player_id,
    /*t3.name,
    t3.current_age,
    t3.current_club_name,
    t3.position,
    t3.sub_position,*/
    t2.season,
    ROUND(SUM(t1.goals),0) as sum_goals,
    ROUND(SUM(t1.assists),0) as sum_assists,
    ROUND(SUM(yellow_cards),0) as sum_yellow_cards,
    ROUND(SUM(red_cards),0) as sum_red_cards,
    ROUND(SUM(minutes_played)/(COUNT(t2.game_id)*90),2) as perc_min_played,
FROM {{ ref('stg_appearances') }} t1
LEFT JOIN {{ ref('clean_games') }} t2 ON t1.game_id = t2.game_id
LEFT JOIN {{ ref('clean_players') }} t3 ON t1.player_id = t3.player_id
GROUP BY player_id, name, current_age, current_club_name, position, sub_position, season