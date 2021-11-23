user_url = "https://res.cloudinary.com/diojcd3j5/image/upload/"
male_user_filenames = ["v1637677042/photo-1583864697784-a0efc8379f70_foef7f.jpg",
                       "v1637676571/photo-1522529599102-193c0d76b5b6_coeah8.jpg",
                       "v1637676501/photo-1506748686214-e9df14d4d9d0_ati8oj.jpg",
                       "v1637676460/photo-1599566150163-29194dcaad36_elvwan.jpg",
                       "v1637676443/photo-1581456495146-65a71b2c8e52_qlyjuv.jpg",
                       "v1637676763/photo-1568602471122-7832951cc4c5_v8tsqx.jpg"]
female_user_filenames = ["v1637676552/photo-1532708059644-5590ed51ce4c_zwcdtk.jpg",
                         "v1637676522/photo-1544005313-94ddf0286df2_jusydn.jpg",
                         "v1637676470/photo-1554151228-14d9def656e4_nzzamv.jpg",
                         "v1637676403/photo-1523824921871-d6f1a15151f1_ehgr8l.jpg",
                         "v1637676428/photo-1589156280159-27698a70f29e_cvwyuq.jpg",
                         "v1637676389/photo-1637637499413-e9bc4131a400_uz8ldy.jpg"]

demo_character_filename = "v1637677822/xy8hmqmnpjm1bgnynmn7_d8wbio.jpg"

user_counter = 0

puts "Seeding started"
User.destroy_all

puts "Creating 13 users"

# male users
6.times do
  user = User.new
  user.first_name = Faker::Name.male_first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user_file = URI.open((user_url + male_user_filenames[user_counter]).to_s)
  user.photo.attach(io: user_file, filename: (male_user_filenames[user_counter]).to_s, content_type: 'image/jpg')
  user.save!
  user_counter += 1
end

user_counter = 0
# female users
6.times do
  user = User.new
  user.first_name = Faker::Name.female_first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user_file = URI.open((user_url + female_user_filenames[user_counter]).to_s)
  user.photo.attach(io: user_file, filename: (female_user_filenames[user_counter]).to_s, content_type: 'image/jpg')
  user.save!
  user_counter += 1
end

# demo character
user = User.new
user.first_name = "Lee"
user.last_name = "Jae-dong"
user.email = "jaedong2016@gmail.com"
user_file = URI.open((user_url + demo_character_filename).to_s)
user.photo.attach(io: user_file, filename: demo_character_filename.to_s, content_type: 'image/jpg')
user.save!

puts "Users created"
puts "Seeding done"
