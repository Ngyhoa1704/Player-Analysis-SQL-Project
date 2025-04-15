# 🧠 Player Analysis SQL Project

## 📌 Project Overview
This SQL project explores historical baseball player data using a normalized relational database. The main objectives are to analyze which schools produced the most players and how players' performance and participation varied over time. The project uses advanced SQL queries including CTEs, window functions, subqueries, and aggregations to draw insights from multiple interconnected tables.

## 🗂️ Dataset & Structure
Database used: `maven_advanced_sql`

Key tables:
- `schools`: Links players to the schools they attended
- `school_details`: Full school names and metadata
- `hall_of_fame`: Contains Hall of Fame induction data
- `people`: Player information
- `appearances`: Tracks annual player participation per team
- `batting`: Player performance statistics

## 🎯 Key Questions Answered

### 🏫 PART I: School Analysis
1. **How many schools produced players each decade?**
2. **Top 5 schools that produced the most players (all-time)**
3. **Top 3 schools per decade by player production**
4. **Hall of Fame inductees per school**

### 👤 PART II: Player Participation
1. **Number of teams each player appeared for in a season**
2. **Average and maximum teams played for per season**

### ⚾ PART III: Player Performance
1. **Players with most seasons of 100+ games**
2. **Which players had the best batting averages each season?**
3. **Best all-time batting average among players with ≥1000 at-bats**

## 🧪 SQL Techniques Used
- **CTEs** (`WITH`)
- **Window Functions**: `ROW_NUMBER`, `RANK`, `MAX OVER`
- **Aggregates**: `COUNT`, `AVG`, `MAX`, `SUM`
- **JOINs**: Multiple inner joins across relational tables
- **Filtering**: `WHERE`, `HAVING`, `LIMIT`
- **Date Calculations**: Grouping by decade using `FLOOR(yearID / 10) * 10`

## 📈 Sample Insights
- Schools like *University of Southern California* and *Arizona State University* top the list of player production.
- Some players played for 5+ teams in a single season.
- Legendary players like *Ty Cobb* and *Ted Williams* dominate batting average leaderboards.

## 📚 What I Learned
- Advanced SQL querying with real-world sports datasets
- Designing layered CTEs for cleaner logic and reusability
- Gained a deeper understanding of data modeling in sports analytics

