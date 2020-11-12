


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "Salary" INTEGER   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" Date   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" Date   NOT NULL
);

ALTER TABLE "departments" ADD CONSTRAINT "fk_departments_dept_no" FOREIGN KEY("dept_no")
REFERENCES "dept_manager" ("dept_no");

ALTER TABLE "departments" ADD CONSTRAINT "fk_departments_dept_name" FOREIGN KEY("dept_name")
REFERENCES "Dept_emp" ("dept_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_title_id" FOREIGN KEY("title_id")
REFERENCES "employees" ("emp_title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no_emp_no" FOREIGN KEY("dept_no", "emp_no")
REFERENCES "Dept_emp" ("dept_no", "emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Dept_emp" ("emp_no");

--Question 1
--List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT salaries.*, employees.last_name, employees.first_name, employees.sex
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

--Question 2
--List first name, last name, and hire date for employees who were hired in 1986.

SELECT last_name, first_name, hire_date
FROM employees
WHERE hire_date >= '1986-1-1' AND hire_date <= '1986-12-31'

--Question 3
--List the manager of each department with the following information: department number, department name, the managers employee number, last name, first name.

SELECT departments.*, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments
ON dept_manager.dept_no = departments.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no

--Question 4
--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = Dept_emp.emp_no
JOIN departments
ON Dept_emp.dept_no = departments.dept_no

--Question 5
--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT  first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'R%'

--Question 6
--List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = Dept_emp.emp_no
JOIN departments
ON Dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales'


--Question 7
--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = Dept_emp.emp_no
JOIN departments
ON Dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'


--Question 8
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY employees.count DESC
