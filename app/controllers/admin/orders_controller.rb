class Admin::OrdersController < ApplicationController

    before_action :authenticate_user!
    layout 'admin'


    # GET /admin/orders
    def index
        @orders = Order.page(params[:page]).per(20)
    end


    # GET /admin/orders/search
    def search
        query = params[:query].present? ? params[:query] : '*'
        @orders = Order.search query,
                               page: params[:page],
                               per_page: 20
        render 'index'
    end


    # GET /admin/orders/:id
    def show
        @order = Order.find_by!(reference: params[:id])
    end


    # GET /admin/orders/:id/edit
    def edit
        @order = Order.find_by_reference! params[:id]
    end


    # PUT /admin/orders/:id
    def update
        @order = Order.find_by_reference! params[:id]

        if @order.update order_params
            flash[:notice] = t('admin.order.update') % { reference: @order.reference }
            redirect_to admin_orders_path
        else
            render 'edit'
        end
    end


    private

        def order_params
            params.require(:order).permit
        end

end
