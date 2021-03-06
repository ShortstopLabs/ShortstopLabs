#ShortstopLabs
#2019 Season Win Totals
#Last Updated: 2019-03-07

SELECT A.TEAM, A.RUNS, B.EARNED_RUNS,
ROUND((0.000683* (A.RUNS - B.EARNED_RUNS) + 0.50) * 162,0) AS EXPECTED_WINS_ROTHMAN,
162-ROUND((0.000683* (A.RUNS - B.EARNED_RUNS) + 0.50) * 162,0)  as EXPECTED_LOSSES_ROTHMAN,
ROUND((POWER(A.RUNS,1.81) / (POWER(A.RUNS, 1.81)  + POWER(B.EARNED_RUNS, 1.81))) * 162,0) AS EXPECTED_WINS_JAMES,
162-ROUND((POWER(A.RUNS,1.81) / (POWER(A.RUNS, 1.81)  + POWER(B.EARNED_RUNS, 1.81))) * 162,0) AS EXPECTED_LOSSES_JAMES
FROM (
SELECT A.TEAM, SUM(A.R) AS RUNS
FROM ShortstopLabs.2019_steamer_batting A
WHERE A.TEAM IS NOT NULL
AND A.TEAM <> ''
GROUP BY TEAM
) A
LEFT JOIN (
SELECT A.TEAM, SUM(A.ER) AS EARNED_RUNS
FROM ShortstopLabs.2018_steamer_pitching A
WHERE A.TEAM IS NOT NULL
AND A.TEAM <> ''
GROUP BY TEAM
)B
ON A.TEAM = B.TEAM