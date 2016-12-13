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
  @antiques_available = Antique.where(purchased: false)
  @antiques = Antique.all()
  erb(:management)
end

post('/antique-order-form') do
  name = params.fetch('antique_name')
  price = params.fetch('antique_price')
  Antique.create({:name => name, :price => price, :purchase_id => nil, :purchased => false})
  @antiques_available = Antique.where(purchased: false)
  @antiques = Antique.all()
  erb(:management)
end


get('/cashier') do
  @antiques = Antique.where(purchased: false)
  erb(:cashier)
end

post('/register') do
  @purchase_items = params.fetch('antique')
  current_time = DateTime.now
  current_time = current_time.strftime "%d/%m/%Y %H:%M"

  current_purchase = Purchase.create({:total => 0, :time_of_purchase => current_time})
  current_purchase.total_price(@purchase_items)

  @antiques = Antique.where(purchased: false)
  erb(:cashier)
end
