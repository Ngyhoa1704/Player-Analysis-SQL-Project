# ⚾ Maven Advanced SQL Project – Baseball Data Analysis

## 📌 Project Overview
This SQL project explores a baseball analytics dataset (`maven_advanced_sql`) to analyze player development, team spending behavior, career trajectories, and comparative player characteristics. The project is structured into four key parts and uses advanced SQL techniques to extract performance insights from historical player data.

---

## 🗃 Database Tables Used
- `schools`: Historical record of players and schools
- `school_details`: Full names and info for each school
- `players`: Biographical and career data for each player
- `salaries`: Yearly salary information by player and team


---

## 📖 Project Structure

### 🧠 PART I: School Analysis
**Goal:** Analyze school contributions to professional baseball.
- Count of **unique schools per decade** that produced players
- Identify the **top 5 all-time schools** by number of players
- Use `ROW_NUMBER()` to find the **top 3 schools per decade**
- Join `schools` with `school_details` for full names

### 💰 PART II: Salary Analysis
**Goal:** Examine team salary trends and cumulative spend.
- Identify **top 20% of teams** by average annual salary using `NTILE()`
- Compute **cumulative spending** by team over time using `SUM() OVER()`
- Determine the **first year** each team surpassed **$1 billion in total payroll**
- Use CTEs and window functions to layer calculations

### 👥 PART III: Player Career Analysis
**Goal:** Track player longevity and team affiliations.
- Calculate each player’s:
  - **Starting Age**
  - **Ending Age**
  - **Career Length**
- Identify the **starting and ending teams** for each player
- Highlight players who:
  - **Started and ended on the same team**
  - Played **over a decade**

### ⚖️ PART IV: Player Comparison Analysis
**Goal:** Compare player attributes and traits.
- Group players who **share the same birthday** (1980–1990)
- Summarize **batting style distribution (Right, Left, Both)** by team
- Analyze **changes in height and weight at debut** by decade using `LAG()`

---

## 🛠 SQL Concepts Used
- **Aggregation**: `COUNT()`, `AVG()`, `SUM()`
- **Date functions**: `YEAR()`, `FLOOR()`, `CONCAT()`, `TIMESTAMPDIFF()`
- **Conditional logic**: `CASE WHEN`, `GROUP_CONCAT`
- **Window functions**: `ROW_NUMBER()`, `NTILE()`, `LAG()`
- **Common Table Expressions (CTEs)**
- **Joins**: `JOIN`, `LEFT JOIN`

---

## 📚 What This Project Demonstrates
- Intermediate to advanced SQL capabilities across multiple analytical themes
- Strong use of CTEs and window functions to support layered insights
- Clear structure suitable for integration into BI tools or Excel dashboards
- Practical exploration of real-world baseball data including salaries, schools, and player careers

