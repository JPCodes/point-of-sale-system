class ChangeTimeColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column(:purchases, :time_of_purchase)
    add_column(:purchases, :time_of_purchase, :datetime)
  end
end
