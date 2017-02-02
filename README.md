# doksan
A simple console application that enables hackers to get latest soccer scores and fixtures.  
At the present moment, ```doksan``` only supports English Premier League and Turkish Super League.  
All data is being parsed from ```http://www.scorespro.com/```.  

## Installing
- Run ```pub global activate doksan``` on command line.  
- Add your ```pub-cache```'s ```bin``` directory to ```PATH```. (e.g. Add ```export PATH="$PATH":"~/.pub-cache/bin"``` to .bashrc)  

## Usage
This application is pure Dart and works on only Dart VM.  

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

Week: 22, Sun 22 Jan 2017
18:30   Chelsea FC 2 - 0 Hull City  
16:15   Arsenal FC 2 - 1 Burnley FC  
14:00  Southampton 3 - 0 Leicester City  

Week: 22, Sat 21 Jan 2017
19:30   Manchester City 2 - 2 Tottenham  
17:00   Bournemouth 2 - 2 Watford FC  
17:00  Crystal Palace 0 - 1 Everton FC  
17:00   Middlesbrough 1 - 3 West Ham  
17:00   Stoke City 1 - 1 Manchester United  
17:00   West Bromwich 2 - 0 Sunderland
```

## TODO
- Get scorer information for games.
- Styling for proper listing of games.
- Leagues and teams data other than Turkish League & Premier League.