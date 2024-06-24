Immaculate Grid MLB SQL Project


Project Overview
This project is focused on creating a SQL-based solution to enhance performance in the Immaculate Grid game for Major League Baseball (MLB). The Immaculate Grid game challenges players to fill a 3x3 grid with MLB players who match the criteria for each cell, aiming to use the most obscure players to achieve the lowest rarity score possible. The goal of this project is to develop efficient SQL queries to pull data on obscure MLB players, thereby minimizing the rarity score.


Introduction
The Immaculate Grid game requires a deep knowledge of MLB history and players. The objective is to fill each cell in the grid with a player who matches the specified criteria while using the least commonly known players to achieve a lower rarity score. This project leverages SQL to query databases of MLB player statistics and history, identifying obscure players who meet the criteria for each grid cell.

Project Structure
The project consists of the following main components:

SQL Scripts: Contains the SQL queries used to pull data on MLB players.
Data: Includes the datasets used for querying player information.
Documentation: Provides detailed explanations of the queries and their usage.
Data Sources
The project utilizes various data sources, including:

MLB Player Database: A comprehensive database of MLB players, including historical and current players, their teams, and performance statistics.
Game-Specific Criteria: Data specifying the criteria for each cell in the Immaculate Grid game.
SQL Queries
The SQL queries are designed to:

Identify Obscure Players: Extract player data based on specified criteria (e.g., team, position, career milestones) and sort by factors indicating obscurity, such as fewer games played or lower career statistics.
Optimize Rarity Scores: Combine different criteria to find the most suitable players for each grid cell, aiming for the lowest rarity scores.


Memory updated
Immaculate Grid MLB SQL Project
Project Overview
This project is focused on creating a SQL-based solution to enhance performance in the Immaculate Grid game for Major League Baseball (MLB). The Immaculate Grid game challenges players to fill a 3x3 grid with MLB players who match the criteria for each cell, aiming to use the most obscure players to achieve the lowest rarity score possible. The goal of this project is to develop efficient SQL queries to pull data on obscure MLB players, thereby minimizing the rarity score.

Table of Contents
Introduction
Project Structure
Data Sources
SQL Queries
Usage
Contributing
License
Introduction
The Immaculate Grid game requires a deep knowledge of MLB history and players. The objective is to fill each cell in the grid with a player who matches the specified criteria while using the least commonly known players to achieve a lower rarity score. This project leverages SQL to query databases of MLB player statistics and history, identifying obscure players who meet the criteria for each grid cell.

Project Structure
The project consists of the following main components:

SQL Scripts: Contains the SQL queries used to pull data on MLB players.
Data: Includes the datasets used for querying player information.
Documentation: Provides detailed explanations of the queries and their usage.
Data Sources
The project utilizes various data sources, including:

MLB Player Database: A comprehensive database of MLB players, including historical and current players, their teams, and performance statistics.
Game-Specific Criteria: Data specifying the criteria for each cell in the Immaculate Grid game.
SQL Queries
The SQL queries are designed to:

Identify Obscure Players: Extract player data based on specified criteria (e.g., team, position, career milestones) and sort by factors indicating obscurity, such as fewer games played or lower career statistics.
Optimize Rarity Scores: Combine different criteria to find the most suitable players for each grid cell, aiming for the lowest rarity scores.
Example Query:

sql
Copy code
SELECT player_name, team, position, career_stat
FROM mlb_players
WHERE team = 'Specified Team'
AND position = 'Specified Position'
ORDER BY career_stat ASC
LIMIT 1;
Usage
To use the SQL scripts in this project:

Setup Database: Download the MLB player database: https://www.kaggle.com/datasets/open-source-sports/baseball-databank
Run Queries: Execute the provided SQL scripts to retrieve obscure player data.
Integrate with Game: Use the results from the queries to fill in the Immaculate Grid game.

