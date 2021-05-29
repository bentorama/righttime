require "open-uri"

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

20.times do
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
  file = URI.open('https://res.cloudinary.com/dhkhvto68/image/upload/w_1000,c_fill,ar_1:1,g_auto,r_max,bo_5px_solid_red,b_rgb:262c35/v1622300343/samples/venue/joshua-eckstein-lbRzSxHS2kU-unsplash_bd7tbv.jpg')
  venue.photos.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
end

@venues.each do |venue|
  1.times do
    starting_price = rand(10.0..100.0).round(2)
    Event.create!(
      starting_price: starting_price,
      start_time: Faker::Time.between_dates(from: Date.today - 30, to: Date.today + 30, period: :evening),
      # start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      venue: venue,
      description: Faker::Restaurant.description,
      name: Faker::Kpop.iii_groups,
      num_tickets: (5..100).to_a.sample,
      duration: [30, 60, 90, 120].sample,
      min_price: rand((starting_price * 0.5)..(starting_price*0.9)).round(2)
    )
  end
end

puts "events created!"
puts "creating bookings..."
@users = []
User.where(owner: false).each do |user|
  @users << user
end

@events = Event.all

@events.each do |event|
  file = URI.open('https://res.cloudinary.com/dhkhvto68/image/upload/w_1000,ar_1:1,c_fill,g_auto,e_art:hokusai/v1622298458/samples/venue/sebastiaan-stam-qWaWdIchPqE-unsplash_bu2ba4.jpg')
  event.photos.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
end

@events.each do |event|
  counter = event.num_tickets
  5.times do
    if counter > 0
      max_attendees = [counter, 5].min
      num_attendees = rand(1..max_attendees)
      total_cost = num_attendees * event.starting_price
      Booking.create!(
        num_attendees: num_attendees,
        total_cost: total_cost,
        event: event,
        user: @users.sample
      )
      counter -= num_attendees
    end
  end
end

puts 'bookings created!'
puts 'creating reviews...'
past_bookings = []
Booking.all.each do |booking|
  past_bookings << booking if booking.event.start_time < Time.zone.now
end
past_bookings.each do |booking|
  Review.create!(
    event_review: Faker::Restaurant.review,
    venue_rating: (1..5).to_a.sample,
    booking: booking
  )
end

puts 'reviews created!'
