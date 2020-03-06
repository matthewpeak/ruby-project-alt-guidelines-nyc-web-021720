def user_amount_of_corn(user)
    bumper(4)
    puts "You have #{user.corn} pieces of corn!".colorize(:yellow)
    
    home_menu(user)
end


def user_amount_of_cash(user)
    bumper(4)
    puts "you have #{user.cash} dollars".colorize(:green)
    
    home_menu(user)
end 