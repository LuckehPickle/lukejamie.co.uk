require 'slug_helper'

class Product < ApplicationRecord

    include SlugHelper

    searchkick callbacks: :async

    def search_data
        {
            name: name,
            description: description,
            category: category,
            hidden: hidden
        }
    end

    enum category: [ :shirt, :hoodie, :shoes, :trackies ]

    has_many :sizes, dependent: :destroy
    has_many :order_products
    has_many :orders, through: :order_products

    has_attached_file :display_picture,
                      styles: {
                          thumb: '150x150#',
                          display: '300x350#',
                          full: '720x1280>'
                      },
                      default_url: '/images/:style/missing.png'

    validates_associated :sizes, :orders

    validates :slug,
              uniqueness: true,
              length: { within: 1..45 }

    validates :name,
              presence: true,
              uniqueness: true,
              length: { within: 3..128 }

    validates_attachment :display_picture,
                         presence: true,
                         size: { in: 0..4000.kilobytes }

    validates_attachment_content_type :display_picture,
                                      content_type: %w( image/jpeg image/gif image/png )

    validates :description, :category, presence: true

    validates :price,
              presence: true,
              numericality: {
                  greater_than_or_equal_to: 0,
                  less_than: 1000000
              }

    validates :discount,
              presence: true,
              numericality: {
                  greater_than_or_equal_to: 0.0,
                  less_than_or_equal_to: 1.0
              }

    before_validation do
        self.slug = slugify(self.name)
    end

    def to_param
        slug
    end

    def sale?
        discount != 0.0
    end

end
