class Order < ApplicationRecord

    has_many :products, through: :order_products
    belongs_to :user
    belongs_to :address
    belongs_to :promo_code

    validates :user, :address, presence: true

    validates :state,
              presence: true,
              inclusion: {
                  in: %w(in_progress delivered refunded)
              }

end
