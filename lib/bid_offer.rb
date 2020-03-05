def place_bid(user) 
    puts "How much corn you buyin'?"
    quantity_of_corn = get_user_integer
    puts "At what price ???"
    price = get_user_integer
    puts "Generating bid "
    Bid.create(price:price, quantity:quantity_of_corn,buyer_id:user.id,timestamp: Time.now)
    display_market(user)
end 

def place_offer(user)
    puts "How much corn you selling ?"
    quantity_of_corn = get_user_integer
    puts "At what price ???"
    price = get_user_integer
    puts "Generating bid "
    Offer.create(price:price, quantity:quantity_of_corn,timestamp: Time.now, seller_id:user.id)
    display_market(user)
end
#########################################################################
