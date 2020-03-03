class CreateTraders < ActiveRecord::Migration[5.2]
    
    def change
        create_table :traders do |t|
            t.string  :name
            t.integer :cash
            t.string :password
        end   
    end
    
end 