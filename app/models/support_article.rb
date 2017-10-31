require 'slug_helper'

class SupportArticle < ApplicationRecord

    includes SlugHelper

    searchkick

    def search_data
        {
            title: title,
            body: body
        }
    end

    validates :slug,
              uniqueness: true,
              length: { within: 1..45 }

    validates :title,
              presence: true,
              uniqueness: true,
              length: { maximum: 64 }

    validates :body, presence: true

    before_validation do
        self.slug = slugify(title)
    end

    def to_param
        slug
    end

end
