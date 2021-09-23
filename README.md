# Pewlett Hackard Employee Database

Pewlett Hackard is a large company with thousands of employees that is in the middle of a rapid rate wave of retirements. To prepare for the future, the company begin a data researching for answering two main questions:

 1. Who is going to retire
 2. How many positions will need to be filled.

The initial data is distributed in six `csv` tables: *departments, dept_emp, dept_manager, employees, salaries, titles*. Based on the tables information, a **SQL (Structured Query Language)** database is created and generate the tables that summarize the answers to the main questions of interest.

## Overview

With the SQL database created and the tables generated for answering the main questions, the manager of the department of **Sales** wants to pitch a Mentorship program within the company, where many of the potential retiring employees continue working but as part time employees. This program could reduce the retirment burden of the company while prepare another employees to fill in the gaps that retiring employees might leave.  

To give more support to the Mentorship Program, we need to find the answers to the following:

 1. Number of retiring employees per title
 2. How many of those employees are eligible to participate in the mentorship program.

## Results

The initial data analysis is performed only for the departments of: **Sales** and **Development** since the two departments are in some way under the same supervision. Before starting with our analysis we need to have in mind the three conditions for retirement. These are: 

- Employess that were born between January 1, 1952 and December 31, 1955.

- Employees that were hired between January 1, 1982 and December 31, 1985.

- Employees that are still working on Pewlett Hackard.

### Retiring Employees per Title

We previously had created a table summarizing all employees that are about to retire with information about the employee number and the first, last name. In addition to this information we need the title, the start and end dates of employment, which are in the *title* table.  With the join information from these two tables and using the `DISTINCT ON` statement we select the most recent title for each employee and save them into a file called *unique_titles.csv*.

![unique](https://raw.githubusercontent.com/LeidyDoradoM/PewlettHackard_Challenge/main/unique_titles.png)
Figure 1. First rows of Unique titles Table

Besides the information shown previously, we are also interested in finding the number of retirees by title. Figure 2 shows the table that is created by grouping the table presented in Figure 1 by titles.

![rtitles](https://raw.githubusercontent.com/LeidyDoradoM/PewlettHackard_Challenge/main/retiring_titles.png)
Figure 2. Number of retirees per title

### Mentorship Eligibility

To answer the second question, we consider that current employees who were born between January 1, 1965 and December 31, 1965 are eligible to the mentorship program. The table that holds those employees is shown below.

![mentors](https://raw.githubusercontent.com/LeidyDoradoM/PewlettHackard_Challenge/main/mentorship.png)
Figure 3. Mentorship-Eligibility

To create this table, we needed the personal information for each employee which is in the employee table, and the start/end dates of employment at Pewlett Hackard, that is in the department-employee table. From there, we filtered out the current employees (i.e., `to_date` = `9999-01-01`) data based on the dates of birth, which correspond to any day within the year 1965.

## Summary