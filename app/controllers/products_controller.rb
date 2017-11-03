class ProductsController < ApplicationController

    layout 'store'

    def index
        query = params[:query].present? ? params[:query] : '*'
        @products = Product.search query, page: params[:page], per_page: 40
    end

    def show
        @product = Product.find_by! slug: params[:id]
    end

end
