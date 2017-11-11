class WelcomeController < ApplicationController

    layout 'store'

    def index
        @products = Product.where(featured: true)
                           .where(hidden: false)
                           .order('RANDOM()')
                           .limit(4)
    end
end
