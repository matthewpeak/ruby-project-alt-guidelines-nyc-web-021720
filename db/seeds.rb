Matt = Trader.create(name:"Matt",cash:1000,corn:0,password:1)

Og = Trader.create(name:"Og",cash:1000,corn:0,password:1)

Cornelius = Farmer.create(name:"Cornelius", corn:1000000, password:1)

Billy  = Farmer.create(name:"Billy", cash:0,corn:1000000,password:1)

T1 = Trade.create(buyer_id:Og.id ,seller_id:Billy.id,price:10,quantity_of_corn:100,pending_buyer:false,pending_seller:true)



B1=Bid.create(timestamp:Time.now, price:95, quantity:10,buyer_id:Og.id )
B2 =Bid.create(timestamp:Time.now, price:85, quantity:20,buyer_id:Matt.id )
B3=Bid.create(timestamp:Time.now, price:90, quantity:30,buyer_id:Matt.id )
B4=Bid.create(timestamp:Time.now, price:100, quantity:40,buyer_id:Og.id )


O1=Offer.create(timestamp:Time.now, price:105, quantity:5,seller_id:Cornelius.id)
O2=Offer.create(timestamp:Time.now, price:100, quantity:7,seller_id:Billy.id)
O3=Offer.create(timestamp:Time.now, price:110, quantity:8,seller_id:Matt.id)
O4=Offer.create(timestamp:Time.now, price:115, quantity:4,seller_id:Og.id)