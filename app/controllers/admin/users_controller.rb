require 'admin_authentication_helper'

class Admin::UsersController < ApplicationController

    include AdminAuthenticationHelper

    before_action :authenticate_user!
    layout 'admin'


    def index
        return if enforce_admin(current_user)
        query = params[:query].present? ? params[:query] : '*'
        @users = User.search query,
                             page: params[:page],
                             per_page: 20
    end


    def show
        enforce_admin(current_user)
    end

    def edit
        return if enforce_admin(current_user)

        @user = User.find params[:id]
    end


    def update
        enforce_admin(current_user)

        @user = User.find params[:id]

        if @user.update user_params
            flash[:notice] = t('admin.user.update') % { name: @user.name }
            redirect_to admin_users_path
        else
            render 'edit'
        end
    end


    def destroy
        enforce_admin(current_user)
    end


    private

        def user_params
            params.require(:user).permit(:name, :email, :role)
        end

end
