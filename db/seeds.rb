# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'securerandom'

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

20.times do
	user = User.new
	user.email = Faker::Internet.email
	random_password = Faker::Internet.password(6, 8)
	user.password = random_password
	user.password_confirmation = random_password	
	user.firstname = Faker::Name.first_name
	user.lastname = Faker::Name.last_name
	user.property_id = 1 + rand(Property.count - 1)
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
