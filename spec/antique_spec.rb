require('spec_helper')

describe(Antique) do
  describe('.not_purchased') do
    it('returns the not purchased antique') do
      not_purchased_antique1 = Antique.create({:name => "Terra Cota Army", :price => 12.99, :purchase_id => nil, :purchased => false})
      not_purchased_antique2 = Antique.create({:name => "Hope Diamond", :price => 19.99, :purchase_id => nil, :purchased => false })
      not_purchased_antiques = [not_purchased_antique1, not_purchased_antique2]
      purchase_antique = Antique.create({:name => "Excalibur", :price => 7.99, :purchase_id => 1, :purchased => true})
      expect(Antique.not_purchased()).to(eq(not_purchased_antiques))
    end
  end

  describe('#purchase') do
    it('allows a antiques to be placed to a purchase') do
      test_purchase = Purchase.create({:time_of_purchase => '2016-12-30 03:00:00'})
      test_antique1 = test_purchase.antiques.create({:name => "Mona Lisa", :price => 13.99, :purchase_id => nil, :purchased => false})
      test_antique2 = test_purchase.antiques.create({:name => "Thinking Man", :price => 13.01, :purchase_id => nil, :purchased => false})
      expect(test_purchase.antiques()).to(eq([test_antique1, test_antique2]))
    end
  end

  describe('#total_price') do
    it('allows a purchase to take place') do
      test_purchase = Purchase.create({:total => 0, :time_of_purchase => '2016-12-30 03:00:00'})
      test_antique1 = test_purchase.antiques.create({:name => "Mona Lisa", :price => 13.99, :purchase_id => nil, :purchased => false})
      test_antique2 = test_purchase.antiques.create({:name => "Thinking Man", :price => 13.01, :purchase_id => nil, :purchased => false})
      expect(test_purchase.total()).to(eq(27.00))
    end
  end
end
