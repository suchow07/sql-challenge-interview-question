
-- Challenge Inspiration:
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/

-- Write a solution to find the daily active user count for a period of 30 days 
-- ending 2019-07-27 inclusively. A user was active on someday if they made at 
-- least one activity on that day. Return the result table in any order.

CREATE TABLE activity (
    user_id INT,
    session_id INT,
    activity_date DATE,
    activity_type VARCHAR(30)  
);

INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES
(1, 1, '2019-07-20', 'open_session'),
(1, 1, '2019-07-20', 'scroll_down'),
(1, 1, '2019-07-20', 'end_session'),
(2, 4, '2019-07-20', 'open_session'),
(2, 4, '2019-07-21', 'send_message'),
(2, 4, '2019-07-21', 'end_session'),
(3, 2, '2019-07-21', 'open_session'),
(3, 2, '2019-07-21', 'send_message'),
(3, 2, '2019-07-21', 'end_session'),
(4, 3, '2019-06-25', 'open_session'),
(4, 3, '2019-06-25', 'end_session');


SELECT activity_date AS day, 
       COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
  AND activity_type IS NOT NULL
GROUP BY activity_date;
