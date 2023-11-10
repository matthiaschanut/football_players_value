SELECT
    t1.game_id,
    t1.player_id,
    t3.type,
    t2.sub_position,
    CASE 
        WHEN t3.type ='starting_lineup' THEN 50
        WHEN t3.type ='substitutes' THEN 35
        ELSE 0
    END AS starter_pts,
    CASE 
        WHEN t2.sub_position ='Goalkeeper' THEN t1.goals * 30
        WHEN t2.sub_position ='Centre-Back' THEN t1.goals * 25
        WHEN t2.sub_position ='Left-Back' THEN t1.goals * 20
        WHEN t2.sub_position ='Right-Back' THEN t1.goals * 20
        WHEN t2.sub_position ='Defensive Midfield' THEN t1.goals * 17
        WHEN t2.sub_position ='Central Midfield' THEN t1.goals * 15
        WHEN t2.sub_position ='Left Midfield' THEN t1.goals * 15
        WHEN t2.sub_position ='Right Midfield' THEN t1.goals * 15
        WHEN t2.sub_position ='Attacking Midfield' THEN t1.goals * 12
        WHEN t2.sub_position ='Left Winger' THEN t1.goals * 12
        WHEN t2.sub_position ='Right Winger' THEN t1.goals * 12
        WHEN t2.sub_position ='Second Striker' THEN t1.goals * 10
        WHEN t2.sub_position ='Centre-Forward' THEN t1.goals * 10
    END AS goal_pts,
    CASE
        WHEN t2.sub_position ='Goalkeeper' THEN t1.assists * 25
        WHEN t2.sub_position ='Centre-Back' THEN t1.assists * 25
        WHEN t2.sub_position ='Left-Back' THEN t1.assists * 20
        WHEN t2.sub_position ='Right-Back' THEN t1.assists * 20
        WHEN t2.sub_position ='Defensive Midfield' THEN t1.assists * 17
        WHEN t2.sub_position ='Central Midfield' THEN t1.assists * 15
        WHEN t2.sub_position ='Left Midfield' THEN t1.assists * 15
        WHEN t2.sub_position ='Right Midfield' THEN t1.assists * 15
        WHEN t2.sub_position ='Attacking Midfield' THEN t1.assists * 12
        WHEN t2.sub_position ='Left Winger' THEN t1.assists * 12
        WHEN t2.sub_position ='Right Winger' THEN t1.assists * 12
        WHEN t2.sub_position ='Second Striker' THEN t1.assists * 10
        WHEN t2.sub_position ='Centre-Forward' THEN t1.assists * 10
    END AS assists_pts,
    CASE
        WHEN t2.sub_position ='Goalkeeper' AND t1.yellow_cards > 0 THEN -15
        WHEN t2.sub_position ='Centre-Back' AND t1.yellow_cards > 0 THEN -8
        WHEN t2.sub_position ='Left-Back' AND t1.yellow_cards > 0 THEN -8
        WHEN t2.sub_position ='Right-Back' AND t1.yellow_cards > 0 THEN -8
        WHEN t2.sub_position ='Defensive Midfield' AND t1.yellow_cards > 0 THEN -6 
        WHEN t2.sub_position ='Central Midfield' AND t1.yellow_cards > 0 THEN -5 
        WHEN t2.sub_position ='Left Midfield' AND t1.yellow_cards > 0 THEN -5 
        WHEN t2.sub_position ='Right Midfield' AND t1.yellow_cards > 0 THEN -5
        WHEN t2.sub_position ='Attacking Midfield' AND t1.yellow_cards > 0 THEN -3
        WHEN t2.sub_position ='Left Winger' AND t1.yellow_cards > 0 THEN -3
        WHEN t2.sub_position ='Right Winger' AND t1.yellow_cards > 0 THEN -3
        WHEN t2.sub_position ='Second Striker' AND t1.yellow_cards > 0 THEN -3
        WHEN t2.sub_position ='Centre-Forward' AND t1.yellow_cards > 0 THEN -3
    END AS yellow_cards_pts


FROM {{ ref('stg_appearances') }} t1
LEFT JOIN {{ ref('stg_players') }} t2 ON t1.player_id = t2.player_id
LEFT JOIN {{ ref('stg_game_lineups') }} t3 ON t1.game_id = t3.game_id
WHERE sub_position IS NOT NULL