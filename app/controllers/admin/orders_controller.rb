require 'admin_authentication_helper'

class Admin::OrdersController < ApplicationController

    include AdminAuthenticationHelper

    before_action :authenticate_user!
    layout 'admin'

    def index
        return if enforce_admin(current_user)
        query = params[:query].present? ? params[:query] : '*'
        @orders = Order.search query,
                               page: params[:page],
                               per_page: 20
    end

    def show
        return if enforce_admin(current_user)
        @order = Order.find_by!(reference: params[:id])
    end

    def edit
        return if enforce_admin(current_user)
        @order = Order.find_by_reference! params[:id]
    end

    def update
        return if enforce_admin(current_user)
        @order = Order.find_by_reference! params[:id]

        if @order.update order_params
            flash[:notice] = t('update_order') % { reference: @order.reference }
            redirect_to admin_orders_path
        else
            render 'edit'
        end
    end

end
