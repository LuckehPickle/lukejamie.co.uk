class Size < ApplicationRecord

    belongs_to :product

    validates :product, presence: true

    validates :label,
              presence: true,
              length: { within: 1..64 }

    validates :stock,
              presence: true,
              numericality: {
                  only_integer: true,
                  greater_than_or_equal_to: 0
              }

end
