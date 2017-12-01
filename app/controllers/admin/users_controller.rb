class Admin::UsersController < ApplicationController

    before_action :authenticate_user!
    layout 'admin'


    # GET /admin/users
    def index
        @users = User.page(params[:page]).per(20)
    end


    # GET /admin/users/search
    def search
        query = params[:query].present? ? params[:query] : '*'
        @users = User.search query,
                             fields: [:name, :email],
                             order: {
                                 _score: :asc,
                                 updated_at: :asc
                             },
                             page: params[:page],
                             per_page: 20
        render 'index'
    end


    # GET /admin/users/:id
    def show
    end


    # GET /admin/users/:id/edit
    def edit
        @user = User.find params[:id]
    end


    # PUT /admin/users/:id
    def update
        @user = User.find params[:id]

        if @user.update user_params
            flash[:notice] = t('admin.user.update') % { name: @user.name }
            redirect_to admin_users_path
        else
            render 'edit'
        end
    end


    # DELETE /admin/users/:id
    def destroy
        enforce_admin(current_user)
    end


    private

        def user_params
            params.require(:user).permit(:name, :email, :role)
        end

end
