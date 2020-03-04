class CreateOffers< ActiveRecord::Migration[5.2]
    def change 
        create_table :offers do |t|
            t.timestamp :timestamp
            t.integer :price
            t.integer :quantity
            t.integer :seller_id
        end 
    end
end