
-- Inspiration from: https://datalemur.com/questions/rolling-average-tweets


CREATE TABLE tweets (
    user_id INT,
    tweet_date DATETIME,
    tweet_count INT
);

INSERT INTO tweets (user_id, tweet_date, tweet_count) VALUES
(111, '2022-06-01 00:00:00', 2),
(111, '2022-06-02 00:00:00', 1),
(111, '2022-06-03 00:00:00', 3),
(111, '2022-06-04 00:00:00', 4),
(111, '2022-06-05 00:00:00', 5),
(111, '2022-06-06 00:00:00', 4),
(111, '2022-06-07 00:00:00', 6),
(199, '2022-06-01 00:00:00', 7),
(199, '2022-06-02 00:00:00', 5),
(199, '2022-06-03 00:00:00', 9),
(199, '2022-06-04 00:00:00', 1),
(199, '2022-06-05 00:00:00', 8),
(199, '2022-06-06 00:00:00', 2),
(199, '2022-06-07 00:00:00', 2),
(254, '2022-06-01 00:00:00', 1),
(254, '2022-06-02 00:00:00', 1),
(254, '2022-06-03 00:00:00', 2),
(254, '2022-06-04 00:00:00', 1),
(254, '2022-06-05 00:00:00', 3),
(254, '2022-06-06 00:00:00', 1),
(254, '2022-06-07 00:00:00', 3);



-- 3 day rolling average
SELECT user_id
, tweet_date
,ROUND(AVG(tweet_count) 
                OVER(partition by user_id 
                    ORDER BY tweet_date
                    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) 
                  as rolling_avg_3d
FROM tweets;


