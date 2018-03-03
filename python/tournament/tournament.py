class Team():
    def __init__(self, name):
        self.name = name
        self.wins = 0
        self.draws = 0
        self.losses = 0

    @property
    def points(self):
        return self.wins * 3 + self.draws

    @property
    def matches_played(self):
        return self.wins + self.draws + self.losses

    def set_win(self):
        self.wins += 1

    def set_loss(self):
        self.losses += 1

    def set_draw(self):
        self.draws += 1

    def __repr__(self):
        return (f'{self.name.ljust(30)} '
                f'|  {self.matches_played} '
                f'|  {self.wins} '
                f'|  {self.draws} '
                f'|  {self.losses} '
                f'|  {self.points}')


def tally(tournament_results):
    results = [s.split(';') for s in tournament_results.split('\n')]
    teams_names = set(name for teams in results for name in teams[:2])
    teams = {name: Team(name) for name in teams_names}

    try:
        for team1, team2, result in results:
            if result == 'win':
                set_score(teams[team1], teams[team2])
            elif result == 'loss':
                set_score(teams[team2], teams[team1])
            else:
                set_draw(teams[team1], teams[team2])
    except ValueError:
        return format_result({})

    return format_result(teams)


def set_score(winner, loser):
    winner.set_win()
    loser.set_loss()


def set_draw(team1, team2):
    team1.set_draw()
    team2.set_draw()


def format_result(teams):
    # sort by name
    teams = sorted(teams.values(), key=lambda team: team.name)
    # sort by score
    teams = sorted(teams,
                   key=lambda team: team.points,
                   reverse=True)
    header = 'Team                           | MP |  W |  D |  L |  P'
    result = [repr(team) for team in teams]
    return '\n'.join([header, *result])
