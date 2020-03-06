def place_bid(user) 
    bumper(9)
    puts "How much corn you buyin'?"
    quantity_of_corn = get_user_integer
    puts "At what price ???"
    price = get_user_integer
    puts "Generating bid "
    Bid.create(price:price, quantity:quantity_of_corn,buyer_id:user.id,timestamp: Time.now)
    display_market(user)
end 

def place_offer(user)
    bumper(9)
    puts "How much corn you selling ?"
    quantity_of_corn = get_user_integer
    puts "At what price ???"
    price = get_user_integer
    puts "Generating bid "
    Offer.create(price:price, quantity:quantity_of_corn,timestamp: Time.now, seller_id:user.id)
    display_market(user)
end

##########################Destruction of bids & offers####################################
def display_bid(user)
    # trader
    # This display the user's all bids

    t=Bid.all.select{|b|b.buyer_id==user.id}
   
    users_map=[]
   
    t.each_with_index do |u,i|
        puts "#{i+1}. price: $#{u.price}, quantity:#{u.quantity}"
        users_map << u.id
    end
    users_map
end


def delete_bid(user,users_map)
    buyer_id = users_map[user-1]
    Bid.find(buyer_id).destroy
end


def display_offer(user)
    o =Offer.all.select{|s|s.seller_id==user.id}
    
     users_map=[]
    
     o.each_with_index do |u,i|
         puts "#{i+1}. price: $#{u.price}, quantity:#{u.quantity}"
         users_map << u.id
     end
     users_map
    
 end
 
 def delete_offer(user,users_map)
     seller_id = users_map[user-1]
     Offer.find(seller_id).destroy
 end

 def delete_bid_or_offer(user)
    puts "Choose the number to delete:"
    if is_trader?(user)
        users_map=display_bid(user)
        delete_bid(get_user_integer,users_map)
    else
    users_map=display_offer(user)
    delete_offer(get_user_integer,users_map)
    end
end