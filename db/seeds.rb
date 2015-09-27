# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Item.create(name: 'Soda', description: 'Bubbly, delicious!', price: 1, category_id: 2)
Item.create(name: 'Lemonade', description: 'Refreshing', price: 2)
Item.create(name: 'Collard Greens', description: 'Good and Good for you!', price: 1)
Item.create(name: 'Burger', description: "1/4 Angus 'beef'", price: 2, category_id: 1)
Item.create(name: 'Fries', description: 'No trans fat', price: 4, category_id: 3)
Item.create(name: 'Steak', description: 'Ribeye 16 oz', price: 5, category_id: 1)
Item.create(name: 'Onion Rings', description: 'Deep fried. Deep pleasure', price: 6, category_id: 3)
Item.create(name: 'Tater Tots', description: 'Not just for kids', price: 7, category_id: 3)
Category.create(name: 'Meals')
Category.create(name: 'Drinks')
Category.create(name: 'Sides')
User.create(email: "admin@example.com", password: "password", role: 3)
User.create(email: "david@example.com", password: "password")
