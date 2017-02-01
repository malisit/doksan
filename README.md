# doksan
A simple console application that enables hackers to get latest soccer scores and fixtures.
At the present moment, ```doksan``` only supports 18 teams that consist Turkish Super League.
All data is being parsed from ```http://www.livesoccertv.com/```.

##Installing
Run ```pub global activate doksan``` on command line.

## Usage
This application is pure Dart and works on only Dart VM.

### Flags and Options:
**Option:** ```-l, --league```: Specify which league you want to get information about. Must be provided.<br/>
**Option:** ```-t, --team```: Specify which team you want to get information about. Optional.<br/>
**Flag:** ```-r, --isResults```: Get previous results or not. When used with a team name, it returns results of last 5 games.<br/>
**Flag:** ```-f, --isNextMatches```: Get next games or not. When used with a team name, it returns next 5 games.<br/>


### Sample Usage:
Sample Input:<br/>
```
dart main.dart -l tr -t trabzonspor -f
```

Sample Output:<br/>

```
Feb 11  8:00 Osmanlıspor vs Trabzonspor
Feb 20 12:00 Trabzonspor vs Alanyaspor
Feb 26 13:00 Konyaspor vs Trabzonspor
Mar  5 13:00 Trabzonspor vs Karabükspor
Mar 12 14:00 Akhisar Belediyespor vs Trabzonspor
```



## TODO
- Get scorer information for games.
- Styling for proper listing of games.
- Leagues and teams data other than Turkish League.
- League information, fixtures, results.