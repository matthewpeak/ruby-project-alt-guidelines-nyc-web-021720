
require 'pry'


def login_menu 
    bumper(9)
    puts logo
    puts "1.login".colorize(:yellow)
    puts "2.create new account".colorize(:green)
    puts "3.exit".colorize(:red)
    case(get_user_integer)
    when 1
        login
    when 2 
        create_user

    when 3
        return
    else
     login_menu
    end 
end 



def display_market(user)
    bumper(9)
    display_bids =   Bid.all.sort_by {|bid| bid.price}.reverse[0..2]
    display_offers = Offer.all.sort_by{|offer| offer.price}[0..2]   
    
    if display_offers.length>0
      display_offers.to_enum.with_index.reverse_each do |o,i|
         puts "#{i+1}. price: $#{o.price}, quantity:#{o.quantity}".colorize(:red)
      end
    else
       puts "PRAY TO GOD FOR MORE CORN".colorize(:red)
    end
    puts "===========OFFERS==============="
   
   
    puts "============BIDS================"
    if display_bids.length>0
     display_bids.each_with_index do |b,i|
        puts "#{i+1}. price: $#{b.price}, quantity:#{b.quantity}".colorize(:green)
     end 
    else
        puts "NO BODY WANTS YOUR PATHETIC CORN".colorize(:green)
    end 
    
    if is_trader?(user)
       puts "TYPE M TO MARKET BUY, B TO PLACE A BID,D TO DELETE OPEN BIDS, E TO EXIT:".colorize(:green)
       case(get_user_string.capitalize)
         when "M" 
          market_buy(user,display_offers)
       
         when"B"
         place_bid(user)
         
         when"D"
         delete_bid_or_offer(user)
         display_market(user)
         when "E"
         home_menu(user)
         else 
         display_market(user)
       end
    else
       puts "TYPE M TO MARKET SELL, S TO PLACE AN OFFER,D TO DELETE OPEN BIDS, E TO EXIT:".colorize(:red)
       case(get_user_string.capitalize)
         when "M"
         market_sell(user,display_bids)
      
         when "S"
         place_offer(user) 
          
         when"D"
         delete_bid_or_offer(user)
         display_market(user)
         when "E"
         home_menu(user)
         else
         display_market(user)
        end
   end 
              
end 


def home_menu(user)
    bumper(9)
    puts "Welcome #{user.name}, trade dat corn baby!".colorize(:yellow)
    puts "1.Amount of Corn"
    puts "2.Amount of Cash"
    puts "3.Trade".colorize(:green)
    puts "4.Stats"
    puts "5.Log Off".colorize(:red)
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
               else
                home_menu(user)
             end 
            else 
             puts "1.Sell Corn OTC"
             puts "2.Pending OTC Trades"
             case(get_user_integer)
              when 1
               sell_corn_otc(user) 
              when 2
               pending_sales(user)
              else 
              home_menu(user)
             end 
            
            end 
          else
         home_menu(user)
        end 
         
         when 4
         if is_trader?(user)
         trader_stats(user)
         else
         farmer_stats(user)
         end
         when 5 
         login_menu 
         else
         home_menu(user)    
        
    end
end 
