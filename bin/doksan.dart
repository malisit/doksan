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

	void checkLeagueAndTeam() {
		// TODO
		// Check the names if they exist in the variables
		// if so, return true, if not return false
	}
	
	void getHtml() {
		if (this.team==null) {
			if (this.isResults && this.isNextMatches){
				this.uri = leagues[this.league]['_l_name'];
				this.getLeagueResultsAndFixture();
			} else if (this.isResults) {
				this.uri = leagues[this.league]['_l_name_r'];
				this.getLeagueResults();
			} else if (this.isNextMatches) {
				this.uri = leagues[this.league]['_l_name_f'];
				this.getLeagueFixture();
			} else {
				this.uri = leagues[this.league]['_l_name_t'];
				this.getTable();
			}
		} else {
			if (this.isResults && this.isNextMatches){
				this.uri = leagues[this.league][this.team];
				this.getTeamResultsAndFixture();
			} else if (this.isResults) {
				this.uri = leagues[this.league][this.team];
				this.getTeamResults();
			} else if (this.isNextMatches) {
				this.uri = leagues[this.league][this.team];
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
				var results = document.getElementsByClassName("compgrp")[0];
				var games = results.getElementsByClassName("blocks");
				
				
	    		for (final game in games){
	    			var dateTime = game.getElementsByClassName("kick_t")[0].text.split(" ");
	    			String date = dateTime[0];
	    			String time = dateTime[1];
	    			String score = game.getElementsByClassName("score_link");

	    			if (score.length == 0) {
	    				score = game.getElementsByClassName("score")[0].text;
	    			} else {
	    				score = score[0].text;
	    			}
	    			
	    			String home_team = game.getElementsByClassName("home_o")[0].text.split("'>")[0];
	    			String away_team = game.getElementsByClassName("away_o")[0].text.split("'>")[0];

					print(date + " " + time + " " + home_team + " " + score + " " + away_team);


	    		}
	  		}); 
	}

	void getTeamFixture() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);
				var results = document.getElementsByClassName("compgrp")[1];
				var games = results.getElementsByClassName("blocks");
				
				
	    		for (final game in games){
	    			var dateTime = game.getElementsByClassName("kick_t")[0].text.split(" ");
	    			String date = dateTime[0];
	    			String time = dateTime[1];
	    			String score = game.getElementsByClassName("score_link");

	    			if (score.length == 0) {
	    				score = game.getElementsByClassName("score")[0].text;
	    			} else {
	    				score = score[0].text;
	    			}
	    			
	    			String home_team = game.getElementsByClassName("home_o")[0].text.split("'>")[0];
	    			String away_team = game.getElementsByClassName("away_o")[0].text.split("'>")[0];

					print(date + " " + time + " " + home_team + " " + score + " " + away_team);


	    		}
	  		}); 
	}

	void getTeamResultsAndFixture() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);
				var results = document.getElementsByClassName("compgrp");
				List resultsAndFixture = [];
				for (final result in results){
					var games = result.getElementsByClassName("blocks");
					
					List lines = [];
					
		    		for (final game in games){
		    			var dateTime = game.getElementsByClassName("kick_t")[0].text.split(" ");
		    			String date = dateTime[0];
		    			String time = dateTime[1];
		    			String score = game.getElementsByClassName("score_link");

		    			if (score.length == 0) {
		    				score = game.getElementsByClassName("score")[0].text;
		    			} else {
		    				score = score[0].text;
		    			}
		    			
		    			String home_team = game.getElementsByClassName("home_o")[0].text.split("'>")[0];
		    			String away_team = game.getElementsByClassName("away_o")[0].text.split("'>")[0];

						String line = date + " " + time + " " + home_team + " " + score + " " + away_team;

						lines.add(line);
		    		}

		    		resultsAndFixture.add(lines);

	    		}
	    		resultsAndFixture[0] = resultsAndFixture[0].reversed.toList();
	    		resultsAndFixture = resultsAndFixture.expand((i) => i).toList();
	    		for (final line in resultsAndFixture){
	    			print(line);
	    		}
	  		}); 
	}

	void getLeagueResultsAndFixture() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);	
				var results = document.getElementsByClassName("compgrp");
				var days = document.getElementsByClassName("ncet");

				for (var i = 0; i < results.length; i++) {
					var week = days[i].getElementsByClassName("ncet_round")[0].text;
					var date = days[i].getElementsByClassName("ncet_date")[0].text;
					var games = results[i].getElementsByClassName("blocks");
					print("Week: " + week + ", " + date);
					for (final game in games){
		    			var time = game.getElementsByClassName("kick")[0].text;
		    			String score = game.getElementsByClassName("score_link");

		    			if (score.length == 0) {
		    				score = game.getElementsByClassName("score")[0].text;
		    			} else {
		    				score = score[0].text;
		    			}
		    			
		    			String home_team = game.getElementsByClassName("home")[0].text.split("'>")[0];
		    			String away_team = game.getElementsByClassName("away")[0].text.split("'>")[0];

						print(time+ " " + home_team + " " + score + " " + away_team);


		    		}
		    		print("");
				}

			}); 
	}

	void getLeagueResults() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);	
				var results = document.getElementsByClassName("compgrp").sublist(0, 4);

				var days = document.getElementsByClassName("ncet").sublist(0, 4);
				String weekNum = days[0].getElementsByClassName("ncet_round")[0].text;

				for (var i = 0; i < results.length; i++) {
					String week = days[i].getElementsByClassName("ncet_round")[0].text;

					if (week != weekNum) {
						break;
					}	

					String date = days[i].getElementsByClassName("ncet_date")[0].text;
					var games = results[i].getElementsByClassName("blocks");
					print("Week: " + week + ", " + date);
					for (final game in games){
		    			String time = game.getElementsByClassName("kick")[0].text;
		    			String score = game.getElementsByClassName("score_link");

		    			if (score.length == 0) {
		    				score = game.getElementsByClassName("score")[0].text;
		    			} else {
		    				score = score[0].text;
		    			}
		    			
		    			String home_team = game.getElementsByClassName("home")[0].text.split("'>")[0];
		    			String away_team = game.getElementsByClassName("away")[0].text.split("'>")[0];

						print(time+ " " + home_team + " " + score + " " + away_team);


		    		}
		    		print("");
				}
			}); 
	}

	void getLeagueFixture() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);	
				var results = document.getElementsByClassName("compgrp").sublist(0, 4);

				var days = document.getElementsByClassName("ncet").sublist(0, 4);
				String weekNum = days[0].getElementsByClassName("ncet_round")[0].text;

				for (var i = 0; i < results.length; i++) {
					String week = days[i].getElementsByClassName("ncet_round")[0].text;

					if (week != weekNum) {
						break;
					}	

					String date = days[i].getElementsByClassName("ncet_date")[0].text;
					var games = results[i].getElementsByClassName("blocks");
					print("Week: " + week + ", " + date);
					for (final game in games){
		    			String time = game.getElementsByClassName("kick")[0].text;
		    			String score = game.getElementsByClassName("score_link");

		    			if (score.length == 0) {
		    				score = game.getElementsByClassName("score")[0].text;
		    			} else {
		    				score = score[0].text;
		    			}
		    			
		    			String home_team = game.getElementsByClassName("home")[0].text.split("'>")[0];
		    			String away_team = game.getElementsByClassName("away")[0].text.split("'>")[0];

						print(time+ " " + home_team + " " + score + " " + away_team);


		    		}
		    		print("");
				}
			}); 
	}

	void getTable() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);	
				var table = document.getElementById("standings_1a");
				var standings = table.getElementsByClassName("standing-tbl");
				print("Rank Team Point Matches Win Draw Lost Goals Difference Form");
				for (final standing in standings) {
					String rank = standing.getElementsByClassName("rank")[0].text;//.split("\">")[1].split(".<")[0];
					String team = standing.getElementsByClassName("team")[0].text;//.split("\">")[1].split("</")[0];
					String point = standing.getElementsByClassName("point")[0].text;
					String matchesPlayed = standing.getElementsByClassName("mp")[0].text;
					String winNum = standing.getElementsByClassName("winx")[0].text;
					String drawNum = standing.getElementsByClassName("draw")[0].text;
					String lostNum = standing.getElementsByClassName("lost")[0].text;
					String goalsScored = standing.getElementsByClassName("goalfa")[0].text;
					String goalsDiff = standing.getElementsByClassName("goaldiff")[0].text;
					var forms = standing.getElementsByClassName("c43px");
					String formStatus = "";
					for (final form in forms) {
						formStatus = formStatus + form.text + " ";
					}

					print(rank + " " + team + " " + point + " " + matchesPlayed + " " + winNum + " " + drawNum + " " + lostNum + " " +
						goalsScored + " " + goalsDiff + " " + formStatus
					 );
				}
			});
	}

}

