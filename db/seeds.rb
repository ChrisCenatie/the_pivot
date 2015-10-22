Farmer.create(name: "Willowcroft Farm", active: true, image_url: "http://www.oldhousedreams.com/wp-content/uploads/2010/07/3791hunter1.jpg")
Farmer.create(name: "Zenger Farm", active: true, image_url: "https://lh4.googleusercontent.com/uoXwnXLYZqDFbqVdGEjvSEN2IrbPGYrdS_gD0wgVMwNSf6kXcu_evZKJQaOk0sNQCjrCwrvek1057vtkLn2bhyuNeXUnJxz4tKjumcMH-b3lfJA9wgQ")
Farmer.create(name: "Black River Farm", active: true, image_url: "http://luxport.s3.amazonaws.com/53174/7285+East+Saanich+Road+Central+Saanich+BC+Canada+389546_1-EXT.JPG")

Item.create(name: 'Chicken and Waffles', description: "You're welcome", price: 11.99, category_id: 1, farmer_id: 1, image_url: "http://honolulumagazine-images.dashdigital.com/web-nook-chicken-waffles.jpg?ver=1433983605")
Item.create(name: 'Burger', description: "Beef city, population: you", price: 6.99, category_id: 1, farmer_id: 1, image_url: "http://www.slurrpy.com/wp-content/uploads/2015/09/chicken-burger-800x500.jpg")
Item.create(name: 'Seared Salmon', description: "This was swimming an hour ago", price: 10.99, category_id: 1, farmer_id: 2, image_url: "http://curves.co.nz/sites/default/files/styles/main_image/public/CUR16617_Curves%20News_posts_Salmon.jpg?itok=KIJwI3oo")
Item.create(name: 'Smoked Salmon', description: "Fan-smokin-tastic", price: 13.99, category_id: 1, farmer_id: 2, image_url: "http://www.seasonedkitchen.com/wp-content/uploads/2012/11/Smoked-salmon.jpg")
Item.create(name: 'Bone-in Rib Eye', description: "Vegetarianism's downfall", price: 12.99, category_id: 1, farmer_id: 3, image_url: "http://rothmanns2.dtpcreative.com/wp-content/uploads/2014/05/steak-btn.jpg")
Item.create(name: 'Beef Tenderloin', description: "Tastes so good make you wanna slap yo Mama", price: 14.99, category_id: 1, farmer_id: 3, image_url: "http://www.desktopimages.org/pictures/steak-meat-meal-dinner-wallpaper-154633.jpg")

Item.create(name: 'Lemonade', description: 'Made from the lemons life gave you', price: 1.69, category_id: 2, farmer_id: 1, image_url: "http://roodepoortrecord.co.za/wp-content/uploads/sites/20/2015/08/6800363-lemonade-wallpaper-Medium.jpg?2a5d20")
Item.create(name: 'Bottled Water', description: 'Oh you fancy huh?', price: 1.99, category_id: 2, farmer_id: 1, image_url: "http://news.wtmlondon.com/wp-content/uploads/2015/01/xBottled-Water-800x500_c.jpg.pagespeed.ic.miFiLsM1b6.jpg")
Item.create(name: 'Beer', description: 'Proof God wants us to be happy', price: 3.99, category_id: 2, farmer_id: 2, image_url: "http://cdn.thedailybeast.com/content/dailybeast/articles/2014/04/05/wine-snobs-there-s-a-beer-for-you/jcr:content/image.crop.800.500.jpg/46659654.cached.jpg")
Item.create(name: 'Milk', description: 'Grow big and strong', price: 1.99, category_id: 2, farmer_id: 2, image_url: "http://nohealthnolife.net/wp-content/uploads/2015/07/1111.jpg")
Item.create(name: 'Soda', description: 'Bubbly & definitely not pop', price: 1.59, category_id: 2, farmer_id: 3, image_url: "http://www.wall321.com/thumbnails/detail/20120306/drink%20macro%20ice%20cubes%201920x1200%20wallpaper_www.wall321.com_47.jpg")
Item.create(name: 'Old Fashioned', description: 'Put some hair on your chest', price: 4.99, category_id: 2, farmer_id: 3, image_url: "http://vinepair.com/wp-content/uploads/2015/09/old-fashioned.jpg")

