require 'open-uri'
require 'csv'

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

address_array = []
csv_options = { headers: :first_row, header_converters: :symbol }
CSV.foreach('./app/assets/data/london_postcodes_v3.csv', csv_options) do |row|
  address = "#{row[:pcd]}, London, UK"
  address_array << address
end

# make the first 5 users venue owners and create 5 venues each
# if geocoding fails (latitude == nil) delete the last venue and try with another address
User.first(5).each do |owner|
  owner.owner = true
  5.times do 
    Venue.create!(
      address: address_array.sample,
      name: Faker::Restaurant.name,
      description: Faker::Restaurant.description,
      user: owner
    )
    while Venue.last.latitude.nil?
      Venue.last.destroy
      Venue.create!(
      address: address_array.sample,
      name: Faker::Restaurant.name,
      description: Faker::Restaurant.description,
      user: owner
    )
    end
  end
  owner.save!
end

puts "venues created!"
puts "adding venue images..."
puts "wait for it..."

Venue.all.each do |venue|
  3.times do
    image_file = ['https://res.cloudinary.com/dhkhvto68/image/upload/v1622731507/samples/venue/Iconic-music-venues-Chicago-Theatre_imtjhe.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731507/samples/venue/Iconic-music-venues-Red-Rock-Colorado_ba8rvg.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731507/samples/venue/Iconic-music-venues-Krakow-salt-mines_hnonny.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731508/samples/venue/Iconic-music-venues-Royal-Albert-Hall_ududjw.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731507/samples/venue/best-music-venues-_patrickhayeslighting-Fonda-Theatre_znwsf0.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731508/samples/venue/best-music-venues-_mike__manos-Preservation-Hall-New-Orleans_z6g9s8.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731509/samples/venue/Best-music-venues-Bowery-Ballroom_ubd41l.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731508/samples/venue/Iconic-music-venues-Sydney-opera-house_wjw2lb.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731509/samples/venue/Best-music-venues-Cherry-Bar-Melbourne_gnpft9.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/w_1000,c_fill,ar_1:1,g_auto,r_max,bo_5px_solid_red,b_rgb:262c35/v1622300343/samples/venue/joshua-eckstein-lbRzSxHS2kU-unsplash_bd7tbv.jpg'].sample
    file = URI.open(image_file)
    venue.photos.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
    puts "still going..."
  end
end


puts "venue images added!"
puts "creating events..."

# create 1 event at each venue


count = 0

Venue.all.each do |venue|
  1.times do
    starting_price = rand(10.0..100.0).round(2)
    category = ["Hot", "Food", "Drink", "Show", "Music"].sample
    Event.create!(
      price_cents: starting_price,
      starting_price: starting_price,
      start_time: Faker::Time.between_dates(from: Date.today - 30, to: Date.today + 30, period: :evening),
      # start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      venue: venue,
      description: Faker::Restaurant.description,
      name: Faker::Kpop.iii_groups,
      num_tickets: (5..100).to_a.sample,
      duration: [30, 60, 90, 120].sample,
      min_price: rand((starting_price * 0.5)..(starting_price*0.9)).round(2),
      category: category,
      sku: "event_#{count}"
    )
  end
  count += 1
end

puts "events created!"
puts "adding events images..."
puts "wait for it..."

Event.all.each do |event|
  3.times do
    image_file = ['https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/beac4cdb16edb9d0cfd1db1e70cabb9b--concert-posters-music-posters_q3erlf.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/18001520-1b12-11e8-bd93-a3fa09536edb_ut2qxk.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/rolling-stones-steven-parker-canvas-print_afreoi.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/901b97c7af133ee9a63f35c13d946e0a_sexd4m.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/fleeceposters_vlkb3l.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/Blues_Concert_Band_Line-up_Flyer_-_Made_with_PosterMyWall_faz7ij.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/Joseph_waw57x.png','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/grease_fe5rk1.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/phantom_kslpay.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622298458/samples/venue/sebastiaan-stam-qWaWdIchPqE-unsplash_bu2ba4.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622729754/samples/venue/Theatre_claqtr.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622730554/samples/venue/lionking_nmnvpi.jpg'].sample
    file = URI.open(image_file)
    event.photos.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
  end
end

puts "added events images!"
puts "creating bookings..."

users = []
User.where(owner: false).each do |user|
  users << user
end

Event.all.each do |event|
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
        user: users.sample
      )
      counter -= num_attendees
    end
  end
end

puts 'bookings created!'
puts 'creating reviews...'

Booking.joins(:event).where('events.start_time < ?', Time.now).each do |booking|
  Review.create!(
    event_review: Faker::Restaurant.review,
    venue_rating: (1..5).to_a.sample,
    booking: booking
  )
end

puts 'reviews created!'
puts "all done! you're good to go"
