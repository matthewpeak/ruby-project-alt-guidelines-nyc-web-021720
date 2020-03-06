def create_farmer(name,corn,password)
    Farmer.create(name:name,cash:0,corn:corn,password:password)
end 

def create_trader(name,cash,password)
    Trader.create(name:name,cash:cash,corn:0,password:password)
end 

def create_user 
    bumper(5)
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
    else 
     "Type Better You Messed Up"
     login_menu
    end 
end 

def login
    bumper(5)
    puts "Farmer or Trader"
    type=get_user_string
    if type=="Farmer"
        puts "Name?"
        name=get_user_string
        puts "Password"
        password=get_user_string
       if Farmer.find_by(name:name)!=nil && Farmer.find_by(name:name).password == password
         home_menu(Farmer.find_by(name:name))
       else
        puts "wrong name or wrong pass"
        login_menu
       end 
    elsif type=="Trader"
        puts "Name?"
        name=get_user_string
        puts "Password"
        password=get_user_string
       if Trader.find_by(name:name) != nil && Trader.find_by(name:name).password == password
         home_menu(Trader.find_by(name:name))
       else
        puts "wrong name or wrong pass"
        login_menu
       end 
    else 
     "Type better you messed up "
       login_menu
    end 
    
end