Item.create(name: 'Mozzarella Sticks', description: 'Golden cheese logs from heaven', price: 2.59, category_id: 3, farmer_id: 1, image_url: "http://dishinwithrebelle.com/wp-content/uploads/2013/06/PankoMozzarellaSticks-Ninja.jpg")
Item.create(name: 'Cheese Curds', description: "Straight from Milwaukee to your mouth", price: 4.99, category_id: 3, farmer_id: 1, image_url: "https://urbanful.org/wp-content/uploads/2014/09/iconic-food.wis_.jpg")
item2 = Item.create(name: 'Milk', description: 'Grow big and strong', price: 2.99, category_id: 3, farmer_id: 2, image_url: "http://nohealthnolife.net/wp-content/uploads/2015/07/1111.jpg")
item = Item.create(name: 'Ice Cream', description: 'Go ahead, you deserve it', price: 2.99, category_id: 3, farmer_id: 2, image_url: "http://www.togashistudio.com/data/photos/832_1ice_cream_bar_01_kiyoshi_togashi.jpg")
Item.create(name: 'Cheese for Days', description: 'Days and days', price: 7.99, category_id: 3, farmer_id: 3, image_url: "http://www.slurrpy.com/wp-content/uploads/2013/01/cheese-day-800x500.jpg")
Item.create(name: 'Milkshake', description: 'Damn. You gonna finish that?', price: 1.99, category_id: 3, farmer_id: 3, image_url: "http://www.jojopix.info/wp-content/uploads/2014/12/177144-milkshakes-strawberry-milkshake-800x500.jpg")

Category.create(name: 'Meat', image_url: "http://weddelswift.com/wp-content/blogs.dir/2/files/2012/04/Beef-Products.png")
Category.create(name: 'Produce', image_url: "http://gerlinginternational.com/images/divisions/produce/mainproduce.jpg")
Category.create(name: 'Dairy', image_url: "http://www.marketresearchreports.com/sites/default/files/styles/blog_pic_header/public/dairy_products.jpg?itok=nu-RXhb5")

User.create(email: "admin@example.com", password: "password", first_name: "null",
            last_name: "null", phone_number: "null", role: 3)
User.create(email: "david@example.com", password: "password", first_name: "David",
            last_name: "Dude", phone_number: "555-555-5555")
    user = User.create(phone_number: "3335556666", email: "ryan@example.com", password: "password",
                       first_name: "Ryan", last_name: "Dude")
User.create(email: "farmer@example.com", password: "password", role: 2,
            farmer_id: 1, first_name: "Old", last_name: "McDonald", phone_number: "null")

    Address.create(user_id: user.id, street_address: "123 Gumdrop lane", city: "Denver",
      state: "CO", zip_code: "80211")
    user2 = User.create(phone_number: "2225557777", email: "justin@example.com", password: "password",
                        first_name: "Justin", last_name: "Beiber")
    Address.create(user_id: user2.id, street_address: "456 Dreary lane", city: "Denver", state: "CO", zip_code: "80211")
    @order1 = Order.create(user_id: user.id, status: 0)
    @order2 = Order.create(user_id: user.id, status: 1)
    @order3 = Order.create(user_id: user2.id, status: 2)
    @order4 = Order.create(user_id: user2.id, status: 3)
    OrderItem.create(order_id: @order1.id, quantity: 3, price: item.price, item_id: item.id)
    OrderItem.create(order_id: @order2.id, quantity: 15, price: item.price, item_id: item.id)
    OrderItem.create(order_id: @order3.id, quantity: 4, price: item2.price, item_id: item2.id)
    OrderItem.create(order_id: @order4.id, quantity: 25, price: item2.price, item_id: item2.id)
