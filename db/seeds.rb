# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Item.create(name: 'Soda', description: 'Teh bubbles', price: 100, avatar: File.open("app/assets/images/wrench1.png"))
Item.create(name: 'Pop', description: 'Teh', price: 200)
Item.create(name: 'Colla', description: 'Supa fly', price: 100)
Item.create(name: 'Burger', description: 'For a rabbi', price: 200)
Item.create(name: 'Fries', description: 'Fo Free', price: 400)
Item.create(name: 'Steak', description: 'Turf', price: 500)
Item.create(name: 'Ice Cream', description: 'Mooooooooo', price: 600)
Item.create(name: 'Potatoes', description: 'Potahto', price: 700)
