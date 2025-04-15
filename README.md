# ⚾️ Player Analysis SQL Project

## 📌 Project Overview
This SQL project explores a professional baseball dataset from the `maven_advanced_sql` database. The analysis is divided into four thematic parts that cover player origins, team salaries, career spans, and comparative characteristics. The project highlights the use of advanced SQL techniques including Common Table Expressions (CTEs), window functions, aggregation, and conditional logic to derive insights from a relational database.

---

## 🗂️ Database Schema
**Database**: `maven_advanced_sql`  
**Key Tables**: `players`, `schools`, `school_details`, `salaries`

---

## 🧠 PART I: School Analysis
This section investigates the role of educational institutions in producing professional players:
- Counted how many schools produced players per **decade**
- Identified the **top 5 schools** that produced the most players
- Ranked the **top 3 schools per decade** using `ROW_NUMBER()`
- Joined `schools` with `school_details` to enrich results with full school names

🔧 **Techniques Used**:  
`JOIN`, `GROUP BY`, `COUNT(DISTINCT)`, `FLOOR()`, CTEs, `ROW_NUMBER()`

---

## 💰 PART II: Salary Analysis
Analyzes financial spending patterns of teams over time:
- Identified the **top 20% of teams** by average annual salary using `NTILE()`
- Computed **cumulative spending** of each team across years
- Determined the **first year** each team’s spending exceeded **$1 billion**

🔧 **Techniques Used**:  
`SUM()`, `AVG()`, window functions (`NTILE()`, `SUM() OVER`), multi-level CTEs

---

## 👤 PART III: Player Career Analysis
Evaluates the longevity of player careers:
- Calculated each player’s:
  - **Age at first game**
  - **Age at last game**
  - **Career length in years**
- Sorted and compared career spans across the entire dataset

🔧 **Techniques Used**:  
Date calculations using `YEAR()`, `TIMESTAMPDIFF()`, `ORDER BY`, derived columns

---

## ⚔️ PART IV: Player Comparison Analysis
Compares players across shared traits and physical attributes:
1. **Shared Birthdays (1980–1990)**  
   - Reconstructed birthdates and used `GROUP_CONCAT()` to list players sharing the same day.

2. **Batting Handedness by Team**  
   - Determined the percentage of right-handed, left-handed, and switch hitters per team using conditional aggregation.

3. **Debut Year Trends in Height & Weight**  
   - Calculated average height and weight by decade of debut.
   - Used `LAG()` to determine decade-over-decade physical attribute changes.

🔧 **Techniques Used**:  
`GROUP_CONCAT()`, conditional `CASE WHEN`, time grouping with `FLOOR()`, CTEs, `LAG()` for trend comparisons

---

## 📈 Sample Insights
- Schools like *Arizona State* and *USC* dominate in player production across decades.
- Certain teams have historically spent more aggressively, surpassing $1B in payroll earlier than others.
- Some players had careers lasting over **25 years**.
- Physical profiles of debuting players have shifted slightly over decades.

---

## 📚 What I Learned
- Structured large SQL projects into meaningful thematic parts
- Used advanced SQL techniques for real-world data analysis
- Gained insights into sports analytics and historical performance
- Developed clean, modular queries using CTEs and window functions

