class AddColumnToAntiques < ActiveRecord::Migration[5.0]
  def change
    add_column(:antiques, :purchased, :boolean) 
  end
end
