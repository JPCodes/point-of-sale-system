class Antique < ActiveRecord::Base
  # Creation of Antique triggers touch method
    # touch method triggers after_touch on Purchase
  belongs_to :purchase, touch: true

  scope(:not_purchased, -> do
    where({:purchased => false})
  end)
end
