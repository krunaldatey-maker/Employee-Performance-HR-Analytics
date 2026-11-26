CREATE DATABASE hr_analytics;

USE hr_analytics;

SELECT COUNT(*) FROM hr_data;

SELECT * FROM hr_data LIMIT 5;

DESCRIBE hr_data;


-- Query-1
SELECT
    Department,
    COUNT(*) AS Total_Employees
FROM hr_data
GROUP BY Department
ORDER BY Total_Employees DESC;


-- Query-2
SELECT
    Department,
    ROUND(AVG(Salary), 2) AS Average_Salary
FROM hr_data
GROUP BY Department
ORDER BY Average_Salary DESC;


-- Query-3
SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Designation,
    Salary
FROM hr_data
ORDER BY Salary DESC
LIMIT 10;


-- Query-4
SELECT
    Department,
    ROUND(AVG(Experience_Years), 2) AS Average_Experience
FROM hr_data
GROUP BY Department
ORDER BY Average_Experience DESC;


-- Query-5
SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Designation,
    Performance_Rating
FROM hr_data
WHERE Performance_Rating = (
    SELECT MAX(Performance_Rating)
    FROM hr_data
)
ORDER BY Department;


-- Query-6
SELECT
    Work_Mode,
    COUNT(*) AS Total_Employees
FROM hr_data
GROUP BY Work_Mode
ORDER BY Total_Employees DESC;


-- Query-7
SELECT
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS Attrition_Rate
FROM hr_data
GROUP BY Department
ORDER BY Attrition_Rate DESC;


-- Query-8
SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Salary,
    RANK() OVER (
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS Salary_Rank
FROM hr_data
ORDER BY Department, Salary_Rank;


-- Query-9
SELECT
    Employee_ID,
    Employee_Name,
    Department,
    Salary
FROM hr_data
WHERE Salary > (
    SELECT AVG(Salary)
    FROM hr_data
)
ORDER BY Salary DESC;



-- Query-10
SELECT
    Gender,
    COUNT(*) AS Total_Employees,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_data), 2
    ) AS Percentage
FROM hr_data
GROUP BY Gender
ORDER BY Total_Employees DESC;