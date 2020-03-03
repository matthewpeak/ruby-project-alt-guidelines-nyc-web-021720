


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
    Farmer.create(name:name,corn:corn,password:password)
end 

def create_trader(name,money,password)
    Trader.create(name:name,money:money,password:password)
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
        reate_trader(name,money,password) 
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
         farmer_home_menu(Farmer.find_by(name:name))
       else
        puts "wrong pass"
       end 
    elsif type=="Trader"
        puts "Name?"
        name=get_user_string
        puts "Password"
        password=get_user_string
       if Trader.find_by(name:name).password == password
         #user_home 
         puts "logged in "
       else
        puts "wrong pass"
       end 
    end 
    
end


####### Farmer #####

def farmer_home_menu(user)
    puts "1.Amount of Corn"
    puts "2.Trade"
    puts "3.All Trades"
    case(get_user_integer)
    
        when 1
         puts user.corn
        when 2 
         sell_corn(user)
         
        when 3
        Trade.find_by(seller_id: user.id)

    end
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
    Trade.create(seller_id:user.id,buyer_id:buyer_id,price:price, quantity_of_corn:quantity_of_corn)
end 