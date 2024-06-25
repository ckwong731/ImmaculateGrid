CREATE DATABASE MLB;
Use MLB;
SELECT * FROM appearances;

#Basic Teams pull - Find a player who played at least 1 game for the two specified teams. Returns only the players who have played less than 20 games combined for both teams

with Team1ids as (select teamid from(with cte as (select franchid, count(yearid)
from teams
where name = 'Los Angeles Dodgers'
group by franchid)

select teamid, count(yearid)
from teams
where franchid in (select franchid from cte)
group by teamid) as t),

Team2ids as (select teamid from(with cte as (select franchid, count(yearid)
from teams
where name = 'Detroit Tigers'
group by franchid)

select teamid, count(yearid)
from teams
where franchid in (select franchid from cte)
group by teamid) as t),

TEAM1PLAYERS AS (
    SELECT playerid, sum(g) as team1games
    FROM batting
    join people using (playerid)
    WHERE teamid in (select * from team1ids)
    group by playerid
),

TEAM2PLAYERS AS (
    SELECT PLAYERID, SUM(G) AS TEAM2GAMES
    FROM batting
    join people using (playerid)
    WHERE teamid in (select * from team2ids)
    GROUP BY PLAYERID
),

allrelevantplayers as 
	(SELECT p.namefirst, p.namelast, p.playerid, p.debut, 
		   COALESCE(t1.team1games, 0) AS team1_games, 
           COALESCE(t2.team2games, 0) AS team2_games,
           COALESCE(t1.team1games, 0) + COALESCE(t2.team2games, 0) AS total_games
from people p 
left join Team1Players t1 ON p.playerid = t1.playerid
LEFT JOIN Team2Players t2 ON p.playerid = t2.playerid
where COALESCE(t1.team1games, 0) > 0 AND COALESCE(t2.team2games, 0) > 0
)

Select namefirst, namelast, playerid, debut, total_games
from allrelevantplayers
where total_games < 20
order by debut, playerid 
;




#STAT SEASONS - Find a player who had a season where they achieved a certain stat
	

#stat season - .300 Average
	

with cte as (select franchid, count(yearid)
from teams
where name = 'Detroit Tigers'
group by franchid),

team1ids as (
select teamid, count(yearid)
from teams
where franchid in (select franchid from cte)
group by teamid)

select  namefirst, namelast, playerid, yearid, debut, HR, ab, format(H/AB,3) as avg
from people
join batting using (playerid)
where format(H/AB,3)>.300 and teamid in (select teamid from team1ids) and ab=1
order by debut asc;


#stat season - 10+ win season as a pitcher

	
with cte as (select franchid, count(yearid)
from teams
where name = 'Detroit Tigers'
group by franchid),

team1ids as (
select teamid, count(yearid)
from teams
where franchid in (select franchid from cte)
group by teamid)

select namefirst, namelast, playerid, yearid, debut, W
from people
join pitching using (playerid)
where W>=10 and teamid in (select teamid from team1ids)
order by yearid;

#stat season - 30+ SB season
with cte as (select franchid, count(yearid)
from teams
where name = 'Detroit Tigers'
group by franchid),

team1ids as (
select teamid, count(yearid)
from teams
where franchid in (select franchid from cte)
group by teamid)

select namefirst, namelast, playerid, yearid, debut, SB
from people
join batting using (playerid)
where SB>=10 and teamid in (select teamid from team1ids)
order by yearid;

#stat season - 100 RBI

	
with cte as (select franchid, count(yearid)
from teams
where name = 'Detroit Tigers'
group by franchid),

team1ids as (
select teamid, count(yearid)
from teams
where franchid in (select franchid from cte)
group by teamid)

select namefirst, namelast, playerid, yearid, debut, RBI
from people
join batting using (playerid)
where RBI>=100 and teamid in (select teamid from team1ids)
order by yearid;



#STAT CAREERS

#2000 Strikeout Career who played at least 1 game for the specified team

	
with cte as (select franchid, count(yearid)
from teams
where name = 'Detroit Tigers'
group by franchid),

team1ids as (
select teamid, count(yearid)
from teams
where franchid in (select franchid from cte)
group by teamid),

relevantplayers as (
select playerid, teamid, yearid, sum(g) as total_games
from people 
join pitching using (playerid)
where teamid in (select teamid from team1ids)
group by playerid, teamid, yearid
)

select namefirst, namelast, playerid, debut, sum(SO) as career_Ks
from people
join pitching using (playerid)
where playerid in (select playerid from relevantplayers)
group by namefirst, namelast, playerid, debut
having sum(SO)>=2000
order by debut;
