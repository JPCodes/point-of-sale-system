ENV['RACK_ENV'] = 'test'
require("rspec")
require("pg")
require('sinatra/activerecord')
require("./lib/antique")
require("./lib/purchase")
require('pry')


# Clears test database between spec runs
RSpec.configure do |config|
  config.after(:each) do
    Antique.all().each do |antique|
      antique.destroy()
    end
    Purchase.all().each do |purchase|
      purchase.destroy()
    end
  end
end
