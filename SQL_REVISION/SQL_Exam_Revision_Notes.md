# SQL EXAM REVISION NOTES
### Fast revision • Understand the pattern • Then solve the query

> **Core idea:** SQL questions usually ask you to **select, filter, group, join, sort, limit, or compare**.

---

# 0. DATABASE SETUP

Use one small database throughout revision.

```sql
CREATE DATABASE sql_learning;
USE sql_learning;

CREATE TABLE Employees (
    id INT,
    name VARCHAR(50),
    role VARCHAR(50),
    salary INT,
    department VARCHAR(50),
    building VARCHAR(50)
);

CREATE TABLE Buildings (
    building_name VARCHAR(50),
    capacity INT
);

INSERT INTO Employees VALUES
(1, 'Arun', 'Developer', 50000, 'IT', 'A'),
(2, 'Bala', 'Tester', 40000, 'Testing', 'B'),
(3, 'Charan', 'Developer', 60000, 'IT', 'A'),
(4, 'Divya', 'HR', 45000, 'HR', NULL),
(5, 'Esha', 'Developer', 70000, 'IT', 'C'),
(6, 'Fahad', 'Tester', 42000, 'Testing', 'B');

INSERT INTO Buildings VALUES
('A', 100),
('B', 200),
('C', 150),
('D', 300);
```

---

# 1. BASIC SQL

## SELECT + FROM

| Keyword | Remember |
|---|---|
| `SELECT` | **What columns?** |
| `FROM` | **Which table?** |

```sql
SELECT name, role
FROM Employees;
```

`*` = all columns.

```sql
SELECT *
FROM Employees;
```

---

# 2. WHERE — FILTER ROWS

**WHERE = filter individual rows before grouping.**

```sql
SELECT *
FROM Employees
WHERE salary > 50000;
```

### Comparison operators

| Operator | Meaning |
|---|---|
| `=` | equal |
| `>` | greater than |
| `<` | less than |
| `>=` | greater than / equal |
| `<=` | less than / equal |
| `<>` | not equal |

### ⭐ Remember

> **WHERE → ROWS**

---

# 3. FILTERING OPERATORS

## AND / OR / NOT

| Operator | Meaning |
|---|---|
| `AND` | **both** conditions true |
| `OR` | **at least one** true |
| `NOT` | reverses condition |

```sql
SELECT *
FROM Employees
WHERE department = 'IT'
AND salary > 50000;
```

```sql
SELECT *
FROM Employees
WHERE department = 'IT'
OR department = 'HR';
```

```sql
SELECT *
FROM Employees
WHERE NOT department = 'IT';
```

---

## BETWEEN

Checks a range **including both boundaries**.

```sql
SELECT *
FROM Employees
WHERE salary BETWEEN 40000 AND 60000;
```

Think:

```text
salary >= 40000
AND
salary <= 60000
```

---

## IN

Checks multiple possible values.

Instead of:

```sql
WHERE department = 'IT'
   OR department = 'HR'
   OR department = 'Testing'
```

Use:

```sql
WHERE department IN ('IT', 'HR', 'Testing');
```

> **IN → one column, many allowed values**

---

## LIKE

Pattern matching.

| Pattern | Meaning |
|---|---|
| `'A%'` | starts with A |
| `'%a'` | ends with a |
| `'%ar%'` | contains `ar` |
| `'_run'` | exactly one character before `run` |

```sql
SELECT *
FROM Employees
WHERE name LIKE 'A%';
```

### ⭐ Remember

- `%` → **any number of characters**
- `_` → **exactly one character**

---

# 4. DISTINCT

Removes duplicate **combinations** from the selected columns.

```sql
SELECT DISTINCT role
FROM Employees;
```

With multiple columns:

```sql
SELECT DISTINCT role, department
FROM Employees;
```

SQL checks:

```text
role + department
```

> **DISTINCT → unique result combinations**

---

# 5. ORDER BY — SORT

