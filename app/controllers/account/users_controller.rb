class Account::UsersController < ApplicationController

    before_action :authenticate_user!
    layout 'account'

    def show
        
    end

    def edit
    end

    def update
    end

    def destroy
    end

end
