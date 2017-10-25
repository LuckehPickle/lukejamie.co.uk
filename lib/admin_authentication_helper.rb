module AdminAuthenticationHelper

    ##
    # Ensures that the given +user+ is an administrator.
    # Redirects other users away. Returns a boolean indicating
    # whether the user was redirected.
    #
    # Params:
    # +user+::A devise user model.
    def enforce_admin (user)
        unless user.admin?
            flash[:notice] = t(:must_be_admin)
            redirect_to root_path
            return true
        end
        false
    end

end