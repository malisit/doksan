import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'dart:io';
import 'package:args/args.dart';
import 'variables.dart';


void main(List<String> args) {
	final parser = new ArgParser()
    	..addOption('league', abbr: 'l')
    	..addOption('team', abbr: 't')
    	..addFlag('isResults', abbr:'r')
    	..addFlag('isNextMatches', abbr:'f');

	argResults = parser.parse(args);
	String league = argResults['league'];
	String team = argResults['team'];
	bool isResults = argResults['isResults'];
	bool isNextMatches = argResults['isNextMatches'];

	var doksan = new Doksan(team:team, league:league, isResults:isResults, isNextMatches:isNextMatches);
	doksan.run();
	
}

class Doksan {
	final String team;
	String league;
	bool isResults;
	bool isNextMatches;
	String uri;

	Doksan({String this.team=null, String this.league, bool this.isResults, bool this.isNextMatches});

	Doksan.leagueOnly(String team) : this(team, null);

	void run() {
		//String uri = URIGenerator();
		getHtml();
	}

	void getHtml() {
		if (this.team==null) {
			if (this.isResults && this.isNextMatches){
				this.uri = 'http://www.livesoccertv.com/';
				getLeagueResultsAndFixture();
			} else if (this.isResults) {
				getLeagueResults();
			} else if (this.isNextMatches) {
				getLeagueFixture();
			}
		} else {
			if (this.isResults && this.isNextMatches){
				this.uri = 'http://www.livesoccertv.com/' + leagues[this.league][this.team];
				this.getTeamResultsAndFixture();
			} else if (this.isResults) {
				this.uri = 'http://www.livesoccertv.com/' + leagues[this.league][this.team];
				this.getTeamResults();
			} else if (this.isNextMatches) {
				this.uri = 'http://www.livesoccertv.com/' + leagues[this.league][this.team];
				this.getTeamFixture();
			}
		}
		return uri;
	}

	void getTeamResults() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);
				var scores = document.getElementsByClassName("matchrow");
				
	    		for (final i in scores){
	    			var dateTime = i.getElementsByClassName("ts");
	    			var td = i.getElementsByTagName("td")[4];
	    			String date = dateTime[0].text;
	    			String time = dateTime[1].text;
	    			String scoreLine = td.text.replaceFirst(new RegExp(r"^\s+"), "");
	    			try {
						var teamsAndScores = scoreLine.split("-");

						//Will be used
						var homeName = teamsAndScores[0][0];
						var awayName = teamsAndScores[1][1];
						var homeScore = teamsAndScores[0][1];
						var awayScore = teamsAndScores[1][0];
					} catch(e) {
						continue;
					}

					print(date + " " + time + " " + scoreLine);


	    		}
	  		}); 
	}

	void getTeamFixture() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);
				var scores = document.getElementsByClassName("matchrow");
				
	    		for (final i in scores){
	    			var dateTime = i.getElementsByClassName("ts");
	    			var td = i.getElementsByTagName("td")[4];
	    			String date = dateTime[0].text;
	    			String time = dateTime[1].text;
	    			String scoreLine = td.text.replaceFirst(new RegExp(r"^\s+"), "");
	    			try {
						var teamsAndScores = scoreLine.split("vs");

						//Will be used
						var homeName = teamsAndScores[0][0];
						var awayName = teamsAndScores[1][1];
						var homeScore = teamsAndScores[0][1];
						var awayScore = teamsAndScores[1][0];
					} catch(e) {
						continue;
					}

					print(date + " " + time + " " + scoreLine);


	    		}
	  		}); 
	}

	void getTeamResultsAndFixture() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);
				var scores = document.getElementsByClassName("matchrow");
				
	    		for (final i in scores){
	    			var dateTime = i.getElementsByClassName("ts");
	    			var td = i.getElementsByTagName("td")[4];
	    			String date = dateTime[0].text;
	    			String time = dateTime[1].text;
	    			String scoreLine = td.text.replaceFirst(new RegExp(r"^\s+"), "");
	    			try {
						var teamsAndScores = scoreLine.split("vs");

						//Will be used
						var homeName = teamsAndScores[0][0];
						var awayName = teamsAndScores[1][1];
						var homeScore = teamsAndScores[0][1];
						var awayScore = teamsAndScores[1][0];
					} catch(e) {
						
					}

					print(date + " " + time + " " + scoreLine);


	    		}
	  		}); 
	}

}

