Matt = Trader.create(name:"Matt",cash:1000)

Og = Trader.create(name:"Og",cash:1000,password:"abcd")

Cornelius = Farmer.create(name:"Cornelius", corn:1000000)

Billy  = Farmer.create(name:"Billy", corn:1000000,password:"abc")

T1 = Trade.create(buyer_id:Og.id ,seller_id:Billy.id,price:10,quantity_of_corn:100)