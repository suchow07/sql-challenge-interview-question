-- DAY 3 --
-- CHALLENGE INSPIRATION FROM: https://datalemur.com/questions/time-spent-snaps



CREATE TABLE activities
			(activity_id INT,
			 user_id INT,
             activity_type VARCHAR(15),
             time_spent DECIMAL(5,2),
             activity_date	DATETIME            
            );
            
CREATE TABLE age_breakDown(
			user_id INT,
            age_bucket VARCHAR(10)
);
           
INSERT INTO activities VALUES(7274,	123, "open", 4.50, '2022-06-22 12:00:00');
INSERT INTO activities VALUES(2425,123, "send", 3.50, '2022-06-22 12:00:00');
INSERT INTO activities VALUES(1413,456, "send", 5.67, '2022-06-23 12:00:00');
INSERT INTO activities VALUES(2536,456, "open", 3.00, '2022-06-25 12:00:00');
INSERT INTO activities VALUES(8564,456, "send", 8.24, '2022-06-26 12:00:00');
INSERT INTO activities VALUES(5235,789, "send", 6.24, '2022-06-28 12:00:00');
INSERT INTO activities VALUES(4251,123, "open", 1.25, '2022-07-01 12:00:00');
INSERT INTO activities VALUES(1414, 789, "chat", 11.00, '2022-06-25 12:00:00');
INSERT INTO activities VALUES(1314, 123, "chat", 3.15, '2022-06-26 12:00:00');
INSERT INTO activities VALUES(1435, 789, "open", 5.25, '2022-07-02 12:00:00');


INSERT INTO age_breakdown VALUES(123, '31-35');
INSERT INTO age_breakdown VALUES(456, '26-30');
INSERT INTO age_breakdown VALUES(789, '21-25');



SELECT * FROM activities;
SELECT * FROM age_breakdown;

SELECT  
    b.age_bucket,
    ROUND(
      SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) /
      SUM(a.time_spent) * 100.0, 2) as send_perc,
    ROUND(
      SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) /
      SUM(a.time_spent) * 100.0, 2) as open_perc
FROM activities a
JOIN age_breakdown b 
  ON a.user_id = b.user_id
WHERE a.activity_type IN ('open', 'send')
GROUP BY b.age_bucket;
