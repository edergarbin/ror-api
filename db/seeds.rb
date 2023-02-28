puts "\nStarting seeding in the database"

# Users
puts "\nCreating users:"
5.times do
  name = Faker::Name.name
  email = Faker::Internet.email
  password = Faker::Internet.password
  User.create!(
    "name": name,
    "email": email ,
    "password": password
  )
  puts "[ Nome: #{name} | E-mail: #{email} | Senha: #{password} ]"
end
puts ' done.'

# Products
print "\nCreating products "
10.times do
  Product.create!(
    "name": Faker::Name.name,
    "quantity": rand(10..100),
    "price_in_cents": rand(100..10000)
  )
  print '.'
end
print ' done.'

# Sales
print "\nCreating sales:"
5.times do |index|
  Sale.create!(
    "quantity": rand(1..5),
    "total_in_cents": rand(1..10000),
    "product_id": Product.find(index+1).id,
    "user_id": User.find(index+1).id
  )
  print '.'
end
print ' done.'

puts "\nDone.\n\n"