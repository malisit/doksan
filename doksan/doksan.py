#!/usr/bin/env python

import argparse
import json
import os
import urllib.request

from bs4 import BeautifulSoup

from . import variables

class Doksan(object):
	"""docstring for Doksan"""
	def __init__(self, league, team, results, fixture):
		super(Doksan, self).__init__()
		self.league = league
		self.team = team
		self.results = results
		self.fixture = fixture
		self.data = variables.variables

		if self.team:
			self.get_results_fixture_team()
		else:
			if self.results or self.fixture:
				self.get_results_fixture_league()
			else:
				self.get_league_table()


	def get_html(self, url):
		fp = urllib.request.urlopen(url)
		content = fp.read()

		content_str = content.decode("utf8")
		fp.close()

		return content_str

	def get_results_fixture_team_aux(self, soup, is_results):
		if is_results:
			ind = 0
		else:
			ind = 1

		results = soup.find_all("div",{'class':'compgrp'})[ind]
		games = results.find_all("table",{'class':'blocks'})

		if is_results:
			games = games[::-1]

		for game in games:
			kick_time = game.find("td", {'class':'kick_t'}).text
			home = game.find("td", {'class':'home_o'}).text
			away = game.find("td", {'class':'away_o'}).text

			if is_results:
				score = game.find("td", {'class':'score'}).text

			else:
				score = game.find("td", {'class':'score'})

				if score and not score.text == "CANC":
					score = "-"
				else:
					score = "CANC"

			if score != "CANC":
				print(kick_time + " " + home + " " + score + " " + away)


	def get_results_fixture_team(self):
		team = self.team
		league = self.league

		link = self.data[league][team]
		html = self.get_html(link)
		soup = BeautifulSoup(html, features="html.parser")
		
		if self.results:
			self.get_results_fixture_team_aux(soup, True)

		if self.fixture:
			self.get_results_fixture_team_aux(soup, False)


	def get_results_fixture_league_aux(self, soup, limit=2):
		results = soup.find("div",{'id':'national'})
		rounds = results.find_all(True, {'class':['ncet', 'blocks']})
		num_rounds = 0

		for line in rounds:
			round_ = line.find("li", {'class': 'ncet_round'})
			if round_:
				num_rounds += 1
				if num_rounds > limit:
					break
				print(round_.text)
				
			else:
				game = line.find("tbody")
				kick_date = game.find("span", {'class':'kick_t_dt'}).text
				kick_time = game.find("span", {'class':'kick_t_ko'}).text
				home = game.find("td", {'class':'home'}).text
				away = game.find("td", {'class':'away'}).text
				score = game.find("td", {'class':'score'}).text

				print(kick_date + " " + kick_time + " " + home + " " + score + " " + away)


	def get_results_fixture_league(self):
		league = self.league
		
		if self.results:
			link = self.data[league]["_l_name_r"]
			html = self.get_html(link)
			soup = BeautifulSoup(html, features="html.parser")
			self.get_results_fixture_league_aux(soup)

		if self.fixture:
			link = self.data[league]["_l_name_f"]
			html = self.get_html(link)
			soup = BeautifulSoup(html, features="html.parser")
			self.get_results_fixture_league_aux(soup)
		

	def get_league_table(self):
		league = self.league
		link = self.data[league]["_l_name_t"]
		html = self.get_html(link)
		soup = BeautifulSoup(html, features="html.parser")

		table = soup.find(True, {'id':'standings_1a'})
		teams = table.find_all(True, {'class':['blocks']})
		print("R T P M W D L GF GA F")
		for team in teams:
			rank = team.find("td", {'class':'rank'}).text
			team_ = team.find("td", {'class':'team'}).text
			point = team.find("td", {'class':'point'}).text
			mp = team.find("td", {'class':'mp'}).text
			wins = team.find("td", {'class':'winx'}).text
			draw = team.find("td", {'class':'draw'}).text
			lost = team.find("td", {'class':'lost'}).text
			goals = team.find("td", {'class':'goalfa'}).text.split(" - ")
			goals1 = goals[0]
			goals2 = goals[1]
			goals3 = str(int(goals1) - int(goals2))

			form =  team.find("td", {'class':'form'})
			form_ = form.find_all("span", {'class':'c43px'})
			form_t = ""
			for f in form_:
				form_t += f.text + " "

			l = [rank, team_, point, mp, wins, draw, lost, goals1, goals2, goals3, form_t]

			print(" ".join(l))




					


def main():
	parser = argparse.ArgumentParser()
	parser.add_argument("-l", "--league", help="league selection")
	parser.add_argument("-t", "--team", help="team selection")
	parser.add_argument("-r", "--results", action="store_true", help="show results")
	parser.add_argument("-f", "--fixture", action="store_true", help="show fixture")
	args = parser.parse_args()

	league = args.league or "tr"
	team = args.team
	results = args.results
	fixture = args.fixture

	doksan = Doksan(league, team, results, fixture)


if __name__ == '__main__':
	main()

		