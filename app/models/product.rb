require 'slug_helper'

class Product < ApplicationRecord

    include SlugHelper

    searchkick callbacks: :async

    def search_data
        {
            name: name,
            description: description
        }
    end

    has_many :sizes, dependent: :destroy
    has_many :order_products
    has_many :orders, through: :order_products

    validates_associated :sizes, :orders

    validates :slug,
              uniqueness: true,
              length: { within: 1..45 }

    validates :name,
              presence: true,
              uniqueness: true,
              length: { within: 3..128 }

    validates :description, presence: true

    validates :price,
              presence: true,
              numericality: {
                  greater_than_or_equal_to: 0,
                  less_than: 1000000
              }

    before_validation do
        self.slug = slugify(self.name)
    end

    def to_param
        slug
    end

end
