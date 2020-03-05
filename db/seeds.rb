Matt = Trader.create(name:"Matt",cash:1000,corn:0,password:"1")

Og = Trader.create(name:"Og",cash:1000,corn:0,password:"1")

Cornelius = Farmer.create(name:"Cornelius",cash:0, corn:1000000, password:"1")

Billy  = Farmer.create(name:"Billy", cash:0,corn:1000000,password:"1")

T1 = Trade.create(buyer_id:Og.id ,seller_id:Billy.id,price:10,quantity_of_corn:100,pending_buyer:false,pending_seller:false)
T2 =  Trade.create(buyer_id:Og.id ,seller_id:Billy.id,price:50,quantity_of_corn:300,pending_buyer:false,pending_seller:false)
T3 =  Trade.create(buyer_id:Matt.id ,seller_id:Billy.id,price:10,quantity_of_corn:20,pending_buyer:false,pending_seller:false)
T4 =  Trade.create(buyer_id:Og.id ,seller_id:Billy.id,price:800,quantity_of_corn:300,pending_buyer:false,pending_seller:false)
T5 =  Trade.create(buyer_id:Og.id ,seller_id:Billy.id,price:500,quantity_of_corn:200,pending_buyer:false,pending_seller:false)


B1=Bid.create(timestamp:Time.now, price:95, quantity:10,buyer_id:Og.id )
B2 =Bid.create(timestamp:Time.now, price:85, quantity:20,buyer_id:Matt.id )
B3=Bid.create(timestamp:Time.now, price:90, quantity:30,buyer_id:Matt.id )
B4=Bid.create(timestamp:Time.now, price:100, quantity:40,buyer_id:Og.id )


O1=Offer.create(timestamp:Time.now, price:105, quantity:5,seller_id:Cornelius.id)
O2=Offer.create(timestamp:Time.now, price:100, quantity:50,seller_id:Billy.id)
O3=Offer.create(timestamp:Time.now, price:110, quantity:100,seller_id:Billy.id)
O4=Offer.create(timestamp:Time.now, price:115, quantity:20,seller_id:Cornelius.id)
O5=Offer.create(timestamp:Time.now, price:120, quantity:10,seller_id:Billy.id)
O6=Offer.create(timestamp:Time.now, price:125, quantity:80,seller_id:Billy.id)