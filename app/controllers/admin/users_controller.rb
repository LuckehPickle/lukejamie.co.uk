require 'admin_authentication_helper'

class Admin::UsersController < ApplicationController

    include AdminAuthenticationHelper

    before_action :authenticate_user!
    layout 'admin'

    def index
        return if enforce_admin(current_user)

        @users = User.page(params[:page]).per(20)
    end

    def show
        enforce_admin(current_user)
    end

    def edit
        enforce_admin(current_user)
    end

    def update
        enforce_admin(current_user)
    end

    def destroy
        enforce_admin(current_user)
    end

end
