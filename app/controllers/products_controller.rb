class ProductsController < ApplicationController

    layout 'store'

    def index
        query = params[:query].present? ? params[:query] : '*'
        @products = Product.search query,
                                   where: { hidden: false },
                                   page: params[:page],
                                   per_page: 40
    end

    def show
        @product = Product.find_by! slug: params[:id]
    end

    def cart

        params.require(:products)
        puts "___"

        slug_list = JSON.parse params[:products]
        @items = Product.where(slug: slug_list)

        respond_to do |format|
            format.js
        end

    end

end
