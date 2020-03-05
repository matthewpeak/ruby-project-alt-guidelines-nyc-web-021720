
require 'pry'


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



def display_market(user)
    display_bids =   Bid.all.sort_by {|bid| bid.price}.reverse[0..2]
    display_offers = Offer.all.sort_by{|offer| offer.price}[0..2]   
    
    
    puts "3. price:#{display_offers[2].price},quantity:#{display_offers[2].quantity}".colorize(:red)
    puts "2. price:#{display_offers[1].price},quantity:#{display_offers[1].quantity}".colorize(:red)
    puts "1. price:#{display_offers[0].price},quantity:#{display_offers[0].quantity}".colorize(:red)
    puts "===========OFFERS==============="
   
   
    puts "============BIDS================"
    puts "1. price :#{display_bids[0].price}, quantity:#{display_bids[0].quantity} ".colorize(:green)
    puts "2. price :#{display_bids[1].price}, quantity:#{display_bids[1].quantity} ".colorize(:green)
    puts "3. price :#{display_bids[2].price}, quantity:#{display_bids[2].quantity} ".colorize(:green)
    
    if is_trader?(user)
       puts "TYPE M TO MARKET BUY, B TO PLACE A BID, E TO EXIT:".colorize(:green)
       case(get_user_string.capitalize)
         when "M" 
          market_buy(user,display_offers)
       
         when"B"
         place_bid(user)
       
         when "E"
         home_menu(user)
       end
    else
       puts "TYPE M TO MARKET SELL, S TO PLACE AN OFFER, E TO EXIT:".colorize(:red)
       case(get_user_string.capitalize)
         when "M"
         market_sell(user,display_bids)
      
         when "S"
         place_offer(user) 
     
         when "E"
         home_menu(user)
        end
   end 
              
end 


def home_menu(user)
    puts "Welcome #{user.name}, trade dat corn baby!".colorize(:yellow)
    puts "1.Amount of Corn"
    puts "2.Amount of Cash"
    puts "3.Trade"
    puts "4.Stats"
    puts "5.Log Off"
    case(get_user_integer)
    
        when 1
        user_amount_of_corn(user)
        when 2
        user_amount_of_cash(user)
        when 3
         puts "1.Market"
         puts "2.OTC"
         case(get_user_integer)
           when 1
           display_market(user)
          
           when 2 
            if is_trader?(user)
             puts "1.Buy Corn OTC"
             puts "2.Pending OTC Trades"
             case(get_user_integer)
               when 1
               buy_corn_otc(user) 
               when 2
               pending_buys(user)
             end 
            else 
             puts "1.Sell Corn OTC"
             puts "2.Pending OTC Trades"
             case(get_user_integer)
              when 1
               sell_corn_otc(user) 
              when 2
               pending_sales(user)
             end 
            
            end 
        end 
         
         when 4
         if is_trader?(user)
         trader_stats(user)
         else
         farmer_stats(user)
         end
         when 5 
         login_menu     
        
    end
end 