```sql
SELECT *
FROM Employees
ORDER BY salary ASC;
```

| Keyword | Meaning |
|---|---|
| `ASC` | small → large |
| `DESC` | large → small |

```sql
ORDER BY salary DESC;
```

`ASC` is normally the default.

---

# 6. LIMIT + OFFSET

## LIMIT

Controls how many rows are returned.

```sql
SELECT *
FROM Employees
LIMIT 3;
```

## OFFSET

Skips rows first.

```sql
SELECT *
FROM Employees
LIMIT 3 OFFSET 2;
```

Think:

```text
OFFSET → skip
LIMIT  → take
```

### ⭐ Common pattern

```sql
SELECT *
FROM Employees
ORDER BY salary DESC
LIMIT 2 OFFSET 1;
```

Meaning:

1. Sort highest → lowest
2. Skip the highest
3. Take the next 2

---

# 7. ALIAS — AS

Temporarily renames a column or table.

```sql
SELECT name AS employee_name,
       salary AS employee_salary
FROM Employees;
```

Table alias:

```sql
SELECT e.name, e.salary
FROM Employees AS e;
```

---

# 8. NULL

`NULL` = missing / unknown value.

❌ Wrong:

```sql
WHERE building = NULL
```

✅ Correct:

```sql
WHERE building IS NULL;
```

```sql
WHERE building IS NOT NULL;
```

### ⭐ Must remember

| Wrong | Correct |
|---|---|
| `= NULL` ❌ | `IS NULL` ✅ |
| `<> NULL` ❌ | `IS NOT NULL` ✅ |

---

# 9. AGGREGATE FUNCTIONS ⭐⭐⭐

Aggregate functions calculate a value from **multiple rows**.

| Function | Meaning | Memory word |
|---|---|---|
| `COUNT()` | number of rows/values | Count |
| `SUM()` | total | Add |
| `AVG()` | average | Mean |
| `MAX()` | largest | Highest |
| `MIN()` | smallest | Lowest |

### Basic examples

```sql
SELECT COUNT(*)
FROM Employees;
```

```sql
SELECT SUM(salary)
FROM Employees;
```

```sql
SELECT AVG(salary)
FROM Employees;
```

```sql
SELECT MAX(salary)
FROM Employees;
```

```sql
SELECT MIN(salary)
FROM Employees;
```

## COUNT(*) vs COUNT(column)

```sql
COUNT(*)
```
→ counts rows.

```sql
COUNT(building)
```
→ counts non-NULL values in `building`.

> **COUNT(column) ignores NULL.**

---

# 10. GROUP BY ⭐⭐⭐

`GROUP BY` puts rows having the same value into groups.

```sql
SELECT department, COUNT(*)
FROM Employees
GROUP BY department;
```

Concept:

```text
IT       → 3 employees
Testing  → 2 employees
HR       → 1 employee
```

### Think:

> **GROUP BY = make groups**

Then an aggregate can calculate **inside each group**.

```sql
SELECT department, SUM(salary)
FROM Employees
GROUP BY department;
```

```sql
SELECT department, AVG(salary)
FROM Employees
GROUP BY department;
```

```sql
SELECT department, MAX(salary)
FROM Employees
GROUP BY department;
```

---

# 11. HAVING ⭐⭐⭐

## The important correction to your idea

Your thought was roughly:

> “HAVING is used with aggregate functions where we filter only one column/row.”

### Correct version:

> **HAVING filters GROUPS after `GROUP BY`.**

It is commonly used with **aggregate conditions**, such as:

```sql
HAVING COUNT(*) > 1
```

or

```sql
HAVING AVG(salary) > 50000
```

But **HAVING is not simply “filter one column/row.”**

It filters the **resulting groups**.

### Example

```sql
SELECT department, COUNT(*)
FROM Employees
GROUP BY department
HAVING COUNT(*) > 1;
```

Read it as:

