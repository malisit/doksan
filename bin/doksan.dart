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
				this.uri = leagues[this.league]['_l_name'];
				this.getLeagueResultsAndFixture();
			} else if (this.isResults) {
				this.uri = leagues[this.league]['_l_name_r'];
				this.getLeagueResults();
			} else if (this.isNextMatches) {
				this.uri = leagues[this.league]['_l_name_f'];
				this.getLeagueFixture();
			} else {
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

				for (final result in results){
					var games = result.getElementsByClassName("blocks");
				
				
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

	void getLeagueFixture() {
		uri = this.uri;
		http.read(uri)
			.then((contents) {
				var document = parse(contents);	
				var results = document.getElementsByClassName("compgrp").sublist(0, 4);
				var days = document.getElementsByClassName("ncet").sublist(0, 4);

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

}

