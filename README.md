# doksan
A simple console application that enables hackers to get latest soccer scores and fixtures.  
At the present moment, ```doksan``` supports English Premier League, Spanish Primera Division and Turkish Super League.  
All data is being parsed from ```http://www.livescores.com/```.  

## Installation
- Install via pip; ```pip install doksan```.

## Usage
### Flags and Options:
**Option:** ```-l, --league```: Specify which league you want to get information about. Must be provided.  
**Option:** ```-t, --team```: Specify which team you want to get information about. Optional.  
**Flag:** ```-r, --isResults```: Get previous results or not. When used with a team name, it returns results of last 5 games.  
**Flag:** ```-f, --isNextMatches```: Get next games or not. When used with a team name, it returns next 5 games.  


### Sample Usage:
Sample Input:  
```
doksan -l en -t liverpool -f
```

Sample Output:  

```
16:30 Tottenham Hotspur - Liverpool
15:00 Liverpool - Southampton
17:30 Aston Villa - Liverpool
20:00 Liverpool - Leicester City  
```

Sample Input:  
```
doksan -l en -t chelsea -rf
```

Sample Output:  

```
FT Aston Villa 0 - 2 Chelsea
FT Brentford 0 - 0 Chelsea
FT Chelsea 1 - 1 Manchester United
FT Brighton & Hove Albion 4 - 1 Chelsea
12:00 Chelsea - Arsenal
17:30 Newcastle United - Chelsea
17:30 Chelsea - AFC Bournemouth
16:30 Nottingham Forest - Chelsea
```

Sample Input:  
```
doksan -l en -r
```

Sample Output:  

```
October 24
FT West Ham United 2 - 0 AFC Bournemouth

October 29
FT Leicester City 0 - 1 Manchester City
FT AFC Bournemouth 2 - 3 Tottenham Hotspur
FT Brentford 1 - 1 Wolverhampton Wanderers
FT Brighton & Hove Albion 4 - 1 Chelsea
FT Crystal Palace 1 - 0 Southampton
FT Newcastle United 4 - 0 Aston Villa
FT Fulham 0 - 0 Everton
FT Liverpool 1 - 2 Leeds United

October 30
FT Arsenal 5 - 0 Nottingham Forest
FT Manchester United 1 - 0 West Ham United
```

Sample Input:  
```
doksan -l en
```

Sample Output:  

```
R T P M W D L GF GA GD
1 Arsenal 31 12 10 1 1 30 11 19
2 Manchester City 29 12 9 2 1 37 11 26
3 Tottenham Hotspur 26 13 8 2 3 26 16 10
4 Newcastle United 24 13 6 6 1 24 10 14
5 Manchester United 23 12 7 2 3 17 16 1
6 Chelsea 21 12 6 3 3 17 15 2
7 Fulham 19 13 5 4 4 22 22 0
8 Brighton & Hove Albion 18 12 5 3 4 19 15 4
9 Liverpool 16 12 4 4 4 23 15 8
10 Crystal Palace 16 12 4 4 4 13 16 -3
11 Brentford 15 13 3 6 4 19 22 -3
12 Everton 14 13 3 5 5 11 12 -1
13 West Ham United 14 13 4 2 7 11 13 -2
14 AFC Bournemouth 13 13 3 4 6 12 28 -16
15 Leeds United 12 12 3 3 6 15 19 -4
16 Aston Villa 12 13 3 3 7 11 20 -9
17 Southampton 12 13 3 3 7 11 20 -9
18 Leicester City 11 13 3 2 8 21 25 -4
19 Wolverhampton Wanderers 10 13 2 4 7 6 19 -13
20 Nottingham Forest 9 13 2 3 8 8 28 -20
```

## TODO
- Get scorer information for games.
- Styling for proper listing of games.
- Other leagues and teams.