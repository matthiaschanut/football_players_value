The goal of the project was to use a free data set of Transfermarkt data in order to provide an in-depth analysis of football players’ value.

What is the good value for a player?
How can clubs asset it?
Which characteristics should they take into account?


Python folder:
Scripts to extract the data from Kaggle and from Google Sheet (score_matric) to BigQuery 

Models folder:
Staging: import tables on DBT with a few data cleaning / formating steps
Int: intermediate views to aggregate data according to specific needs (by season / player / team etc...)
Kpi: final tables used for the dashboard on Power BI 

  ![image](https://github.com/matthiaschanut/football_players_value/assets/130972807/baa99c49-bc6f-49c0-96ce-c6b8cd4d6b9c)

