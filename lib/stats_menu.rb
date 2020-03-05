##########  TRADER LOGIC ##############
def trader_stats(user)
    puts "1.Recent Trades"
    puts "2.Most Expensive Trade"
    puts "3.Home Menu"
 case(get_user_integer)
    when 1
     recent_trades= find_trader_trades(user).reverse[0..2].reverse
     recent_trades.each do |trade|
     puts ""
     puts ""
     puts "You Bought #{trade.quantity_of_corn} cobs of corn ".colorize(:yellow)
     puts "at a price of $#{trade.price}".colorize(:green)
     puts "from farmer #{Farmer.find(trade.seller_id).name}"
     puts "for a total of $#{trade.price*trade.quantity_of_corn} "
     puts""
     puts""
     end
     trader_stats(user)
    when 2
      big_boy= find_trader_trades(user).sort_by{|trade| trade.price * trade.quantity_of_corn}[-1]
      puts""
      puts""
      puts""
      puts "You bought #{big_boy.quantity_of_corn} cobs of corn".colorize(:yellow)
      puts "at a price of $#{big_boy.price}".colorize(:green)
      puts "for a total of #{big_boy.price * big_boy.quantity_of_corn}"
      puts "whooooah dude you must really love corn"
      puts ""
      puts ""
      puts ""
      trader_stats(user)
    when 3
     home_menu(user)
     
  end
end


#################Farmer Logic #############

def farmer_stats(user)
  puts "1.Recent Trades"
  puts "2.Most Expensive Trade"
  puts "3.Home Menu"
case(get_user_integer)
  when 1
   recent_trades= find_farmer_trades(user).reverse[0..2].reverse
   recent_trades.each do |trade|
   puts ""
   puts ""
   puts "You sold #{trade.quantity_of_corn} cobs of corn ".colorize(:yellow)
   puts "at a price of $#{trade.price}".colorize(:green)
   puts "to an idiot named #{Trader.find(trade.buyer_id).name}"
   puts "for a total of $#{trade.price*trade.quantity_of_corn} "
   puts""
   puts""
   end
   trader_stats(user)
  when 2
    big_boy= find_trader_trades(user).sort_by{|trade| trade.price * trade.quantity_of_corn}[-1]
    puts""
    puts""
    puts""
    puts "You bought #{big_boy.quantity_of_corn} cobs of corn".colorize(:yellow)
    puts "at a price of $#{big_boy.price}".colorize(:green)
    puts "for a total of #{big_boy.price * big_boy.quantity_of_corn}"
    puts "whooooah dude you must really love corn"
    puts ""
    puts ""
    puts ""
    trader_stats(user)
  when 3
   home_menu(user)
   
end
end
