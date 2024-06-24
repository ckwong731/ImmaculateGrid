Use MLB;
SELECT * FROM appearances;

#NEXT IS TO FIGURE OUT HOW TO JOIN ALL THREE TABLES

#Basic Teams pull

with cte as (select franchid, count(yearid)
from teams
where name = 'Oakland Athletics'
group by franchid)

select teamid, count(yearid)
from teams
where franchid in (select franchid from cte)
group by teamid;

WITH TEAM1 AS (
    SELECT playerid
    FROM batting
    join people using (playerid)
    WHERE teamid = 'kc1'
),
TEAM2 AS (
    SELECT playerid 
    FROM batting
    join people using (playerid)
    WHERE teamid = 'cha'
)

Select namefirst, namelast, playerid, debut, sum(sum_games)
from(
SELECT namefirst, namelast, playerid, debut, teamid, sum(G) as sum_games
from batting
join people using (playerid)
where playerid in (select * from Team1) and playerid in (select * from Team2)
group by playerid,  teamid, namefirst, namelast,  debut
order by debut desc) as t
where teamid in ('kc1', 'cha')
group by playerid, namefirst, namelast,  debut
having sum(sum_games) < 20
order by playerid, debut
;




#STAT SEASONS

#stat season - .300 Average

with team1ids as (with cte as (select franchid, count(yearid)
from teams
where name = 'Minnesota twins'
group by franchid)

select teamid, count(yearid)
from teams
where franchid in (select franchid from cte)
group by teamid)

select  namefirst, namelast, playerid, yearid, debut, HR, ab, format(H/AB,3) as avg
from people
join batting using (playerid)
where format(H/AB,3)>.300 and teamid in (select teamid from team1ids) and ab=1
order by debut asc;


#stat season - 10+ win season
with team1ids as (with cte as (select franchid, count(yearid)
from teams
where name = 'Boston Red Sox'
group by franchid)

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
select namefirst, namelast, playerid, yearid, debut, SB
from people
join Batting using (playerid)
where SB>=30 and teamid="CIN"
order by yearid;

select *
from teams
where name = 'Cincinnati Reds';

#stat season - 100 RBI

select namefirst, namelast, playerid, yearid, debut, RBI
from people
join Batting using (playerid)
where RBI>=100 and teamid="CHA"
order by yearid;

select *
from teams
where name = 'Tampa Bay Rays';



#STAT CAREERS
select namefirst, namelast, playerid, yearid, debut, sum(SO) as career_Ks
from people
join pitching using (playerid)
where sum(SO)>=2000 and teamid="PIT"
group by namefirst, namelast, playerid, yearid, debut
order by yearid;


#Hall of Fame
with CTE as (SELECT playerid FROM halloffame
where inducted = "Y" and category = "player")

select namefirst, namelast, playerid, yearid, debut, HR, format(H/AB,3) as avg
from people
join batting
where format(H/AB,3)>.300 and playerid in (select playerid from CTE)
order by yearid asc;







#played position min 1 game
select * from appearances;

with CTE as (SELECT * FROM appearances
JOIN people using (playerid))

select * from CTE;

select namefirst, namelast, teamid, yearid, G_cf
from CTE
WHERE G_cf<2 and G_cf>0 AND teamid='sea'
order by yearid;

#Ok, so I guess the appearances database only goes up to 1964 :/
select * from appearances order by yearid desc;

select *
from teams
where name = 'TEXAS RANGERS';

#only one team code: pulls all players who have played only 1 game in their MLB career. Filtered by team
select namelast, namefirst, playerid, debut
from people
join batting using (playerid)
where playerid in 
	(select playerid
	from batting 
	group by playerid
	having Sum(G) =1) and teamid='cha'
order by debut asc;



#Teams pull Workshop
with TEAM1NAMES AS (
    SELECT playerid
    FROM batting
    join people using (playerid)
    WHERE teamid in (select teamid from (with cte1 as (select franchid, count(yearid)
from teams
where name = 'Atlanta Braves'
group by franchid)

select teamid, count(yearid)
from teams
where franchid in (select franchid from cte1)
group by teamid) as t)
),

TEAM2NAMES AS (
    SELECT playerid 
    FROM batting
    join people using (playerid)
    WHERE teamid in (select teamid from (with cte2 as (select franchid, count(yearid)
from teams
where name = 'Houston Astros'
group by franchid)

select teamid, count(yearid)
from teams
where franchid in (select franchid from cte2)
group by teamid) as t2)
),

TEAM1IDS AS (with cte2 as (select franchid, count(yearid)
from teams
where name = 'Atlanta Braves'
group by franchid)

select teamid, count(yearid)
from teams
where franchid in (select franchid from cte2)
group by teamid), 

TEAM2IDS AS (with cte2 as (select franchid, count(yearid)
from teams
where name = 'Houston Astros'
group by franchid)

select teamid, count(yearid)
from teams
where franchid in (select franchid from cte2)
group by teamid)

Select namefirst, namelast, playerid, debut, sum(sum_games)
from(
	SELECT namefirst, namelast, playerid, debut, teamid, sum(G) as sum_games
	from batting
	join people using (playerid)
	where playerid in (select * from TEAM1NAMES) and playerid in (select * from TEAM2NAMES)
	group by playerid,  teamid, namefirst, namelast,  debut
	order by debut desc) as t
where
	teamid in ('HOU', 'ATL') 
group by 
	playerid, namefirst, namelast,  debut
having 
	sum(sum_games) < 20
order by 
	playerid, debut
;