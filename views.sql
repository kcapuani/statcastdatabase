Select
Player.FirstName as FirstName,
Player.LastName as LastName,
Position.PositionName as Position,
Play.Distance as Distance,
Play.PStart as PlayStart,
Field.x as XStart,Field.y as YStart,
Play.PEnd as PlayEnd,
Field.x as XEnd,Field.y as YEnd,
Play.RouteEfficiency as RouteEfficiency,
Play.Acceleration as Acceleration,
Play.Result as PlayResult
FROM Player,PlayerPosition,Play,Field,Position
WHERE
Player.PlayerID=PlayerPosition.PlayerID
and PlayerPosition.PlayerPositionID=Play.FielderID
and PlayerPosition.PositionID=Position.PositionID
and Play.PStart=Field.FieldID
and Play.PEnd=Field.FieldID;

SELECT
Play.PStart as PlayStart,
Field.X as XStart, Field.Y as YStart,
Play.PEnd as PlayEnd,
Field.X as XEnd, Field.Y as YEnd
FROM Play,Field
WHERE Play.PStart=Field.FieldID
and Play.PEnd=Field.FieldID;

Select
play.playid,play.pstart,play.pend,field.x,field.y
from Play,Field
where field.fieldid=play.pstart
and field.fieldid=play.pend;

Select Distinct
Play.PlayID,
Play.Pstart,
Field.X as XStart,Field.Y as YStart
FROM Play,Field
where play.pstart=field.fieldid
UNION
Select Distinct
Play.PlayID,
Play.Pend,
Field.X as XEnd,Field.Y as YEnd
FROM Play,Field
where play.pend=field.fieldid;

Select 
p.playid as Play,s.*,
e.*
from play p
join field s
on p.pstart=s.fieldid
join field e
on p.pend=e.fieldid;

Select 
p.playid as Play,s.fieldid as Starting,s.x as XStart,s.y as YStart,
e.fieldid as Ending,e.x as XEnd,e.y as YEnd
from play p
join field s
on p.pstart=s.fieldid
join field e
on p.pend=e.fieldid;

CREATE OR REPLACE VIEW Plays_view as
Select 
p.playid as Play,
p.game as Game,
b.firstname as FirstName,b.lastname as LastName,
po.positionname as Position,
s.fieldid as StartingFieldID,s.x as StartingX,s.y as StartingY,
initcap(s.x) || ',' || initcap(s.y) as StartingXY,
e.fieldid as EndingFieldID,e.x as EndingX,e.y as EndingY,
initcap(e.x) || ','|| initcap(e.y) as EndingXY,
p.distance as DistanceTraveled,p.firststep as ReactionSpeed,
p.acceleration as Acceleration,p.topspeed as TopSpeed,
p.routeefficiency as RouteEfficiency,
p.expectedcatchprob,p.exitvelocity as BattedBallExitVelocity,
p.result as PlayResult,
ba.lastname as Batter,pi.lastname as Pitcher
from play p
join playerposition pp
on p.fielderid=pp.playerpositionid
join player b
on pp.playerid=b.playerid
join position po
on pp.positionid=po.positionid
join field s
on p.pstart=s.fieldid
join field e
on p.pend=e.fieldid
join player ba
on p.batterid=ba.playerid
join player pi
on p.pitcherid=pi.playerid
where offdef='off';

