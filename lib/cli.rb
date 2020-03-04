
require 'pry'

def get_user_integer
    gets.chomp.to_i
end 

def get_user_string
    gets.chomp.to_s
end 

def login_menu 
    puts "1.login"
    puts "2.create new account"
    puts "3.exit"
    case(get_user_integer)
    when 1
        login
    when 2 
        create_user

    when 3
        return
    end 
end 

def find_farmer(name)
    Farmer.find_by(name:name)
end

def create_farmer(name,corn,password)
    Farmer.create(name:name,cash:0,corn:corn,password:password)
end 

def create_trader(name,cash,password)
    Trader.create(name:name,cash:cash,corn:0,password:password)
end 

def create_user 
    puts "Trader or Farmer?"
    type = get_user_string
    puts "Name?"
    name = get_user_string
    if type=="Farmer" && !Farmer.find_by(name:name)
        puts "Password?"
        password = get_user_string
        puts "How much corn you got"
        corn = get_user_integer
         
        home_menu(create_farmer(name,corn,password))
    elsif type =="Trader" && !Trader.find_by(name:name)
        puts "Password?"
        password = get_user_string
        puts "How much cash you got"
        cash=get_user_integer
        
        home_menu(create_trader(name,cash,password))
    end 
end 

def login
    puts "Farmer or Trader"
    type=get_user_string
    if type=="Farmer"
        puts "Name?"
        name=get_user_string
        puts "Password"
        password=get_user_string
       if Farmer.find_by(name:name).password == password
         home_menu(Farmer.find_by(name:name))
       else
        puts "wrong pass"
       end 
    elsif type=="Trader"
        puts "Name?"
        name=get_user_string
        puts "Password"
        password=get_user_string
       if Trader.find_by(name:name).password == password
         home_menu(Trader.find_by(name:name))
       else
        puts "wrong pass"
       end 
    end 
    
end


####### menu logic #####


def buy_corn_otc(user)
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






def sell_corn_otc(user) 
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

        end 
   end 
   home_menu(user)
end 

def pending_buys(user)
   
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

        end 
    end 
   home_menu(user)
 end 

def place_bid(user) 
    puts "How much corn you buyin'?"
    quantity_of_corn = get_user_integer
    puts "At what price ???"
    price = get_user_integer
    puts "Generating bid "
    Bid.create(price:price, quantity:quantity_of_corn,buyer_id:user.id,timestamp: Time.now,seller_id:nil)
    home_menu(user)
end 

def place_offer(user)
    puts "How much corn you selling ?"
    quantity_of_corn = get_user_integer
    puts "At what price ???"
    price = get_user_integer
    puts "Generating bid "
    Bid.create(price:price, quantity:quantity_of_corn,buyer_id:nil,timestamp: Time.now, seller_id:user.id)
    home_menu(user)

end

def display_market(user)
    display_bids =   Bid.all.sort_by {|bid| bid.price}.reverse[0..2]
    display_offers = Offer.all.sort_by{|offer| offer.price}[0..2]   
    
    
    puts "3. price:#{display_offers[2].price},quantity:#{display_offers[2].quantity}"
    puts "2. price:#{display_offers[1].price},quantity:#{display_offers[1].quantity}"
    puts "1. price:#{display_offers[0].price},quantity:#{display_offers[0].quantity}"
    puts "===========OFFERS==============="
   
   
    puts "============BIDS================"
    puts "1. price :#{display_bids[0].price}, quantity:#{display_bids[0].quantity} "
    puts "2. price :#{display_bids[1].price}, quantity:#{display_bids[1].quantity} "
    puts "3. price :#{display_bids[2].price}, quantity:#{display_bids[2].quantity} "

    puts "PRESS B TO BUY PRESS S TO SELL Press E to exit:"
   
        
    case(get_user_string.capitalize)
       when "B" 
        #this is what we need to create
        x = Trade.create(seller_id:display_offers[0].seller_id,buyer_id:user.id,price:display_offers[0].price, quantity_of_corn:display_offers[0].quantity,pending_buyer:false,pending_seller:false)
        #Delete the bid remove the bid from the data base
         Offer.find(display_offers[0].id).destroy
        total = x.price * x.quantity_of_corn
        #who ever generated the offer we adjust their totals 
        seller = Farmer.find(x.seller_id)
        seller.update(cash:seller.cash+total,corn:seller.corn-x.quantity_of_corn)
        #below updates the user totals 
        user.update(cash:user.cash-total, corn:user.corn+x.quantity_of_corn)
        #refreshes the market
        display_market(user)
       when "S"
           #this is what we need to create
           x = Trade.create(seller_id:user.id,buyer_id:display_bids[0].buyer_id,price:display_bids[0].price, quantity_of_corn:display_bids[0].quantity,pending_buyer:false,pending_seller:false)
           #Delete the bid remove the bid from the data base
          Bid.find(display_bids[0].id).destroy
           total = x.price * x.quantity_of_corn
           #who ever generated the offer we adjust their totals 
           buyer = Trader.find(x.buyer_id)
           user.update(cash:user.cash+total,corn:user.corn-x.quantity_of_corn)
           #below updates the user totals 
           buyer.update(cash:buyer.cash-total, corn:buyer.corn+x.quantity_of_corn)
           #refreshes the market
           display_market(user)
       when "E"
       home_menu(user)
    end
end 


def home_menu(user)
    puts "1.Amount of Corn"
    puts "2.Amount of Cash"
    puts "3.Trade"
    puts "4.Pending Trades"
    puts "5.Stats"
    puts "6.Log Off"
    case(get_user_integer)
    
        when 1
         puts user.corn
         home_menu(user)
        when 2
         puts user.cash
         home_menu(user)
        when 3
         puts "1.Market"
         puts "2.OTC"
         case(get_user_integer)
         when 1
          puts "1.Display Market"
          puts "2.Place Bid"
          puts "3.Place Offer"
          case(get_user_integer)
          when 1
          display_market(user)
          when 2
            place_bid(user)
          when 3
            place_offer(user)
          end 
         when 2 
            puts "1.Buy Corn OTC"
            puts "2.Sell Corn OTC"
    
            case(get_user_integer)
            when 1
            buy_corn_otc(user) 
            when 2
            sell_corn_otc(user)
            end 
         end 
         
        when 4
            
            puts "1.pending buys"
            puts "2.pending sells"
            case(get_user_integer)
            when 1
            pending_buys(user)
            when 2 
            pending_sales(user)
            end
         when 5
         Trade.find_by(seller_id: user.id)
         home_menu(user)
         when 6 
           
         login_menu     
        
    end
end 
