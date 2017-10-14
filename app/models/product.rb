class Product < ApplicationRecord

    has_many :sizes, dependent: :destroy
    has_many :orders, through: :product_orders

    validates_associated :sizes, :orders

    validates :slug,
              uniqueness: true,
              length: { within: 1..45 }

    validates :name,
              presence: true,
              length: { within: 3..128 }

    validates :description, presence: true

    validates :price,
              presence: true,
              numericality: {
                  greater_than_or_equal_to: 0,
                  less_than: 1000000
              }

    before_validation do
        self.slug = slugify(self.title)
    end

    def to_param
        slug
    end

end
