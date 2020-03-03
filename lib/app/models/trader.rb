class Trader < ActiveRecord::Base
    has_many :trades
    has_many :farmers , through: :trades
end