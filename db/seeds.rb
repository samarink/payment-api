# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Transaction.destroy_all

NUM_USERS = 1
NUM_EARNINGS = 100
NUM_SPENDINGS = 1000

NUM_USERS.times { |i| User.create(name: "User #{i}") }

User.all.each do |user|
  NUM_EARNINGS.times do |i|
    Transaction.create(user: user, date: rand(1.years).seconds.ago , amount: rand(100..1000), name: "Earning #{i}")
  end

  NUM_SPENDINGS.times do |i|
    Transaction.create(user: user, date: rand(1.years).seconds.ago, amount: rand(-100..-1), name: "Spending #{i}")
  end
end
