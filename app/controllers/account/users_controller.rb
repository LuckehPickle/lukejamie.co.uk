class Account::UsersController < ApplicationController

    before_action :authenticate_user!
    layout 'store'

    def show
        
    end

    def edit
    end

    def update
    end

    def destroy
    end

end
