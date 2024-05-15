-- DAY 1 --
-- CHALLENGE INSPIRATION FROM: https://datalemur.com/questions/user-retention


CREATE DATABASE dataLemurDB;
USE dataLemurDB;

CREATE TABLE user_actions(
user_id INT,
event_id INT,
event_type VARCHAR(10),
event_date DATETIME
);


INSERT INTO user_actions VALUES (445, 7765, 'sign-in', '2022-05-31 12:00:00');
INSERT INTO user_actions VALUES (445, 3634, 'like', '2022-06-05 12:00:00');
INSERT INTO user_actions VALUES (648, 3124, 'like', '2022-06-18 12:00:00');
INSERT INTO user_actions VALUES (648, 2725, 'sign-in', '2022-06-22 12:00:00');
INSERT INTO user_actions VALUES (648, 8568, 'comment', '2022-07-03 12:00:00');
INSERT INTO user_actions VALUES (445, 4363, 'sign-in', '2022-07-05 12:00:00');
INSERT INTO user_actions VALUES (445, 2425, 'like', '2022-07-06 12:00:00');
INSERT INTO user_actions VALUES (445, 2484, 'like', '2022-07-22 12:00:00');
INSERT INTO user_actions VALUES (648, 1423, 'sign-in', '2022-07-26 12:00:00');
INSERT INTO user_actions VALUES (445, 5235, 'comment', '2022-07-29 12:00:00');
INSERT INTO user_actions VALUES (742, 6458, 'sign-in', '2022-07-03 12:00:00');
INSERT INTO user_actions VALUES (742, 1374, 'comment', '2022-07-19 12:00:00');

SELECT * FROM user_actions;



SELECT
	MONTH(current_mth.event_date) AS month,
	COUNT(DISTINCT(current_mth.user_id)) AS monthly_active_users
FROM user_actions AS current_mth
WHERE EXISTS (
SELECT last_mth.user_id
FROM user_actions AS last_mth
WHERE last_mth.user_id = current_mth.user_id
AND MONTH(last_mth.event_date) = MONTH(current_mth.event_date) - 1
)
AND MONTH(current_mth.event_date) = 7
AND YEAR(current_mth.event_date) = 2022
GROUP BY MONTH(event_date);







