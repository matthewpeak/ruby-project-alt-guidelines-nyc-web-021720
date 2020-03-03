class CreateTrades < ActiveRecord::Migration[5.2]
    
    def change
        create_table :trades do |t|
            t.timestamp 
            t.integer :buyer_id
            t.integer :seller_id
            t.integer :price
            t.integer :quantity_of_corn
            t.boolean :pending_buyer
            t.boolean :pending_seller
        end 
    end 

end 