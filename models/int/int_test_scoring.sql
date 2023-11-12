SELECT
    season,
    AVG(starter_pts) as start,
    AVG(goal_pts) as goal,
    AVG(assists_pts) as ass,
    AVG(yellow_cards_pts) as yello,
    AVG(red_cards_pts) as red,
    AVG(no_yellow_pts) as no_yellow,
    AVG(goals_against_pts) as goal_a,
    AVG(clean_sheet_pts) as A,
    AVG(tot_pts) as tot,
FROM {{ ref('int_scoring_system') }}
GROUP BY season
