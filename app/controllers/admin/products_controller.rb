class Admin::ProductsController < ApplicationController

    before_action :authenticate_user!
    layout 'admin'


    # GET /admin/products
    def index
        @products = Product.order(updated_at: :desc).page(params[:page]).per(20)
    end


    # GET /admin/products/search
    def search
        query = params[:query].present? ? params[:query] : '*'
        @products = Product.search query,
                                   fields: [:name, :description],
                                   order: {
                                       _score: :asc,
                                       updated_at: :asc
                                   },
                                   page: params[:page],
                                   per_page: 30
        render 'index'
    end


    # GET /admin/products/new
    def new
        @product = Product.new
    end


    # POST /admin/products
    def create
        @product = Product.new product_params

        if @product.save
            flash[:notice] = t('admin.product.create') % { name: @product.name }
            redirect_to admin_products_path
        else
            render 'new'
        end
    end


    # GET /admin/products/:id/edit
    def edit
        @product = Product.find_by_slug! params[:id]
    end


    # PUT /admin/products/:id
    def update
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
                :featured,
                sizes_attributes: [
                    :id,
                    :label,
                    :stock,
                    :_destroy
                ]
            )
        end

end
