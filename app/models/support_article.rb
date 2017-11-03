require 'slug_helper'

class SupportArticle < ApplicationRecord

    include SlugHelper

    searchkick

    def search_data
        {
            title: title,
            body: body
        }
    end

    enum category: [ :guide, :policy, :miscellaneous ]

    validates :slug,
              uniqueness: true,
              length: { within: 1..45 }

    validates :title,
              presence: true,
              uniqueness: true,
              length: { maximum: 64 }

    validates :description,
              presence: true,
              length: { maximum: 256 }

    validates :body, :category, presence: true


    before_validation do
        self.slug = slugify(self.title)
    end

    def to_param
        slug
    end

end
