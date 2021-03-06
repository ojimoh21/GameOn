user_url = "https://res.cloudinary.com/diojcd3j5/image/upload/"
male_user_filenames = ["v1637677042/photo-1583864697784-a0efc8379f70_foef7f.jpg",
                       "v1637676571/photo-1522529599102-193c0d76b5b6_coeah8.jpg",
                       "v1637676501/photo-1506748686214-e9df14d4d9d0_ati8oj.jpg",
                       "v1637676460/photo-1599566150163-29194dcaad36_elvwan.jpg",
                       "v1637676443/photo-1581456495146-65a71b2c8e52_qlyjuv.jpg",
                       "v1637676763/photo-1568602471122-7832951cc4c5_v8tsqx.jpg"]
female_user_filenames = ["v1637676552/photo-1532708059644-5590ed51ce4c_zwcdtk.jpg",
                         "v1637676470/photo-1554151228-14d9def656e4_nzzamv.jpg",
                         "v1637676403/photo-1523824921871-d6f1a15151f1_ehgr8l.jpg",
                         "v1637676428/photo-1589156280159-27698a70f29e_cvwyuq.jpg",
                         "v1637676389/photo-1637637499413-e9bc4131a400_uz8ldy.jpg"]

demo_character_filename = "v1638520404/avatar_zh6dog.jpg"

games_url = 'https://api.boardgameatlas.com/api/search?list_id=5yCPKRYJoF&client_id=OShMmavExz'
games_serialized = URI.open(games_url).read
games = JSON.parse(games_serialized)["games"]

addresses = [
  "Hoxton, Hackney, London, Greater London, England, United Kingdom",
  "138 Kingsland Road, Newham, London, E13 9NU, United Kingdom",
  "Circus Street, Oxford, OX4 1JR, United Kingdom",
  "Hollywood, Florida, United States",
  "Tottenham Street, Camden, London, W1T 2AW, United Kingdom",
  "Wembley, Greater London, England, United Kingdom"
]

user_counter = 0

puts "Seeding started"
Chatroom.destroy_all
Guest.destroy_all
Team.destroy_all
PartyGame.destroy_all
PartySession.destroy_all
Game.destroy_all
User.destroy_all

puts "Creating 13 users"

# male users
6.times do
  user = User.new
  user.first_name = Faker::Name.male_first_name
  user.last_name = Faker::Name.last_name
  user.email = "#{user.first_name}_#{user.last_name}@gmail.com"
  user.password = "123456"
  user_file = URI.open((user_url + male_user_filenames[user_counter]).to_s)
  user.photo.attach(io: user_file, filename: (male_user_filenames[user_counter]).to_s, content_type: 'image/jpg')
  user.save!
  user_counter += 1
  puts "User with id - #{user.id} created"
end

user_counter = 0
# female users
5.times do
  user = User.new
  user.first_name = Faker::Name.female_first_name
  user.last_name = Faker::Name.last_name
  user.email = "#{user.first_name}_#{user.last_name}@gmail.com"
  user.password = "123456"
  user_file = URI.open((user_url + female_user_filenames[user_counter]).to_s)
  user.photo.attach(io: user_file, filename: (female_user_filenames[user_counter]).to_s, content_type: 'image/jpg')
  user.save!
  user_counter += 1
  puts "User with id - #{user.id} created"
end

# Without profile image and support character
user = User.new
user.first_name = "Alyona"
user.last_name = "Bordukova"
user.email = "alyona_bordukova@gmail.com"
user.password = "123456"
user.save!

# 5 games added to support character
games[5..9].each do |game|
  user_game = Game.new
  user_game.title = game["name"]
  user_game.description = game["description_preview"]
  user_game.duration = (game["min_playtime"] + game["max_playtime"]).fdiv(2).round
  user_game.suggested_numplayers = (game["min_players"] + game["max_players"]).fdiv(2).round
  user_game_file = URI.open(game["image_url"])
  user_game.photo.attach(io: user_game_file, filename: game["image_url"], content_type: 'image/jpg')
  user_game.user = user
  user_game.save!
end
puts "User with id - #{user.id} created and games added"

# previous, ongoing, upcoming for support character

puts "Creating Party Sessions for Demo character and supporting character"

puts "Creating Ongoing Party for Alyona "
party = PartySession.new
party.title = "Demo After-Party"
party.description = "We made it to the end guys!! Anyone up for a friendly get-together?"
party.start_date = DateTime.now
party.end_date = DateTime.now + 2
party.address = addresses[4]
party.user = user
party.save!
guest = Guest.new
guest.party_session = party
guest.user = user
guest.confirm_arrival = true
guest.confirm_availability = true
guest.save!
chatroom = Chatroom.new
chatroom.party_session = party
chatroom.name = party.title
chatroom.save!

puts "Creating Previous Party for Alyona "
party = PartySession.new
party.title = "Gladiator battle"
party.description = "Dare to step in the Colosseum"
party.start_date = DateTime.now - 6
party.end_date = DateTime.now - 5
party.address = addresses[3]
party.user = user
party.save!
guest = Guest.new
guest.party_session = party
guest.user = user
guest.confirm_arrival = true
guest.confirm_availability = true
guest.save!
chatroom = Chatroom.new
chatroom.party_session = party
chatroom.name = party.title
chatroom.save!

