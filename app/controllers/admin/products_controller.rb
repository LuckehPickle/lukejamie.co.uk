require 'admin_authentication_helper'

class Admin::ProductsController < ApplicationController

    include AdminAuthenticationHelper

    before_action :authenticate_user!
    layout 'admin'


    def index
        return if enforce_admin(current_user)
        query = params[:query].present? ? params[:query] : '*'
        @products = Product.search query,
                                   page: params[:page],
                                   per_page: 30
    end


    def new
        return if enforce_admin(current_user)
        @product = Product.new
    end


    def create
        return if enforce_admin(current_user)
        @product = Product.new product_params

        if @product.save
            flash[:notice] = t('admin.product.create') % { name: @product.name }
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
            flash[:notice] = t('admin.product.update') % { name: @product.name }
            redirect_to admin_products_path
        else
            render 'edit'
        end
    end



    private

        ##
        # Filters parameters
        def product_params
            params.require(:product).permit(
                :name,
                :category,
                :description,
                :display_picture,
                :price,
                :discount,
                :hidden,
                :featured
            )
        end

end
