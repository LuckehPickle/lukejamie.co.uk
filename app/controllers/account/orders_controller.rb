class Account::OrdersController < ApplicationController

    layout 'account'
    before_action :authenticate_user!

    def index
        @orders = current_user.orders
    end

    def show
        @order = current_user.orders.find_by_reference! params[:id]
    end

end
