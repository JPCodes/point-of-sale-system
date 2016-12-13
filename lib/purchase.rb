class Purchase < ActiveRecord::Base
  has_many(:antiques)

  # After 'touch' activates the specified method for use
  after_touch(:total_price)

  private
  define_method(:total_price) do
    purchase_price = 0
    purchase_antiques = self.antiques()
    purchase_antiques.each do |antique|
      purchase_price += antique.price()
    end
    purchase_price
  end
end