puts "Creating Upcoming Party for Alyona "
party = PartySession.new
party.title = "Redemption Arena"
party.description = "Time to make history, who is the greatest of them all?"
party.start_date = DateTime.now + 5
party.end_date = DateTime.now + 6
party.address = addresses[5]
party.user = user
party.save!
guest = Guest.new
guest.party_session = party
guest.user = user
guest.confirm_arrival = true
guest.confirm_availability = true
guest.save!
chatroom = Chatroom.new
chatroom.party_session = party
chatroom.name = party.title
chatroom.save!

# demo character
user = User.new
user.first_name = "Gulce"
user.last_name = "Sakallioglu"
user.email = "gulcesakallioglu@gmail.com"
user.password = "123456"
user_file = URI.open((user_url + demo_character_filename).to_s)
user.photo.attach(io: user_file, filename: demo_character_filename.to_s, content_type: 'image/jpg')
user.save!

# Add Gulce as guest to Alyona's upcoming party
puts "Add Gulce as a guest for party - #{party.title}"

guest = Guest.new
guest.party_session = party
guest.user = user
guest.confirm_availability = true
guest.save!

# 5 games added to demo user
games[0..4].each do |game|
  user_game = Game.new
  user_game.title = game["name"]
  user_game.description = game["description_preview"]
  user_game.duration = (game["min_playtime"] + game["max_playtime"]).fdiv(2).round
  user_game.suggested_numplayers = (game["min_players"] + game["max_players"]).fdiv(2).round
  user_game_file = URI.open(game["image_url"])
  user_game.photo.attach(io: user_game_file, filename: game["image_url"], content_type: 'image/jpg')
  user_game.user = user
  user_game.save!
end
puts "User with id - #{user.id} created and games added"

# previous, ongoing, upcoming for demo character
puts "Creating Previous Party for Jae-dong "
party = PartySession.new
party.title = "Battle Galactica"
party.description = "Sci-fi party loading..."
party.start_date = DateTime.now - 3
party.end_date = DateTime.now - 2
party.address = addresses[0]
party.user = user
party.save!
guest = Guest.new
guest.party_session = party
guest.user = user
guest.confirm_arrival = true
guest.confirm_availability = true
guest.save!
chatroom = Chatroom.new
chatroom.party_session = party
chatroom.name = party.title
chatroom.save!

puts "Creating Ongoing Party for Gulce "
party = PartySession.new
party.title = "Family Glee"
party.description = "Hey family, let's have a get together today"
party.start_date = DateTime.now
party.end_date = DateTime.now + 1
party.address = addresses[1]
party.user = user
party.save!
guest = Guest.new
guest.party_session = party
guest.user = user
guest.confirm_arrival = true
guest.confirm_availability = true
guest.save!

# Add Alyona as a guest
puts "Add Alyona as a guest for party - #{party.title}"
guest = Guest.new
guest.party_session = party
guest.user = User.find_by(email: "alyona_bordukova@gmail.com")
guest.confirm_arrival = true
guest.confirm_availability = true
guest.save!

puts "Create guests for party - #{party.title}"
guest_count = 0
3.times do
  guest = Guest.new
  guest.party_session = party
  guest.user = User.all[guest_count]
  guest.confirm_arrival = true
  guest.confirm_availability = true
  guest.save!
  guest_count += 1
end
puts "Create a game for party - #{party.title}"
game = PartyGame.new
game.game = user.games.first
game.party_session = party
game.save!

chatroom = Chatroom.new
chatroom.party_session = party
chatroom.name = party.title
chatroom.save!

puts "Creating Upcoming Party for Gulce "
party = PartySession.new
party.title = "UNO momento"
party.description = "Ready to see the student become the master? I'm ready for my title!!"
party.start_date = DateTime.now + 3
party.end_date = DateTime.now + 5
party.address = addresses[2]
party.user = user
party.save!
guest = Guest.new
guest.party_session = party
guest.user = user
guest.confirm_arrival = true
guest.confirm_availability = true
guest.save!
chatroom = Chatroom.new
chatroom.name = party.title
chatroom.party_session = party
chatroom.save!

puts "Creating Ola, Alex and Tomas accounts"
# Ola
user = User.new
user.first_name = "Muinat"
user.last_name = "Jimoh"
user.email = "ojimoh210@gmail.com"
user.password = "123456"
user_file = URI.open((user_url + "v1638522364/ola_qkwvi3.jpg").to_s)
user.photo.attach(io: user_file, filename: "v1638522364/ola_qkwvi3.jpg".to_s, content_type: 'image/jpg')
user.save!

# Tomas
user = User.new
user.first_name = "Tomas"
user.last_name = "Truyols"
user.email = "tomast25@hotmail.com"
user.password = "123456"
user_file = URI.open((user_url + "v1638522355/tomas_zpoz0z.jpg").to_s)
user.photo.attach(io: user_file, filename: "v1638522355/tomas_zpoz0z.jpg".to_s, content_type: 'image/jpg')
user.save!

# Alex
user = User.new
user.first_name = "Alexandra"
user.last_name = "Okoro"
user.email = "alex.nnenna.okoro@gmail.com"
user.password = "123456"
user_file = URI.open((user_url + "v1638522347/alex_uzrjhy.jpg").to_s)
user.photo.attach(io: user_file, filename: "v1638522347/alex_uzrjhy.jpg".to_s, content_type: 'image/jpg')
user.save!

puts "Users created"
puts "Seeding done"
