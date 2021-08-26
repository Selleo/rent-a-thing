# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'securerandom'

if Rails.env.development?
  # ===============
  # ==== USERS ====
  # ===============

  AdminUser.count.zero? &&
    AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  # ===============
  # ==== ITEMS ====
  # ===============

  category = Category.where(name: 'Rowery').first_or_create

  Item.count.zero? && [
    [
      'REVOLT E+',
      'Od dziurawego asfaltu, po szutrowe, gruntowe i mieszane wyprawy w terenie – ten wszechstronny rower elektryczny z barankiem daje ci moc, by jechać dalej i szybciej na każdej trasie, jaką sobie wymarzysz.',
      'https://www.giant-bicycles.com/pl/revolt-eplus-2022'
    ],
    [
      'TCR Advanced',
      'Szosowe rowery, które wygrywają, charakteryzują się odpowiednią równowagą lekkości, sztywności i dobrych właściwości jezdnych na drodze. Nowy TCR Advanced spełnia wszystkie te wymogi i wraz z uaktualnionym profilem rur aero jest odpowiednim wyborem dla lubiących rywalizację kolarzy.',
      'https://www.giant-bicycles.com/pl/bikes-tcr-advanced'
    ],
    [
      'Anytour E+',
      'Pokonywanie długich dystansów jest zawsze lepsze na rowerze. Zobacz zabytki, poznaj otoczenie i oddychaj świeżym powietrzem na łonie natury dzięki temu wszechstronnemu rowerowi elektrycznemu. Nowy AnyTour E + ułatwia pokonywanie płaskich lub wyboistych dróg.',
      'https://www.giant-bicycles.com/pl/bikes-anytour-eplus'
    ],
    [
      'FATHOM E+ JUNIOR',
      'Wszystko, czego potrzebuje młody rowerzysta, to wspinać się wyżej, jeździć dłużej i mieć więcej zabawy na szlaku. Ten całkowicie nowy E-bike wywoła uśmiech na twarzy każdego dziecka i sprawi, że rodzinne przygody będą przyjemniejsze niż kiedykolwiek.',
      'https://www.giant-bicycles.com/pl/fathom-eplus-junior'
    ],
    [
      'STP 24 FS',
      'Zaprojektowany z myślą o młodych rowerzystach chcących poszukać przygód na szlaku lub w parku rowerowym. Ten całkowicie nowy, wszechstronny model został zbudowany na lekkiej, super wytrzymałej ramie aluminiowej i wyposażony w szybkie koła 24-calowe.',
      'https://www.giant-bicycles.com/pl/stp-24-fs'
    ],
    [
      'TRANCE X ADVANCED PRO 29',
      'Więcej skoku, więcej frajdy. Od trudnych tras enduro po misje wśród bezdroży na stromych i wyboistych singlach, nowy kompozytowy 29er stworzono na bazie platformy Trance 29 z podrasowanym zawieszeniem i regulowaną geometrią ramy.',
      'https://www.giant-bicycles.com/pl/bikes-trance-x-advanced-pro-29'
    ],
  ].each do |name, description, _website|
    Item.create(name: name, description: description, archived: false, category: category, price_per_day: [123, 323423, 1234, 3214].sample)
  end

  # ==================
  # ==== BOOKINGS ====
  # ==================

  if Customer.count.zero?
    5.times do
      first_name, last_name = FFaker::NamePL.full_name.split

      Customer.create(
        full_name: "#{first_name} #{last_name}",
        email: "#{first_name}#{rand(100)}@#{FFaker::Internet.domain_name}",
        phone: FFaker::PhoneNumber.short_phone_number
      ).tap do |customer|

        (0..5).to_a.sample.times do
          starts_on = (-10..20).to_a.sample.days.from_now
          ends_on = starts_on + rand(10).days

          booking = customer.bookings.create(starts_on: starts_on, ends_on: ends_on, uuid:SecureRandom.uuid)
          booking.items << Item.order('RANDOM()').limit(rand(3))
          booking.save!
        end
      end
    end
  end
end
