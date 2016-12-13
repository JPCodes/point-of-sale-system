class Purchase < ActiveRecord::Base
  has_many(:antiques)

  # After 'touch' activates the specified method for use
  # after_touch(:total_price)

  # private
  define_method(:total_price) do |purchase_items|
    purchase_price = 0
    purchase_items.each do |antique|
      current_antique = Antique.find(antique.to_i)
      current_antique.update({:purchase_id => self.id, :purchased => true})
      purchase_price += current_antique.price
    end
    self.update({:total => purchase_price})
  end
end
