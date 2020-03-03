


def get_user_integer
    gets.chomp.to_i
end 

def get_user_string
    gets.chomp.to_s
end 

def login_menu 
    puts "1.login"
    puts "2.create new account"
end 

def find_farmer(name)
    Farmer.find_by(name:name)
end

def create_farmer(name,corn,password)
    Farmer.create(name:name,money:0,corn:corn,password:password)
end 

def create_trader(name,money,password)
    Trader.create(name:name,money:money,corn:0,password:password)
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
        create_farmer(name,corn,password)
    elsif type =="Trader" && !Trader.find_by(name:name)
        puts "How much money you got"
        money=get_user_integer
        create_trader(name,money,password) 
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
         puts "logged in "
       else
        puts "wrong pass"
       end 
    end 
    
end


####### menu logic #####

def home_menu(user)
    puts "1.Amount of Corn"
    puts "2.Trade"
    puts "3.Pending Trades"
    puts "4.All Trades"
    case(get_user_integer)
    
        when 1
         puts user.corn
        when 2 
         puts "1.Buy Corn"
         puts "2.Sell Corn"
            case(get_user_integer)
            when 1
            #buy_corn(user) 
            when 2
            sell_corn(user)
            end 
        when 3
         puts "1.pending buys"
         puts "2.pending sells"
         case(get_user_integer)
         when 1
         #pending_buys(user)
         when 2 
         pending_sell_trades(user)
       
        when 4
        Trade.find_by(seller_id: user.id)

    end
end 

def buy_corn(user)
    
end 

def sell_corn(user) 
    puts "How much corn you sellin' "
    quantity_of_corn = get_user_integer
    #check if farmer can sell that amount 
    puts "How much you sellin for"
    price = get_user_integer
    puts "who you sellin to"
    buyer_id = get_user_integer
    puts "creating that trade"
    Trade.create(seller_id:user.id,buyer_id:buyer_id,price:price, quantity_of_corn:quantity_of_corn,pending_buyer:true,pending_seller:false)
end 

def pending_sell_trades(user)
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
end 

#########Trader############
