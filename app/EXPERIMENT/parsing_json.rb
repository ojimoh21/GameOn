# require 'json'
# require 'open-uri'

# url = 'https://api.boardgameatlas.com/api/search?list_id=5yCPKRYJoF&client_id=OShMmavExz'
# games_list = URI.open(url).read
# games = JSON.parse(games_list)['games']

# # puts games

# games.each do |game|
#   puts "#{game['name']}"
#   puts "#{game['description']}"
#   puts "#{game['min_players']} - #{game['max_players']}"
# end
