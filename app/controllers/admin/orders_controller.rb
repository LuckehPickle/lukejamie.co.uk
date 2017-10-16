class Admin::OrdersController < ApplicationController

    before_action :authenticate_user!
    layout 'admin'

    def index
        @orders = Order.all
    end

    def edit
        @order = Order.find_by_reference! params[:id]
    end

    def update
        @order = Order.find_by_reference! params[:id]

        if @order.update order_params
            flash[:notice] = t('update_order') % { reference: @order.reference }
            redirect_to admin_orders_path
        else
            render 'edit'
        end
    end

end