```text
1. GROUP BY department
       ↓
2. Make one group for each department
       ↓
3. COUNT employees in each group
       ↓
4. Keep only groups where count > 1
```

Result:

```text
IT       → 3
Testing  → 2
```

HR is removed because its count is 1.

### ⭐ WHERE vs HAVING

| WHERE | HAVING |
|---|---|
| Filters **rows** | Filters **groups** |
| Before `GROUP BY` | After `GROUP BY` |
| Usually row condition | Often aggregate condition |
| `salary > 50000` | `COUNT(*) > 1` |

### 🔥 One-line memory

```text
WHERE  → Which ROWS should enter the groups?
HAVING → Which GROUPS should remain?
```

### Important nuance

HAVING is **often used with aggregates**, but it is **not mandatory that HAVING contain an aggregate function**. The key concept is that it filters groups after grouping.

---

# 12. WHERE + GROUP BY + HAVING

This pattern is extremely important.

```sql
SELECT department, AVG(salary)
FROM Employees
WHERE salary >= 40000
GROUP BY department
HAVING AVG(salary) > 50000;
```

Read:

```text
FROM       → Employees
WHERE      → remove unwanted ROWS
GROUP BY   → create department GROUPS
HAVING     → remove unwanted GROUPS
SELECT     → display result
```

---

# 13. SQL EXECUTION ORDER ⭐⭐⭐

For exam questions, remember:

```text
FROM
  ↓
WHERE
  ↓
GROUP BY
  ↓
HAVING
  ↓
SELECT
  ↓
ORDER BY
  ↓
LIMIT / OFFSET
```

### Memory

```text
WHERE  = rows
HAVING = groups
```

---

# 14. JOINS ⭐⭐⭐

We have:

### Employees

| id | name | building |
|---:|---|---|
| 1 | Arun | A |
| 2 | Bala | B |
| 3 | Charan | A |
| 4 | Divya | NULL |
| 5 | Esha | C |
| 6 | Fahad | B |

### Buildings

| building_name | capacity |
|---|---:|
| A | 100 |
| B | 200 |
| C | 150 |
| D | 300 |

Common columns:

```text
Employees.building
        =
Buildings.building_name
```

---

# 15. INNER JOIN

Returns **only matching rows** from both tables.

```sql
SELECT e.name, b.capacity
FROM Employees e
INNER JOIN Buildings b
ON e.building = b.building_name;
```

Think:

```text
Table 1
   ↓
MATCH
   ↓
Table 2
```

Unmatched rows are removed.

So:

- Divya → no building → excluded
- Building D → no employee → excluded

---

# 16. LEFT JOIN ⭐⭐⭐

**Keeps every row from the LEFT table.**

```sql
SELECT e.name, b.capacity
FROM Employees e
LEFT JOIN Buildings b
ON e.building = b.building_name;
```

Here:

```text
LEFT  = Employees
RIGHT = Buildings
```

So:

> **Keep all Employees.**

If no matching building exists:

```text
capacity = NULL
```

### ⭐ Memory

```text
LEFT JOIN
→ keep everything from table after FROM
```

---

# 17. RIGHT JOIN

**Keeps every row from the RIGHT table.**

```sql
SELECT e.name, b.capacity
FROM Employees e
RIGHT JOIN Buildings b
ON e.building = b.building_name;
```

Here:

```text
LEFT  = Employees
RIGHT = Buildings
```

So:

> **Keep all Buildings.**

Building D appears even though nobody is assigned to it.

### JOIN comparison

| JOIN | What is kept? |
|---|---|
| `INNER JOIN` | only matches |
| `LEFT JOIN` | all left + matches |
| `RIGHT JOIN` | all right + matches |

---

# 18. FIND UNMATCHED ROWS ⭐⭐⭐

## Employees without a building

```sql
SELECT e.name
FROM Employees e
LEFT JOIN Buildings b
ON e.building = b.building_name
WHERE b.building_name IS NULL;
```

Logic:

