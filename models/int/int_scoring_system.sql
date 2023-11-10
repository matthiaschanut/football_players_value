-- TEST SCORING
WITH sq1 AS (
SELECT
    t1.game_id,
    t5.date,
    t5.season,
    t1.player_id,
    t2.name,
    t1.player_club_id,
    t3.type,
    t2.sub_position,
    CASE 
        WHEN t3.type ='starting_lineup' THEN t4.starting_lineup
        WHEN t3.type ='substitutes' THEN t4.substitutes
        ELSE 0
    END AS starter_pts,
    (t1.goals*t4.goals) as goal_pts,
    (t1.assists*t4.assists) as assists_pts,
    (t1.yellow_cards*t4.yellow_cards) as yellow_cards_pts,
    (t1.red_cards*t4.red_cards) as red_cards_pts,
    CASE 
        WHEN t1.yellow_cards = 0 THEN bonus_no_yellow
        ELSE 0
    END AS no_yellow_pts,
    CASE 
        WHEN t1.player_club_id = t5.home_club_id THEN t5.away_club_goals*t4.goals_against
        WHEN t1.player_club_id = t5.away_club_id THEN t5.home_club_goals*t4.goals_against
        ELSE 0
    END AS goals_against_pts,
    CASE 
        WHEN t1.player_club_id = t5.home_club_id AND t5.away_club_goals = 0 THEN t4.bonus_clean_sheet
        WHEN t1.player_club_id = t5.away_club_id AND t5.home_club_goals = 0 THEN t4.bonus_clean_sheet
        ELSE 0
    END AS clean_sheet_pts
FROM {{ ref('stg_appearances') }} t1
LEFT JOIN {{ ref('clean_players') }} t2 ON t1.player_id = t2.player_id
LEFT JOIN {{ ref('clean_game_lineups') }} t3 ON t1.game_id = t3.game_id
LEFT JOIN {{ ref('stg_scoring_matrix') }} t4 ON t2.sub_position = t4.sub_position
LEFT JOIN {{ ref('clean_games') }} t5 ON t1.game_id = t5.game_id
)

SELECT
    sq1.*,
    CASE
        WHEN (starter_pts + goal_pts + assists_pts + yellow_cards_pts + red_cards_pts + no_yellow_pts + goals_against_pts + clean_sheet_pts) > 100 THEN 100
        WHEN (starter_pts + goal_pts + assists_pts + yellow_cards_pts + red_cards_pts + no_yellow_pts + goals_against_pts + clean_sheet_pts) < 0 THEN 0
        ELSE (starter_pts + goal_pts + assists_pts + yellow_cards_pts + red_cards_pts + no_yellow_pts + goals_against_pts + clean_sheet_pts) 
    END AS tot_pts
FROM sq1
ORDER BY tot_pts DESC
--WHERE t2.sub_position IS NOT NULL AND t3.type IS NULL AND t1.player_id = 607223.0
