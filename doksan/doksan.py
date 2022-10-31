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


	def get_results_fixture_league_aux(self, soup, res):
		results = soup.find("div", {'class':'Ja'})
		games = results.find_all("div")
		
		# print(games)
		# text_file = open("sample.txt", "w")
		# n = text_file.write(str(games[14]))
		# text_file.close()

		results = {}
		fixtures = {}

		for game in games:
			class_ = game.get("class")
			if class_:
				class_ = " ".join(class_)
				if class_ == "xb":
					dt = game.find(True, {'class':'yb'}).text
					# results.append({dt})
					results[dt] = []
					fixtures[dt] = []
				if class_ == "Tc Xc":
					time = game.find(True, {'class':'gg cg'}).text
					sides = game.find_all(True, {'class':'jh'})
					side1, side2 = sides[0].text, sides[1].text
					side1_score = game.find(True, {'class':'mh'}).text
					side2_score = game.find(True, {'class':'nh'}).text
					# print(dt, time, side1,side1_score, side2_score, side2)
					if time == "FT" and (res==0 or res==2):
						results[dt].append(" ".join((time, side1,side1_score, "-", side2_score, side2)))
						# print(time, side1,side1_score, " - ", side2_score, side2)
					elif time !="FT" and (res==1 or res==2):
						fixtures[dt].append(" ".join((time, side1, "-", side2)))
						# print(time, side1, " - ", side2)

		if res==0 or res!=1:
			for r in results.items():
				printed = False
				if len(r[1])>0:
					print(r[0])
					last_dt = r[0]
					printed = True
				for game in r[1]:
					print(game)

				if printed:
					print("")
		if res==1 or res!=0:
			for f in fixtures.items():
				printed = False
				if len(f[1])>0:
					printed = True
					if f[0] != last_dt:
						print(f[0])
						
				for game in f[1]:
					print(game)

				if printed:
						print("")
						

	def get_results_fixture_league(self):
		league = self.league

		link = self.data[league]["_l_name"]
		html = self.get_html(link)
		soup = BeautifulSoup(html, features="html.parser")

		if self.results and self.fixture:
			self.get_results_fixture_league_aux(soup, 2)

		if self.results and not self.fixture:
			self.get_results_fixture_league_aux(soup, 0)

		if self.fixture and not self.results:
			self.get_results_fixture_league_aux(soup, 1)
		

	def get_league_table(self):
		league = self.league
		link = self.data[league]["_l_name_t"]
		html = self.get_html(link)
		soup = BeautifulSoup(html, features="html.parser")
		table = soup.find(True, {'class':'Le'})
		teams = table.find_all(True, {'class':['re']})
		
		print("R T P M W D L GF GA GD")
		for team in teams:
			tds = team.find_all("td")
			
			team_ = tds[1].text
			rank = tds[0].text
			temp = 0
			for c,chr in enumerate(rank):
				if chr.isdigit():
					temp = c
				else:
					break

			rank = rank[:temp+1]
			point = tds[-1].text
			mp = tds[2].text
			wins = tds[3].text
			draw = tds[4].text
			lost = tds[5].text
			goals1 = tds[6].text
			goals2 = tds[7].text
			goals3 = tds[8].text

			l = [rank, team_, point, mp, wins, draw, lost, goals1, goals2, goals3]

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

		