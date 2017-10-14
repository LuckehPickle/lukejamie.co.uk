class OrderProduct < ApplicationRecord

    belongs_to :product
    belongs_to :order
    belongs_to :size

    validates :product, :order, presence: true

    validates :quantity,
              presence: true,
              numericality: {
                  only_integer: true,
                  greater_than_or_equal_to: 1
              }

end
