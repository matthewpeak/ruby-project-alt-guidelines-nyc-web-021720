class Farmer < ActiveRecord::Base
        has_many :trades
        has_many :offers
        has_many :traders, through: :trades 
end