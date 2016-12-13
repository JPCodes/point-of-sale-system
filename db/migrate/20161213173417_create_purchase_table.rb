class CreatePurchaseTable < ActiveRecord::Migration[5.0]
  def change
    create_table(:purchases) do |t|
      t.column(:time_of_purchase, :time)
      t.column(:total, :decimal)
      t.timestamps()
    end
    add_column(:antiques, :purchase_id, :integer)
    add_column(:antiques, :price, :decimal)
  end
end