```text
LEFT JOIN
   ↓
keep all Employees
   ↓
unmatched Building becomes NULL
   ↓
WHERE b.building_name IS NULL
```

## Buildings with no employees

```sql
SELECT b.building_name
FROM Buildings b
LEFT JOIN Employees e
ON b.building_name = e.building
WHERE e.id IS NULL;
```

### 🔥 Pattern to remember

```sql
FROM A
LEFT JOIN B
ON ...
WHERE B.some_column IS NULL;
```

→ Find rows in **A that have no match in B**.

---

# 19. JOIN + WHERE

`ON` tells SQL **how tables match**.

`WHERE` filters the resulting rows.

```sql
SELECT e.name, b.capacity
FROM Employees e
INNER JOIN Buildings b
ON e.building = b.building_name
WHERE b.capacity > 150;
```

### ⭐ Remember

```text
ON    → how to MATCH
WHERE → which ROWS to keep
```

---

# 20. MULTIPLE JOINS

You can join more than two tables.

```sql
SELECT t1.column, t2.column, t3.column
FROM table1 t1
JOIN table2 t2
ON t1.common_column = t2.common_column
JOIN table3 t3
ON t2.common_column = t3.common_column;
```

---

# 21. SUBQUERY ⭐⭐

A **query inside another query**.

## Salary greater than average

```sql
SELECT name, salary
FROM Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
);
```

Think:

```text
Subquery
   ↓
calculate average
   ↓
Outer query
   ↓
compare each salary
```

---

## Highest salary

```sql
SELECT name, salary
FROM Employees
WHERE salary = (
    SELECT MAX(salary)
    FROM Employees
);
```

## Lowest salary

```sql
SELECT name, salary
FROM Employees
WHERE salary = (
    SELECT MIN(salary)
    FROM Employees
);
```

---

# 22. IN + SUBQUERY

Inner query produces multiple values.

```sql
SELECT name
FROM Employees
WHERE department IN (
    SELECT department
    FROM Employees
    WHERE salary > 60000
);
```

Think:

```text
INNER QUERY
→ produces a set of departments

OUTER QUERY
→ checks whether department is IN that set
```

---

# 23. EXISTS

Checks whether the subquery returns **at least one matching row**.

```sql
SELECT e.name
FROM Employees e
WHERE EXISTS (
    SELECT 1
    FROM Buildings b
    WHERE e.building = b.building_name
);
```

Meaning:

> Return the employee if a matching building **exists**.

### Memory

```text
EXISTS → Does a matching row exist?
```

---

# 24. CASE

SQL's `if / else` style logic.

```sql
SELECT name,
       salary,
       CASE
           WHEN salary >= 60000 THEN 'High'
           WHEN salary >= 45000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_level
FROM Employees;
```

Think:

```text
IF condition → result
ELSE IF      → result
ELSE         → result
```

---

# 25. COALESCE

Replaces `NULL` with another value.

```sql
SELECT name,
       COALESCE(building, 'Not Assigned') AS building
FROM Employees;
```

If:

```text
building = NULL
```

output becomes:

```text
Not Assigned
```

---

# 26. MOST IMPORTANT DIFFERENCES ⭐⭐⭐

## WHERE vs HAVING

| | WHERE | HAVING |
|---|---|---|
| Filters | Rows | Groups |
| Stage | Before grouping | After grouping |
| Typical condition | `salary > 50000` | `COUNT(*) > 1` |
| Used with `GROUP BY`? | Can be | Yes, when filtering groups |

```text
WHERE  → ROW
HAVING → GROUP
```

---

## WHERE vs ON

| | WHERE | ON |
|---|---|---|
| Main job | Filter result rows | Define JOIN matching |
| Example | `WHERE salary > 50000` | `ON e.building = b.building_name` |

```text
ON    → MATCH
WHERE → FILTER
```

---

## GROUP BY vs ORDER BY

| | GROUP BY | ORDER BY |
|---|---|---|
| Purpose | Create groups | Sort result |
| Example | `GROUP BY department` | `ORDER BY salary DESC` |

