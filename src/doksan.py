import argparse
import json

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

	# def get_data(self):
	# 	with open('variables.json') as json_file:
	# 		data = json.load(json_file)

	# 		return data

	def get_results_fixture_team(self):
		# Get results and fixture for the team

	def get_results_fixture_league(self):
		# Get results and fixture for the league

	def get_league_table():
		# Get league table
					


def main(args):
	league = args.league or "en"
	team = args.team
	results = args.results
	fixture = args.fixture
	print(args)

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

		