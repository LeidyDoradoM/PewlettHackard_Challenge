-- Deliverable 1 --

-- Create retirement + titles Table
SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date INTO retirement_titles
	FROM employees as e 
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Remove multiply employees entries and create a table 
-- of unique employees w/ most recent title about to retire 
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Create employee table by their most recent job title about to retire
SELECT count(ut.title),ut.title 
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY count DESC;

-- Deliverable 2 --

--Mentorship table
SELECT DISTINCT ON(emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (de.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;