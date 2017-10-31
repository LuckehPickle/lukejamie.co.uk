require 'admin_authentication_helper'

class Admin::AdminController < ApplicationController

    include AdminAuthenticationHelper
    before_action :authenticate_user!
    layout 'admin'

    def index
        return if enforce_admin(current_user)
    end

end
