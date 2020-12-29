# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ozark=User.create(name: 'Ozark Recreation Association', address: "6624 Lock and Damn Rd Ozark, Ar 72949", phone_number: "4796672908")
player_one=Player.create(name: "Tripp", handicap: 7, user_id: 1)
player_two=Player.create(name: "Eric", handicap: 10, user_id: 1)

tournament_one=Tournament.create(name:"Scramble", entry_fee: 20, user_id: 1, players_on_team: 2, date: "2021/01/01")
team=Team.create(divison: "White and Blue", tournament_id: 1)
players_teams_two=PlayersTeam.create(player_id: 1, team_id: 1)
players_teams_three=PlayersTeam.create(player_id: 2, team_id: 1)




tournament_two=Tournament.create(name:"Solo", entry_fee: 35, user_id: 1, players_on_team: 1, date: "2021/02/02" )
team=Team.create(divison: "White and Blue", tournament_id: 2)
players_teams=PlayersTeam.create(player_id: 1, team_id: 2)
team_two=Team.create(divison: "White and Blue", tournament_id: 2)
players_teams_solo=PlayersTeam.create(player_id: 2, team_id: 3)



