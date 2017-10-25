require 'admin_authentication_helper'

class Admin::ProductsController < ApplicationController

    include AdminAuthenticationHelper

    before_action :authenticate_user!
    layout 'admin'


    def index
        return if enforce_admin(current_user)
        @products = Product.page(params[:page]).per(30)
    end


    def new
        return if enforce_admin(current_user)
        @product = Product.new
    end


    def create
        return if enforce_admin(current_user)
        @product = Product.new product_params

        if @product.save
            flash[:notice] = t('create_product') % { name: @product.name }
            redirect_to admin_products_path
        else
            render 'new'
        end
    end


    def edit
        return if enforce_admin(current_user)

        @product = Product.find_by_slug! params[:id]
    end


    def update
        return if enforce_admin(current_user)

        @product = Product.find_by_slug! params[:id]

        if @product.update product_params
            flash[:notice] = t('update_product') % { name: @product.name }
            redirect_to admin_products_path
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
