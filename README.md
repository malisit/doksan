# doksan
A simple console application that enables hackers to get latest soccer scores and fixtures.  
At the present moment, ```doksan``` supports English Premier League, Spanish Primera Division and Turkish Super League.  
All data is being parsed from ```http://www.scorespro.com/```.  

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
doksan -l tr -t trabzonspor -f
```

Sample Output:  

```
11.02.17 15:00  Osmanlispor  -  Trabzonspor  
20.02.17 19:00  Trabzonspor  -  Alanyaspor  
26.02.17 19:00  Konyaspor  -  Trabzonspor  
05.03.17 19:00  Trabzonspor  -  Kardemir Karabukspor  
08.03.17 19:00  Akhisar Belediye  -  Trabzonspor  
12.03.17 19:00  Trabzonspor  -  Galatasaray  
19.03.17 19:00  Rizespor  -  Trabzonspor  
02.04.17 19:00  Trabzonspor  -  Besiktas  
09.04.17 19:00  Antalyaspor  -  Trabzonspor  
16.04.17 19:00  Trabzonspor  -  Genclerbirligi  
```

Sample Input:  
```
doksan -l en -t chelsea -rf
```

Sample Output:  

```
31.01.17 22:00  Liverpool FC 1 - 1 Chelsea FC  
28.01.17 17:00  Chelsea FC 4 - 0 Brentford FC  
22.01.17 18:30  Chelsea FC 2 - 0 Hull City  
14.01.17 19:30  Leicester City 0 - 3 Chelsea FC  
08.01.17 17:00   Chelsea FC 4 - 1 Peterborough  
04.01.17 22:00  Tottenham 2 - 0 Chelsea FC  
31.12.16 17:00  Chelsea FC 4 - 2 Stoke City  
26.12.16 17:00  Chelsea FC 3 - 0 Bournemouth  
17.12.16 14:30  Crystal Palace 0 - 1 Chelsea FC  
14.12.16 21:45  Sunderland AFC 0 - 1 Chelsea FC  
04.02.17 14:30  Chelsea FC  -  Arsenal FC  
12.02.17 15:30  Burnley FC  -  Chelsea FC  
18.02.17 19:30  Wolverhampton  -  Chelsea FC  
25.02.17 17:00  Chelsea FC  -  Swansea  
04.03.17 17:00  West Ham  -  Chelsea FC  
11.03.17 17:00  Chelsea FC  -  Watford FC  
18.03.17 17:00  Stoke City  -  Chelsea FC  
01.04.17 16:00  Chelsea FC  -  Crystal Palace  
05.04.17 20:45  Chelsea FC  -  Manchester City  
08.04.17 16:00  Bournemouth  -  Chelsea FC
```

Sample Input:  
```
doksan -l en -r
```

Sample Output:  

```
Week: 23, Wed 01 Feb 2017
22:00   Manchester United 0 - 0 Hull City  
22:00   Stoke City 1 - 1 Everton FC  
21:45   West Ham 0 - 4 Manchester City  

Week: 23, Tue 31 Jan 2017
22:00   Liverpool FC 1 - 1 Chelsea FC  
21:45   Arsenal FC 1 - 2 Watford FC  
21:45  Bournemouth 0 - 2 Crystal Palace  
21:45   Burnley FC 1 - 0 Leicester City  
21:45   Middlesbrough 1 - 1 West Bromwich  
21:45   Sunderland AFC 0 - 0 Tottenham  
21:45   Swansea 2 - 1 Southampton  
```

Sample Input:  
```
doksan -l en
```

Sample Output:  

```
Rank Team Point Matches Win Draw Lost Goals Difference Form
1. Chelsea FC 56 23 18 2 3 48 - 16 32 D W W L W 
2. Tottenham 47 23 13 8 2 45 - 16 29 D D W W W 
3. Arsenal FC 47 23 14 5 4 51 - 25 26 L W W D W 
4. Liverpool FC 46 23 13 7 3 52 - 28 24 D L D D W 
5. Manchester City 46 23 14 4 5 47 - 28 19 W D L W L 
6. Manchester United 42 23 11 9 3 33 - 21 12 D D D W W 
7. Everton FC 37 23 10 7 6 34 - 24 10 D W W W D 
8. West Bromwich 33 23 9 6 8 31 - 29 2 D W L W W 
9. Stoke City 29 23 7 8 8 29 - 35 -6 D D W W L 
10. Burnley FC 29 23 9 2 12 25 - 33 -8 W L W L W 
11. West Ham 28 23 8 4 11 29 - 40 -11 L W W L L 
12. Southampton 27 23 7 6 10 23 - 28 -5 L W L L L 
13. Watford FC 27 23 7 6 10 27 - 39 -12 W D D L L 
14. Bournemouth 26 23 7 5 11 32 - 41 -9 L D L D W 
15. Middlesbrough 21 23 4 9 10 19 - 26 -7 D L D D L 
16. Leicester City 21 23 5 6 12 24 - 38 -14 L L L D W 
17. Swansea 21 23 6 3 14 28 - 52 -24 W W L W L 
18. Crystal Palace 19 23 5 4 14 32 - 41 -9 W L L L L 
19. Hull City 17 23 4 5 14 20 - 47 -27 D L W L D 
20. Sunderland AFC 16 23 4 4 15 20 - 42 -22 D L L D L 
```

## TODO
- Get scorer information for games.
- Styling for proper listing of games.
- Other leagues and teams.