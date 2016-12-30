# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'securerandom'
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
	puts p.name
	p.access_code = SecureRandom.hex(3)
	p.address = a
	p.save

end