```text
GROUP BY → GROUP
ORDER BY → SORT
```

---

## COUNT(*) vs COUNT(column)

| | Meaning |
|---|---|
| `COUNT(*)` | counts rows |
| `COUNT(column)` | counts non-NULL values |

---

## INNER vs LEFT vs RIGHT

```text
INNER → matching only
LEFT  → keep left
RIGHT → keep right
```

---

# 27. QUICK PLACEMENT CHEAT SHEET

| Concept | Exam meaning |
|---|---|
| `SELECT` | choose columns |
| `FROM` | choose table |
| `WHERE` | filter rows |
| `DISTINCT` | remove duplicate combinations |
| `ORDER BY` | sort |
| `LIMIT` | take rows |
| `OFFSET` | skip rows |
| `AND` | both |
| `OR` | either |
| `NOT` | reverse |
| `BETWEEN` | inclusive range |
| `IN` | one column, multiple allowed values |
| `LIKE` | pattern |
| `IS NULL` | missing value |
| `COUNT` | count |
| `SUM` | total |
| `AVG` | average |
| `MIN` | smallest |
| `MAX` | largest |
| `GROUP BY` | create groups |
| `HAVING` | filter groups |
| `ON` | join condition |
| `INNER JOIN` | matching rows |
| `LEFT JOIN` | keep left |
| `RIGHT JOIN` | keep right |
| Subquery | query inside query |
| `EXISTS` | matching row exists? |
| `CASE` | if/else |
| `COALESCE` | replace NULL |

---

# 28. QUERY PATTERNS TO RECOGNIZE

## Basic

```sql
SELECT columns
FROM table
WHERE condition
ORDER BY column DESC
LIMIT 5;
```

## Filtering

```sql
SELECT *
FROM table
WHERE column IN ('A', 'B')
AND value BETWEEN 10 AND 20;
```

## Count by category

```sql
SELECT column, COUNT(*)
FROM table
GROUP BY column;
```

## Filter groups

```sql
SELECT column, COUNT(*)
FROM table
GROUP BY column
HAVING COUNT(*) > 1;
```

## JOIN

```sql
SELECT t1.column, t2.column
FROM table1 t1
JOIN table2 t2
ON t1.common_column = t2.common_column;
```

## Unmatched rows

```sql
SELECT t1.column
FROM table1 t1
LEFT JOIN table2 t2
ON t1.common_column = t2.common_column
WHERE t2.common_column IS NULL;
```

## Compare with aggregate

```sql
SELECT *
FROM table
WHERE value > (
    SELECT AVG(value)
    FROM table
);
```

---

# 29. ⭐ FINAL 30-SECOND REVISION

If you have only 30 seconds before the exam, remember this:

```text
SELECT  → what?
FROM    → where from?

WHERE   → filter ROWS
GROUP BY → make GROUPS
HAVING  → filter GROUPS

ON      → JOIN condition
JOIN    → combine tables

ORDER BY → SORT
LIMIT    → TAKE
OFFSET   → SKIP

COUNT / SUM / AVG / MIN / MAX
→ AGGREGATE FUNCTIONS

INNER → matches only
LEFT  → keep left
RIGHT → keep right

NULL → IS NULL / IS NOT NULL

SUBQUERY → query inside query
EXISTS   → does a match exist?
CASE     → if/else
COALESCE → replace NULL
```

## 🔥 The most important mental model

```text
FROM
 ↓
get the table
 ↓
WHERE
 ↓
filter ROWS
 ↓
GROUP BY
 ↓
make GROUPS
 ↓
HAVING
 ↓
filter GROUPS
 ↓
SELECT
 ↓
choose what to display
 ↓
ORDER BY
 ↓
sort
 ↓
LIMIT / OFFSET
 ↓
take / skip result rows
```

> **Don't memorize 50 queries. Recognize the operation the question is asking for.**
