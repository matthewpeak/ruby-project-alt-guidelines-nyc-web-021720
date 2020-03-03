require_relative '../config/environment'

puts "hello world"

login_menu
case(get_user_integer)
when 1
    login
    

when 2 
    create_user



end

 