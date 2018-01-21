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

    enum category: [ :shirt, :hoodie, :joggers ]

    has_many :sizes, dependent: :destroy, inverse_of: :product
    has_many :order_products
    has_many :orders, through: :order_products

    accepts_nested_attributes_for :sizes,
                                  reject_if: -> (attrs) {
                                      attrs['label'].blank? || attrs['stock'].blank?
                                  },
                                  allow_destroy: true

    has_attached_file :display_picture,
                      styles: {
                          thumb: '150x150#',
                          display: '300x400#',
                          full: '700x1000#'
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

    def on_sale?
        discount != 0.0
    end

    ##
    # Determines whether this product is currently in stock
    def in_stock?

        # Iterate over all related styles
        self.sizes.each do |size|
            return true if size.stock > 0
        end

        false
    end

end
