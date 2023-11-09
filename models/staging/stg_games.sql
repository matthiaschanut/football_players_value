SELECT 
    *EXCEPT(season),
    CONCAT(ROUND(season,0),"/",ROUND(season,0)+1) as season
FROM `transfermarkt-391212.kaggle_data.games` 
