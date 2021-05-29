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

puts "users created!"

puts "creating venues..."

@venue_owners = User.first(5)

@venue_owners.each do |owner|
  owner.owner = true
  5.times do 
    Venue.create!(
      address: Faker::Address.street_address,
      name: Faker::Restaurant.name,
      description: Faker::Restaurant.description,
      user: owner
    )
  end
  owner.save!
end

puts "venues created!"

puts "creating events..."

@venues = Venue.all

@venues.each do |venue|
  5.times do
    starting_price = rand(10.0..100.0).round(2)
    Event.create!(
      starting_price: starting_price,
      start_time: Faker::Time.forward(days: 5,  period: :evening, format: :long),
      venue: venue,
      description: Faker::Restaurant.description,
      name: Faker::Kpop.iii_groups,
      num_tickets: (1..100).to_a.sample,
      duration: [30, 60, 90, 120].sample,
      min_price: rand((starting_price * 0.5)..(starting_price*0.9)).round(2),
    )
  end
end

puts "events created!"
