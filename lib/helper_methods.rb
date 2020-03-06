def get_user_integer
    gets.chomp.to_i
end 

def get_user_string
    gets.chomp.to_s.strip
end 

def is_trader?(user)
    user.instance_of? Trader
end 

def find_farmer(name)
    Farmer.find_by(name:name)
end

def find_trader_trades(user)
    Trade.where(buyer_id:user.id,pending_buyer:false,pending_seller:false)
end
  
def find_farmer_trades(user)
    Trade.where(seller_id:user.id,pending_seller:false,pending_buyer:false)
end


def bumper(n)
    if n >=0
    puts""
    bumper(n-1)
    end 
end 

