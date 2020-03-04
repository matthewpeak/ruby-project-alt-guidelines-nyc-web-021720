class Offer < ActiveRecord::Base
    belongs_to :traders
    belongs_to :farmers
end 