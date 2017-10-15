class Admin::ProductsController < ApplicationController

    before_action :authenticate_user!

    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new product_params

        if @product.save
            flash[:notice] = t('create_product') % {name: @product.name }
            redirect_to product_path(@product)
        else
            render 'new'
        end
    end

    def edit
        @product = Product.find_by_slug! params[:id]
    end

    def update
        @product = Product.find_by_slug! params[:id]

        if @product.update product_params
            flash[:notice] = t('update_product') % {name: @product.name }
            redirect_to product_path(@product)
        else
            render 'edit'
        end
    end


    private

        ##
        # Filters parameters
        def product_params
            params.require(:product).permit(:name, :description, :price, :hidden)
        end

end
