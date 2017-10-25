class Order < ApplicationRecord

    self.primary_key = 'reference'

    enum state: [ :processing, :shipped, :returned, :refunded ]

    has_many :order_products
    has_many :products, through: :order_products
    belongs_to :user
    belongs_to :address
    belongs_to :promo_code, dependent: :delete

    validates :user, :address, presence: true

    validates :reference,
              presence: true,
              uniqueness: true,
              length: { is: 10 }

    validates :state, presence: true

    def to_param
        reference
    end

    def before_create
        self.reference ||= generate_reference
    end


    private

        ##
        # Generates a unique 10 digit, hexadecimal reference
        # number.
        def generate_reference
            begin
                ref = SecureRandom.hex(5)
            end while Order.exists?(reference: ref)

            ref
        end

end
