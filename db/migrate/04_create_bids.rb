class CreateBids< ActiveRecord::Migration[5.2]
    def change 
        create_table :bids do |t|
            t.timestamp :timestamp
            t.integer :price
            t.integer :quantity
            t.integer :buyer_id
        end 
    end 
    
end