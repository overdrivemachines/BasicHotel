# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'securerandom'

# Random Records: https://hashrocket.com/blog/posts/rails-quick-tips-random-records

User.destroy_all
Property.destroy_all

user = User.new
user.email = "a@a.com"
random_password = "2private"
user.password = random_password
user.password_confirmation = random_password
user.username = "admin"
user.firstname = "Dipen"
user.lastname = "Chauhan"
user.skip_confirmation!
user.save(validate: false) # Required for first user
user.username = "admin"
user.save
puts "Created User #{user.firstname} #{user.lastname} #{user.email}:#{user.password}"

# Create 5 properties
5.times do
	a = Address.new
	a.address1 = Faker::Address.street_address
	a.city = Faker::Address.city
	a.state = Faker::Address.state
	a.zip = Faker::Address.zip
	a.country = Faker::Address.country
	a.phone = Faker::PhoneNumber.cell_phone
	a.save

	p = Property.new
	p.name = Faker::Company.name + " Hotel"
	p.access_code = SecureRandom.hex(3)
	p.address = a
	p.save
	puts "Created Property #{p.name}: #{p.access_code}"
end

# Create 20 users and assign them properties randomly
20.times do
	user = User.new
	user.email = Faker::Internet.email
	random_password = Faker::Internet.password(6, 8)
	user.password = random_password
	user.password_confirmation = random_password	
	user.firstname = Faker::Name.first_name
	user.lastname = Faker::Name.last_name
	# user.property_id = 1 + rand(Property.count - 1)
	user.property_id = Property.pluck(:id).shuffle[0]
	user.skip_confirmation!
	user.save!
	puts "Created User #{user.firstname} #{user.lastname} #{user.email}:#{user.password} #{user.property.name}"
end

user = User.new
user.email = "b@b.com"
random_password = "2private"
user.password = random_password
user.password_confirmation = random_password
user.username = "admin2"
user.firstname = "Dipen"
user.lastname = "Chauhan"
user.property_id = Property.first.id
user.skip_confirmation!
user.save!
user.username = "admin2"
user.save
puts "Created User #{user.firstname} #{user.lastname} #{user.email}:#{user.password}"

# Create 20 Room Types and assign them properties randomly
20.times do
	rt = RoomType.new
	rt.name = Faker::Beer.name
	rt.code = rt.name[0, 2] + SecureRandom.hex(1).to_s
	rt.description = Faker::Beer.style
	rt.property_id = Property.pluck(:id).shuffle[0]
	rt.save
	puts "Created RoomType #{rt.code} #{rt.name} for Property #{rt.property.name}"
end

# Create 100 Rooms and assign them to room types randomly
200.times do
	room = Room.new
	room.room_number = Faker::Number.number(3)
	room.location = Faker::Address.time_zone
	room.vacant = true
	room.clean = true
	room.inventory = true
	room.room_type_id = RoomType.pluck(:id).shuffle[0]
	room.save
	puts "Created Room #{room.room_number}:#{room.room_type.code}:#{room.room_type.property.name}"
end