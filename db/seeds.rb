# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "cleaning database..."
User.destroy_all

puts "creating users..."

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password"
  )
end

puts "users created"

puts "creating venues..."

p @venue_owners = User.first(5)

@venue_owners.each do |owner|
  5.times do 
    Venue.create!(
      address: Faker::Address.street_address,
      name: Faker::Restaurant.name,
      description: Faker::Restaurant.description,
      user: owner
    )
end

end
