--cau 1
select PlayerID, Fname , Mname, Lname
from PLAYER
where TeamName = 'Barcelona'

--cau 2
select StadName
from STADIUM
where Capacity > 50000

--cau 3
select GameID
from GAME
where HomeTeam = 'Barcelona' or AwayTeam = 'Barcelona'

--cau 4
select Fname , Mname, Lname , Salary
from MANAGER
join CONTRACT on MANAGER.ContractID = CONTRACT.ContractID
where Salary > 70000000

--cau 5
select Fname , Mname, Lname
from PLAYER
join TEAM on PLAYER.TeamName = TEAM.TeamName
join GAME on TEAM.TeamName = GAME.HomeTeam
where TEAM.TeamName = 'Barcelona' and MDate like '2016-04%'

--cau 6
select Fname , Mname, Lname, Position , Height ,Weight , Salary
from PLAYER
join TEAM on PLAYER.TeamName = TEAM.TeamName
join CONTRACT on PLAYER.ContractID = CONTRACT.ContractID
where city = 'Anfield'
order by Salary DESC, Height ASC

--cau 7
select Position , count(PlayerID) as 'so cau thu vi tri nay' , avg(salary) as 'luong trung binh'
from PLAYER
join CONTRACT on PLAYER.ContractID = CONTRACT.ContractID
group by Position

--cau 8
select TEAM.TeamName , Abbr , count(PlayerID) as 'so cau thu doi bong' , avg(Height) as 'chieu cao trung binh'
from TEAM
join PLAYER on TEAM.TeamName = Player.TeamName
group by TEAM.TeamName , Abbr

--cau 9
select TEAM.TeamName, avg(Salary) as 'luong trung binh'
from TEAM
join PLAYER on TEAM.TeamName = Player.TeamName
join CONTRACT on PLAYER.ContractID = CONTRACT.ContractID
group by TEAM.TeamName 
having avg(Salary) > 50000

--cau 10
select REFEREE.RefereeID, Fname, Mname, Lname, count(GameID) as 'so tran dieu hanh'
from REFEREE
join OFFICIATES on REFEREE.RefereeID = OFFICIATES.RefereeID
group by REFEREE.RefereeID, Fname, Mname, Lname

--cau 11
select COACH.Fname, COACH.Mname, COACH.Lname, COACH.TeamName , count(PLAYER.PlayerID) as 'so cau thu quoc tich Spanish huan luyen'
from COACH
join TEAM on TEAM.TeamName = COACH.TeamName
join PLAYER on TEAM.TeamName = PLAYER.TeamName
where Nationality = 'Spanish'
group by COACH.Fname, COACH.Mname, COACH.Lname, COACH.TeamName

--cau 12
select Fname, Mname, Lname , Height , Weight , sum(so_tran) as 'so tran thi dau'
from (
	select  PLAYER.Fname, PLAYER.Mname, PLAYER.Lname , Height , Weight,
			count(GameID) as so_tran
	from PLAYER
	join TEAM on TEAM.TeamName = PLAYER.TeamName
	join GAME on TEAM.TeamName = GAME.HomeTeam
	group by PLAYER.Fname, PLAYER.Mname, PLAYER.Lname , Height , Weight
	
	union all

	select  PLAYER.Fname, PLAYER.Mname, PLAYER.Lname , Height , Weight,
			count(GameID) as so_tran
	from PLAYER
	join TEAM on TEAM.TeamName = PLAYER.TeamName
	join GAME on TEAM.TeamName = GAME.AwayTeam
	group by PLAYER.Fname, PLAYER.Mname, PLAYER.Lname , Height , Weight
) as combined
group by Fname, Mname, Lname , Height , Weight

--cau 13
select TEAM.TeamName , Points
from TEAM 
join PLAYER on TEAM.TeamName = PLAYER.TeamName
where (
	select count(PlayerID)
	from Player
	where Player.TeamName = Team.TeamName and Birthday < '1990-01-01'
) < 2

--cau 14
select Fname, Mname, Lname, Nationality
from PLAYER
join GOAL on PLAYER.PlayerID = GOAL.PlayerID
group by Fname, Mname, Lname , Nationality
having count(GoalID) = (
	select max(goal_count) from (
		select count(GoalID) as goal_count
		from goal
		group by PlayerID
	) as subquery
)
order by Nationality

--cau 15
select Fname, Mname, Lname
from (
	select  PLAYER.Fname, PLAYER.Mname, PLAYER.Lname
	from PLAYER
	join TEAM on TEAM.TeamName = PLAYER.TeamName
	join GAME on TEAM.TeamName = GAME.HomeTeam
	where Team.TeamName = 'Numancia' and MDate like '2016-04%'
	group by PLAYER.Fname, PLAYER.Mname, PLAYER.Lname
	
	union all

	select  PLAYER.Fname, PLAYER.Mname, PLAYER.Lname
	from PLAYER
	join TEAM on TEAM.TeamName = PLAYER.TeamName
	join GAME on TEAM.TeamName = GAME.AwayTeam
	where Team.TeamName = 'Numancia' and MDate like '2016-04%'
	group by PLAYER.Fname, PLAYER.Mname, PLAYER.Lname 
) as combined
group by Fname, Mname, Lname

--cau 16
select  PLAYER.Fname, PLAYER.Mname, PLAYER.Lname
from PLAYER
join TEAM on TEAM.TeamName = PLAYER.TeamName
join GAME on TEAM.TeamName = GAME.AwayTeam
where Team.TeamName = 'Numancia' and MDate like '2016-04%'
group by PLAYER.Fname, PLAYER.Mname, PLAYER.Lname 