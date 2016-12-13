require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/purchase')
require('./lib/antique')
require('pg')

get('/') do
  erb(:index)
end

get('/management') do
  @antiques = Antique.all()
  erb(:management)
end

post('/antique-order-form') do
  name = params.fetch('antique_name')
  price = params.fetch('antique_price')
  Antique.create({:name => name, :price => price, :purchase_id => nil})
  @antiques = Antique.all()
  erb(:management)
end


get('/cashier') do
  @antiques = Antique.all()
  erb(:cashier)
end

post('/register') do
  @purchase_items = params.fetch('antique')
  current_purchase = Purchase.create({:total => 0, :time_of_purchase => '01:15:00'})
  current_purchase.total_price(@purchase_items)

  @antiques = Antique.all()
  erb(:cashier)
end
