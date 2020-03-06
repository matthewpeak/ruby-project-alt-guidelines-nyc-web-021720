
######### TRADER_OTC_LOGIC ###########

def buy_corn_otc(user)
    bumper(9)
    puts "How much corn you buyin'?"
    quantity_of_corn = get_user_integer
    puts "At what price ???"
    price = get_user_integer
    puts "who you buyin from ?"
    seller_id = get_user_integer
    puts = "creating that trade"
    Trade.create(seller_id:seller_id,buyer_id:user.id,price:price, quantity_of_corn:quantity_of_corn,pending_buyer:false,pending_seller:true)
    home_menu(user)
end 

def pending_buys(user)
    bumper(2)
    Trade.where(buyer_id:user.id,pending_buyer:true).each do |pending_trade|  
        total=pending_trade.quantity_of_corn* pending_trade.price
     puts "Do you want to buy #{pending_trade.quantity_of_corn} corn at a price of $#{pending_trade.price} to 
     #{pending_trade.seller_id} for total of $#{total}?"

      puts"1. Yes"
      puts"2. No"
      case(get_user_integer)
        
        when 1
            pending_trade.update(pending_buyer:false)
            #this method finds the buyer's trader id and then updates its totals to that of the consumated trade
            t=Trader.find_by(id:pending_trade.seller_id)
            t.update(cash:t.cash+total, corn:t.corn-pending_trade.quantity_of_corn)

            user.update(cash:user.cash-total, corn:user.corn+pending_trade.quantity_of_corn)
            
        when 2
            pending_trade.destroy
        
        else
         pending_buys(user)
        end 
    end 
   home_menu(user)
 end 



######################FARMER OTC LOGIC#############################

def sell_corn_otc(user) 
    bumper(9)
    puts "How much corn you sellin'? "
    quantity_of_corn = get_user_integer
    #check if farmer can sell that amount 
    puts "How much you sellin for"
    price = get_user_integer
    puts "who you sellin to"
    buyer_id = get_user_integer
    puts "creating that trade"
    Trade.create(seller_id:user.id,buyer_id:buyer_id,price:price, quantity_of_corn:quantity_of_corn,pending_buyer:true,pending_seller:false)
    home_menu(user)
end 

def pending_sales(user)
    #seller_pending to false
    #seller_id equal to user id
    Trade.where(seller_id:user.id,pending_seller:true).each do |pending_trade|  
        total=pending_trade.quantity_of_corn* pending_trade.price
     puts "Do you want to sell #{pending_trade.quantity_of_corn} corn at a price of $#{pending_trade.price} to 
     #{pending_trade.buyer_id} for total of $#{total}?"

      puts"1. Yes"
      puts"2. No"
      case(get_user_integer)
        
        when 1
            pending_trade.update(pending_seller:false)
            #this method finds the buyer's trader id and then updates its totals to that of the consumated trade
            t=Trader.find_by(id:pending_trade.buyer_id)
            t.update(cash:t.cash-total, corn:t.corn + pending_trade.quantity_of_corn)

            user.update(cash:user.cash+total, corn:user.corn-pending_trade.quantity_of_corn)
            
        when 2
            pending_trade.destroy
        else
            pending_sales(user)
        end 
   end 
   home_menu(user)
end 

