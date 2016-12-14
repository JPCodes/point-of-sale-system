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

  define_singleton_method(:between) do |time1, time2|
    matches_found = Purchase.where("time_of_purchase > ? AND time_of_purchase < ?", time1, time2)
    matches_array = []
    matches_found.each do |purchase|
      matches_array.push(purchase.id.to_i)
    end
    bought_antiques = []
    matches_array.each do |purchase_id|
      bought_antiques.push(Antique.where(purchase_id: purchase_id))
    end
    bought_antiques
  end
end
