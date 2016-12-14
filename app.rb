require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/purchase')
require('./lib/antique')
require('pg')

get('/') do
  # adam = Purchase.between('2016-12-13 14:29:00', '2016-12-13 14:42:00')
  # puts adam
   erb(:index)
end

get('/management/purchased_between') do
  erb(:purchased_between)
end

post('/DateTime_form') do
  date_one = params.fetch('date_one')
  date_two = params.fetch('date_two')
  @purchases = Purchase.between(date_one, date_two)

  erb(:purchased_between)
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

get('/antique/:id') do
  @antique = Antique.find(params.fetch("id").to_i)
  erb(:antique)
end

patch('/antique/update/:id') do
  @antique = Antique.find(params.fetch("id").to_i)
  name = params.fetch('name')
  price = params.fetch('price')
  if @antique.update({:name => name, :price => price})
    erb(:antique)
  else
    erb(:errors)
  end
end

delete('/antique/delete/:id') do
  @antique = Antique.find(params.fetch("id").to_i)
  @antiques = Antique.all()
  @antiques_available = Antique.where(purchased: false)
  @antique.delete()
  erb(:management)
end
