CREATE DATABASE salesdb;
USE salesdb;

CREATE TABLE learners(
  learner_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  country VARCHAR(100) NOT NULL
  );
  
 CREATE TABLE courses(
  course_id INT AUTO_INCREMENT PRIMARY KEY,
  course_name VARCHAR(100) NOT NULL,
  category VARCHAR(100) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL
  );
  
CREATE TABLE purchases(
  purchase_id INT AUTO_INCREMENT PRIMARY KEY,
  learner_id INT NOT NULL,
  course_id INT NOT NULL,
  quantity INT,
  purchase_date DATE,
  FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
  );
  
  INSERT INTO learners (learner_id, full_name, country) VALUES
(1, 'Aarav Sharma', 'India'),
(2, 'Noah Williams', 'USA'),
(3, 'Fatima Al-Zahrani', 'Saudi Arabia'),
(4, 'Liam Brown', 'UK'),
(5, 'Meera Nair', 'Qatar');

INSERT INTO courses (course_id, course_name, category, unit_price) VALUES
(101, 'Introduction to Python', 'Programming', 1049.9976),
(102, 'Data Analytics Fundamentals', 'Data Science', 2059.7569),
(103, 'Digital Marketing Basics', 'Marketing', 3339.989),
(104, 'UI/UX Design Essentials', 'Design', 2845.00),
(105, 'Cloud Computing Foundations', 'IT', 3455.5065);
SELECT * FROM courses;


INSERT INTO purchases (purchase_id, learner_id, course_id, quantity, purchase_date) VALUES
(201, 1, 101, 33, '2025-01-10'),
(202, 2, 102, 24, '2025-01-12'),
(203, 3, 105, 12, '2025-01-15'),
(204, 1, 103, 14, '2025-01-18'),
(205, 4, 104, 31, '2025-01-20'),
(206, 5, 101, 25, '2025-01-22'),
(207, 2, 105, 21, '2025-01-25'),
(208, 3, 102, 11, '2025-01-28');


SELECT c.course_name,
ROUND(c.unit_price * p.quantity, 2) AS total_revenue 
FROM courses c
JOIN purchases p ON c.course_id = p.course_id
ORDER BY total_revenue DESC;

SELECT 
l.learner_id , l.full_name , l.country , c.course_id , c.course_name , c.category , c.unit_price ,
p.purchase_id , p.quantity , p.purchase_date 
FROM purchases p 
INNER JOIN learners l ON p.learner_id = l.learner_id
INNER JOIN courses c ON p.course_id = c.course_id;

SELECT l.full_name , l.country , c.course_name , c.category , p.quantity , p.purchase_date,
ROUND(c.unit_price * p.quantity , 2) AS total_revenue
FROM purchases p
LEFT JOIN courses c ON p.course_id = c.course_id
RIGHT JOIN learners l ON p.learner_id = l.learner_id
ORDER BY total_revenue DESC;

SELECT c.category ,c.course_name , 
SUM(p.quantity) AS Total_quantity_sold
FROM courses c
JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.category , c.course_name 
ORDER BY Total_quantity_sold DESC
LIMIT 3;

SELECT c.category ,c.course_name ,
ROUND(SUM(c.unit_price * p.quantity) , 2) AS total_revenue ,
COUNT(DISTINCT p.learner_id)  AS unique_learners
FROM courses c 
LEFT JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.category , c.course_name
ORDER BY total_revenue DESC;

SELECT l.learner_id ,l.full_name , l.country ,
COUNT(DISTINCT c.category)  AS distinct_learners 
FROM learners l
INNER JOIN purchases p ON l.learner_id = p.learner_id
INNER JOIN courses c ON p.course_id = c.course_id
GROUP BY l.learner_id , l.full_name ,l.country 
HAVING COUNT(DISTINCT c.category) > 1
ORDER BY distinct_learners DESC, l.full_name;

SELECT c.course_id, c.course_name, c.category,
ROUND(c.unit_price,2) AS unit_price
FROM courses c
LEFT JOIN purchases p ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL;













  