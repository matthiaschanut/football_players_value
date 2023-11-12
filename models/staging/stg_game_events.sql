SELECT 
    *EXCEPT(date),
    CAST(date AS DATE) as date 
FROM `transfermarkt-391212.kaggle_data.game_events` t1
ORDER BY date ASC
