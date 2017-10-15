class Order < ApplicationRecord

    self.primary_key = 'reference'

    has_many :order_products
    has_many :products, through: :order_products
    belongs_to :user
    belongs_to :address
    belongs_to :promo_code, dependent: :delete

    validates :user, :address, presence: true

    validates :reference,
              presence: true,
              uniqueness: true

    validates :state,
              presence: true,
              inclusion: {
                  in: %w(in_progress delivered waiting_return returned)
              }

    def to_param
        reference
    end

    def before_create
        self.reference ||= SecureRandom.uuid
    end

end
