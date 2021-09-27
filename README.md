# Pewlett Hackard Employee Database

Pewlett Hackard is a large company with thousands of employees that is in the middle of a rapid wave of retirements. To prepare for the future, the company begin a data researching for answering two main questions:

 1. Who is going to retire
 2. How many positions will need to be filled.

The initial data is distributed in six `csv` tables: *departments, dept_emp, dept_manager, employees, salaries, titles*. Based on the tables information, a **SQL (Structured Query Language)** database is created and tables that summarize the answers to the main questions of interest are generated.

## Overview

With the SQL database created and the tables generated for answering the main questions, the manager of the department of **Sales** wants to pitch a Mentorship program within the company, where many of the potential retiring employees continue working but as part time employees. This program could reduce the retirment burden of the company while prepare another employees to fill in the gaps that retiring employees might leave.  

To give more support to the Mentorship Program, we need to find the answers to the following:

 1. Number of retiring employees per title
 2. How many of those employees are eligible to participate in the mentorship program.

## Results

For our analysis, we are going to consider only one condition for defining retirement:  employees that were born between `January 1, 1952` and `December 31, 1955`.
Other data analysis (performed before on this data) considered also the hiring date as an additional condition for retirement.

### 1. Retiring Employees per Title

To check the title of each employee about to retire, we need to join two tables: employee and titles.  From employee table we retrieve three columns: `employee number`, `first name` and `last name`. From titles table we need to retrieve: `title`. In addition to these columns, we need to filter out the data based on the birth date so we can include only employees that are in the age of retirement.

![retiring](https://raw.githubusercontent.com/LeidyDoradoM/PewlettHackard_Challenge/main/retirement_titles.png)
Figure 1. Overview of the first rows of Retiring Employee Table

The total of rows in this table is 113,776.  But there are duplicates since some employees have had multiple roles during their time at Pewlett Hackard.  

### 2. Unique Retiring Employees per Title

Because in the previous table there are multiple titles for the same employee, we need to keep only the most recent title for each employee.  This is accomplished by using the `DISTINCT ON` statement and ordering the table in descendent order by the last date (i.e. `to_date`) of the most recent title. Below there is an overview of the table that has 90,398 rows. Then we save them into a file called *unique_titles.csv*.

![unique](https://raw.githubusercontent.com/LeidyDoradoM/PewlettHackard_Challenge/main/unique_titles.png)
Figure 2. First rows of Unique titles Table

### 3. Number of Retiring Employees per Title

Besides the information shown previously, we are also interested in finding the number of retirees by title. We use `GROUP BY` statement and sorting the rows in descending order. Figure 3 shows the table that has been saved as *retiring_titles.csv*

![rtitles](https://raw.githubusercontent.com/LeidyDoradoM/PewlettHackard_Challenge/main/retiring_titles.png)
Figure 3. Number of retirees per title

According with this table, there are 57,668 Senior employees (63.8%), which means most of the half of the retiring employees have time in their current work-role and conssequently plenty of experience/knowledge in their daily work.

### 4. Mentorship Eligibility

To answer the second question, we consider that current employees who were born between January 1, 1965 and December 31, 1965 are eligible to the mentorship program.   We join two tables: *employees* and *dept_emp* and keep only the personal information for each employee and the start and end dates of employment. Then, we filter out employees that are not currently working in Pewlett Hackard, this is the current employees (i.e., `to_date` = `9999-01-01`) data based on the dates of birth, which correspond to any day within the year 1965. An overview of the first rows is shown below.

![mentors](https://raw.githubusercontent.com/LeidyDoradoM/PewlettHackard_Challenge/main/mentorship.png)
Figure 4. Mentorship-Eligibility

## Summary

- According with the findings presented here, there are 90,398 employees that are about to retire out of 300,024; which corresponds approximately to the 30%. This is a high percentage of vacant positions that Pewlett Hackard will need to fill. We can have a more detail overview of the situation, if we break down the total of employees by title and compare those numbers.  

Fisrt we need to create a unique titles table but for the entire universe of employees at Pewlett Hackard  and then create the table for titles. Below there are the two queries and the resulting table that shows the list of employees at Pewlett Hackard by titles:

```sql
--create an intermediate table that keep information of unique titles
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date INTO all_unique_titles
	FROM employees as e 
INNER JOIN titles as t
ON e.emp_no = t.emp_no
ORDER BY e.emp_no;
```

```sql
--counting of employees by title
SELECT count(aut.title),aut.title 
FROM all_unique_titles AS aut
GROUP BY aut.title
ORDER BY count DESC;
```

![allemp](https://raw.githubusercontent.com/LeidyDoradoM/PewlettHackard_Challenge/main/all_employees_titles.png)

Comparing the numbers between this table and the one in Figure 3, we found that almost the 50% of senior employees are about to retire, approximately the 13% of engineers, the 29% of the staff, and the 20% of the technical roles.

- Regarding the mentorship program, there are 1,549 employees that could participate. This is roughly 1.7% of the retiring employees, which is really a low amount of people that could help in reducing the burden of retirement.  Furthermore if we consider that qualified employees are those with plenty of experience such as *Senior Engineer* and *Senior Staff*, the amount of candidates that could mentor the next generation of employees is reduced even more.  This total number of Senior employees could be find if we filter the mentorship-eligibility table by `title` and count its rows.  Below it is the query that gives as result 709 employees.

```sql
SELECT COUNT(*) 
FROM mentorship_eligibility
WHERE (title IN ('Senior Engineer','Senior Staff'));
```

Pewlett Hackard will have a huge burden of vacant positions to fill in in the next years, and given the low amount of people eligible to mentor, the company will face a great deficit. The best they can do is try to mitigate the situation and learn from it so in the future retirement waves do not have this same impact.
