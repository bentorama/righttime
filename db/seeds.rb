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

# Create a user

def image_fetcher
    URI.open(Faker::Avatar.image)
end

main_user = User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: "password"
)

main_user.avatar.attach({
    io: image_fetcher,
    filename: "faker_image.jpg"
})

address_array = []
csv_options = { headers: :first_row, header_converters: :symbol }
CSV.foreach('./app/assets/data/london_postcodes_v4.csv', csv_options) do |row|
  address = "#{row[:pcd]}, London, UK"
  address_array << address
end  

puts "creating venue..."

puts "creating users..."

20.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password"
  )
  user.avatar.attach({
     io: image_fetcher,
     filename: "faker_image.jpg"
  })
end

puts "users created!"
puts "creating venues..."

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
    starting_price = rand(5.0...40.0).round(2)
    category = ["Hot", "Food", "Drink", "Show", "Music"].sample
    Event.create!(
      price_cents: starting_price * 100,
      current_price: starting_price,
      # starting_price in £
      starting_price: starting_price,
      start_time: Faker::Time.between_dates(from: Date.today, to: Date.today + 1, period: :night),
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
  puts "still going..."
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
      # total_price in cents / pence
      total_price = num_attendees * event.starting_price * 100
      Order.create!(
        num_attendees: num_attendees,
        amount_cents: total_price,
        event: event,
        user: users.sample
      )
      counter -= num_attendees
    end
  end
end

puts 'bookings created!'
puts 'creating reviews...'

# Order.joins(:event).where('events.start_time < ?', Time.now).each do |order|
Order.all.each do |order|
  Review.create!(
    event_review: Faker::Restaurant.review,
    venue_rating: (1..5).to_a.sample,
    order: order
  )
end

puts 'reviews created!'

puts 'creating real events....'

# Create a Venue
blues_kitchen = Venue.create!(
  address: "EC2A 3AR",
  name: "Blues Kitchen",
  description: "London's very own home of blues & rock n roll music. Serving authentic American Soul food and over 80 different Bourbon's",
  user: main_user
)

morito = Venue.create!(
  address: "E2 8JL",
  name: "Morito",
  description: "Moro and Morito chef proprietors, Sam & Sam Clark, have opened their third restaurant, located at 195 Hackney Road",
  user: main_user
  )

moon = Venue.create!(
  address: "N1 5LH",
  name: "Howl at the Moon",
  description: "Howl at the Moon is an independent neighbourhood pub in Hoxton that doesn't take itself too seriously, doing proper food and booze, seriously well.",
  user: main_user
  )

curzon = Venue.create!(
  address: "N1 6BU",
  name: "Curzon Hoxton",
  description: "Great cinema is meant to be shared. Give the gift of the Curzon experience and let your friends and family try everything the Curzon has to offer",
  user: main_user
)

puts "creating events..."

count = 0

blues_kitchen_event = Event.create!(
    price_cents: 3000,
    current_price: 30,
    starting_price: 30,
    start_time: "Tue 22 June 2021 22:30:00 UTC +00:00",
    venue: blues_kitchen,
    description: "Our world-famous house band hit the stage, filling the room with classic funk, soul & rock n roll. From Aretha to Stevie Wonder & Fleetwood Mac to The Rolling Stones. Hang out on the dance-floor with us indulging in cocktails, craft beers & bourbon.",
    name: "Shoreditch Got Soul",
    num_tickets: 10,
    duration: 180,
    min_price: 6,
    category: "Hot",
    sku: "event_#{count}"
  )

  count += 1

  3.times do 
    image_file = ['https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/beac4cdb16edb9d0cfd1db1e70cabb9b--concert-posters-music-posters_q3erlf.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/18001520-1b12-11e8-bd93-a3fa09536edb_ut2qxk.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/rolling-stones-steven-parker-canvas-print_afreoi.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/901b97c7af133ee9a63f35c13d946e0a_sexd4m.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/fleeceposters_vlkb3l.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/Blues_Concert_Band_Line-up_Flyer_-_Made_with_PosterMyWall_faz7ij.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/Joseph_waw57x.png','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/grease_fe5rk1.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/phantom_kslpay.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622298458/samples/venue/sebastiaan-stam-qWaWdIchPqE-unsplash_bu2ba4.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622729754/samples/venue/Theatre_claqtr.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622730554/samples/venue/lionking_nmnvpi.jpg'].sample
    file = URI.open(image_file)
    blues_kitchen_event.photos.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
  end

  morito_event = Event.create!(
    price_cents: 2000,
    current_price: 20,
    starting_price: 20,
    start_time: "Tue 22 June 2021 21:00:00 UTC +00:00",
    venue: morito,
    description: "Bright walls and a flamenco soundtrack make the highly animated dining room at Morito a fun atmosphere in which to enjoy ham and sherry. You’ll find classic tapas dishes such as Spanish omelette with chorizo and lamb shoulder casserole with oloroso on the menu too, but it’s the mouth-watering choice of ibérico hams that guests rave about.",
    name: "Tapas Set Menu",
    num_tickets: 10,
    duration: 60,
    min_price: 5,
    category: "Hot",
    sku: "event_#{count}"
  )

  count += 1

  3.times do 
    image_file = ['https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/beac4cdb16edb9d0cfd1db1e70cabb9b--concert-posters-music-posters_q3erlf.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/18001520-1b12-11e8-bd93-a3fa09536edb_ut2qxk.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/rolling-stones-steven-parker-canvas-print_afreoi.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/901b97c7af133ee9a63f35c13d946e0a_sexd4m.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/fleeceposters_vlkb3l.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/Blues_Concert_Band_Line-up_Flyer_-_Made_with_PosterMyWall_faz7ij.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/Joseph_waw57x.png','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/grease_fe5rk1.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/phantom_kslpay.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622298458/samples/venue/sebastiaan-stam-qWaWdIchPqE-unsplash_bu2ba4.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622729754/samples/venue/Theatre_claqtr.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622730554/samples/venue/lionking_nmnvpi.jpg'].sample
    file = URI.open(image_file)
    morito_event.photos.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
  end

  moon_event = Event.create!(
    price_cents: 100,
    current_price: 1,
    starting_price: 1,
    start_time: "Tue 22 June 2021 22:00:00 UTC +00:00",
    venue: moon,
    description: "If you’re a penny pincher, Howling' Happy Hour £2.50 drinks are gonna sort. you. out. There's also bottles of wine for £12, 2 cocktails for a tenner, or you can grab a few of their cocktail teapots for £15 while you play a few rounds of something old school on the SEGA megadrive..",
    name: "Howling Happy Hour",
    num_tickets: 10,
    duration: 60,
    min_price: 1,
    category: "Hot",
    sku: "event_#{count}"
  )

  count += 1

  3.times do 
    image_file = ['https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/beac4cdb16edb9d0cfd1db1e70cabb9b--concert-posters-music-posters_q3erlf.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/18001520-1b12-11e8-bd93-a3fa09536edb_ut2qxk.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/rolling-stones-steven-parker-canvas-print_afreoi.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/901b97c7af133ee9a63f35c13d946e0a_sexd4m.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/fleeceposters_vlkb3l.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/Blues_Concert_Band_Line-up_Flyer_-_Made_with_PosterMyWall_faz7ij.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/Joseph_waw57x.png','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/grease_fe5rk1.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/phantom_kslpay.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622298458/samples/venue/sebastiaan-stam-qWaWdIchPqE-unsplash_bu2ba4.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622729754/samples/venue/Theatre_claqtr.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622730554/samples/venue/lionking_nmnvpi.jpg'].sample
    file = URI.open(image_file)
    moon_event.photos.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
  end

curzon_event = Event.create!(
    price_cents: 200,
    current_price: 20,
    starting_price: 20,
    start_time: "Tue 22 June 2021 22:00:00 UTC +00:00",
    venue: curzon,
    description: "In the Heights centers on a variety of characters living in the neighborhood of Washington Heights, on the northern tip of Manhattan. At the center of the show is Usnavi, a bodega owner who looks after the aging Cuban lady next door, pines for the gorgeous girl working in the neighboring beauty salon and dreams of winning the lottery and escaping to the shores of his native Dominican Republic. Meanwhile, Nina, a childhood friend of Usnavi's, has returned to the neighborhood from her first year at college with surprising news for her parents, who have spent their life savings on building a better life for their daughter. Ultimately, Usnavi and the residents of the close-knit neighborhood get a dose of what it means to be home.",
    name: "In the Heights",
    num_tickets: 10,
    duration: 120,
    min_price: 10,
    category: "Hot",
    sku: "event_#{count}"
  )

  count += 1

  3.times do 
    image_file = ['https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/beac4cdb16edb9d0cfd1db1e70cabb9b--concert-posters-music-posters_q3erlf.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/18001520-1b12-11e8-bd93-a3fa09536edb_ut2qxk.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/rolling-stones-steven-parker-canvas-print_afreoi.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731307/samples/venue/901b97c7af133ee9a63f35c13d946e0a_sexd4m.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/fleeceposters_vlkb3l.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622731308/samples/venue/Blues_Concert_Band_Line-up_Flyer_-_Made_with_PosterMyWall_faz7ij.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/Joseph_waw57x.png','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/grease_fe5rk1.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622730667/samples/venue/phantom_kslpay.jpg','https://res.cloudinary.com/dhkhvto68/image/upload/v1622298458/samples/venue/sebastiaan-stam-qWaWdIchPqE-unsplash_bu2ba4.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622729754/samples/venue/Theatre_claqtr.jpg', 'https://res.cloudinary.com/dhkhvto68/image/upload/v1622730554/samples/venue/lionking_nmnvpi.jpg'].sample
    file = URI.open(image_file)
    curzon_event.photos.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
  end

puts "creating bookings..."

  blues_order = Order.create!(
    num_attendees: 2,
    amount_cents: 6000,
    event: blues_kitchen_event,
    user: main_user
  )

  morito_order = Order.create!(
    num_attendees: 2,
    amount_cents: 4000,
    event: morito_event,
    user: main_user
  )

  moon_order = Order.create!(
    num_attendees: 2,
    amount_cents: 200,
    event: moon_event,
    user: main_user
  )

  curzon_order = Order.create!(
    num_attendees: 2,
    amount_cents: 4000,
    event: curzon_event,
    user: main_user
  )
  
puts "creating reviews..."

  Review.create!(
    event_review: Faker::Restaurant.review,
    venue_rating: (1..5).to_a.sample,
    order: blues_order
  )

  Review.create!(
    event_review: Faker::Restaurant.review,
    venue_rating: (1..5).to_a.sample,
    order: morito_order
  )

  Review.create!(
    event_review: Faker::Restaurant.review,
    venue_rating: (1..5).to_a.sample,
    order: moon_order
  )

  Review.create!(
    event_review: Faker::Restaurant.review,
    venue_rating: (1..5).to_a.sample,
    order: curzon_order
  )


puts "all done! you're good to go"