require 'admin_authentication_helper'

class Admin::PromoCodesController < ApplicationController

    include AdminAuthenticationHelper

    before_action :authenticate_user!
    layout 'admin'

    def index
        return if enforce_admin(current_user)
        query = params[:query].present? ? params[:query] : '*'
        @promo_codes = PromoCode.search query,
                                        page: params[:page],
                                        per_page: 20
    end

    def new
        return if enforce_admin(current_user)
        @promo_code = PromoCode.new
    end

    def create
        return if enforce_admin(current_user)

        @promo_code = PromoCode.new promo_code_params

        if @promo_code.save
            flash[:notice] = t('admin.promo_code.create') % { code: @promo_code.code }
            redirect_to admin_promo_codes_path
        else
            render 'new'
        end
    end

    def edit
        return if enforce_admin(current_user)
        @promo_code = PromoCode.find params[:id]
    end

    def update
        return if enforce_admin(current_user)
        @promo_code = PromoCode.find params[:id]

        if @promo_code.update promo_code_params
            flash[:notice] = t('admin.promo_code.update') % {code: @promo_code.code }
            redirect_to admin_promo_codes_path
        else
            render 'edit'
        end
    end

    def destroy
        return if enforce_admin(current_user)

        @promo_code = PromoCode.find params[:id]
        @promo_code.destroy

        flash[:notice] = t('admin.promo_code.delete') % {code: @promo_code.code }
        redirect_to admin_promo_codes_path
    end

    private

        def promo_code_params
            params.require(:promo_code).permit(
                :code,
                :label,
                :discount,
                :start_date,
                :finish_date
            )
        end

end
