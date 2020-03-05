def user_amount_of_corn(user)
    puts ""
    puts ""
    puts ""
    puts "You have #{user.corn} pieces of corn!".colorize(:yellow)
    puts ""
    puts ""
    puts ""
    home_menu(user)
end


def user_amount_of_cash(user)
    puts ""
    puts ""
    puts ""
    puts "you have #{user.cash} dollars".colorize(:green)
    puts ""
    puts ""
    puts ""
    home_menu(user)
end 