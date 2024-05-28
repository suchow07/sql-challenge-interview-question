-- DAY 6 --
-- CHALLENGE INSPIRATION FROM: https://leetcode.com/problems/average-time-of-process-per-machine/description
-- TASK --
-- Write a solution to find the average time each machine takes to complete a process.
-- The time to complete a process is the 'end' timestamp minus the 'start' timestamp. 
-- The average time is calculated by the total time to complete every process on the machine 
-- divided by the number of processes that were run.
-- The resulting table should have the machine_id along with the average time as processing_time,
-- which should be rounded to 3 decimal places.
-- Return the result table in any order.


-- Create the table
CREATE TABLE Activity (
    machine_id INT,
    process_id INT,
    activity_type ENUM('start', 'end'),
    timestamp FLOAT,
    PRIMARY KEY (machine_id, process_id, activity_type)
);

-- Insert data into the table
INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES
(0, 0, 'start', 0.712),
(0, 0, 'end', 1.52),
(0, 1, 'start', 3.14),
(0, 1, 'end', 4.12),
(1, 0, 'start', 0.55),
(1, 0, 'end', 1.55),
(1, 1, 'start', 0.43),
(1, 1, 'end', 1.42),
(2, 0, 'start', 4.1),
(2, 0, 'end', 4.512),
(2, 1, 'start', 2.5),
(2, 1, 'end', 5);


SELECT a.machine_id,
ROUND(AVG(b.timestamp - a.timestamp), 3) AS processing_time
FROM Activity a, Activity b
WHERE a.activity_type = 'start'
AND   b.activity_type = 'end' AND a.machine_id = b.machine_id
AND   a.process_id = b.process_id
GROUP BY a.machine_id;