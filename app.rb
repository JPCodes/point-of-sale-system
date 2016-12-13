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
  purchase_items = []
  # purchase_items = purchase_items.push(antique.each())
  total = purchase_items.total_price()
  Purchase.create({:total_price => total})
  @antiques = Antique.all()
  erb(:cashier)
end
