import argparse
import json
from bs4 import BeautifulSoup
import urllib.request

class Doksan(object):
	"""docstring for Doksan"""
	def __init__(self, league, team, results, fixture):
		super(Doksan, self).__init__()
		self.league = league
		self.team = team
		self.results = results
		self.fixture = fixture

		if self.team:
			self.get_results_fixture_team()
		else:
			if self.results or self.fixture:
				self.get_results_fixture_league()
			else:
				self.get_league_table()

	def get_data(self):
		with open('variables.json') as json_file:
			data = json.load(json_file)

			return data


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
		data = self.get_data()

		link = data[league][team]
		html = self.get_html(link)
		soup = BeautifulSoup(html, features="html.parser")
		
		if self.results:
			self.get_results_fixture_team_aux(soup, True)

		if self.fixture:
			self.get_results_fixture_team_aux(soup, False)


	def get_results_fixture_league(self):
		# Get results and fixture for the league
		pass

	def get_league_table(self):
		# Get league table
		pass
					


def main(args):
	league = args.league or "tr"
	team = args.team
	results = args.results
	fixture = args.fixture

	doksan = Doksan(league, team, results, fixture)
	doksan.get_data()


if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument("-l", "--league", help="league selection")
	parser.add_argument("-t", "--team", help="team selection")
	parser.add_argument("-r", "--results", action="store_true", help="show results")
	parser.add_argument("-f", "--fixture", action="store_true", help="show fixture")
	args = parser.parse_args()
	main(args)

		