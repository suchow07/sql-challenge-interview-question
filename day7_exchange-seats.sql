-- DAY 6 --
-- CHALLENGE INSPIRATION FROM: https://leetcode.com/problems/exchange-seats/description
-- TASK --
-- Write a solution to swap the seat id of every two consecutive students.
-- If the number of students is odd, the id of the last student is not swapped.
-- Return the result table ordered by id in ascending order.


CREATE TABLE Seat (
    id INT PRIMARY KEY,
    student VARCHAR(255)
);

INSERT INTO Seat (id, student) VALUES
    (1, 'Abbot'),
    (2, 'Doris'),
    (3, 'Emerson'),
    (4, 'Green'),
    (5, 'Jeames');

SELECT 
		(CASE WHEN id%2 = 1 AND id <> (SELECT MAX(id) FROM Seat) THEN id+1
		WHEN id%2= 0 THEN id -1
		ELSE id END
		) AS id,
		student
FROM Seat
ORDER BY id;