def market_buy(user,display_offers)
    if display_offers.length>0
      #this is what we need to create
      x = Trade.create(seller_id:display_offers[0].seller_id,buyer_id:user.id,price:display_offers[0].price, quantity_of_corn:display_offers[0].quantity,pending_buyer:false,pending_seller:false)
      #Delete the bid remove the offer from the data base
      Offer.find(display_offers[0].id).destroy
      total = x.price * x.quantity_of_corn
      #who ever generated the bid we adjust their totals 
      seller = Farmer.find(x.seller_id)
      seller.update(cash:seller.cash+total,corn:seller.corn-x.quantity_of_corn)
      #below updates the user totals 
      user.update(cash:user.cash-total, corn:user.corn+x.quantity_of_corn)
      #refreshes the market
      display_market(user)
    else   
      display_market(user)
    end
end 

def market_sell(user,display_bids)
  if display_bids.length>0
  #this is what we need to create
  x = Trade.create(seller_id:user.id,buyer_id:display_bids[0].buyer_id,price:display_bids[0].price, quantity_of_corn:display_bids[0].quantity,pending_buyer:false,pending_seller:false)
  #Delete the bid remove the bid from the data base
  Bid.find(display_bids[0].id).destroy
  total = x.price * x.quantity_of_corn
  #who ever generated the offer we adjust their totals 
  buyer = Trader.find(x.buyer_id)
  user.update(cash:user.cash+total,corn:user.corn-x.quantity_of_corn)
  #below updates the user totals 
  buyer.update(cash:buyer.cash-total, corn:buyer.corn+x.quantity_of_corn)
  #refreshes the market
  display_market(user)
  else 
    display_market(user)
  end
end
