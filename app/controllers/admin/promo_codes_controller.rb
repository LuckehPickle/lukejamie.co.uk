class Admin::PromoCodesController < ApplicationController

    before_action :authenticate_user!
    layout 'admin'

    def index
        @promo_codes = PromoCode.page(params[:page]).per(20)
    end

    def new
        @promo_code = PromoCode.new
    end

    def create
        @promo_code = PromoCode.new promo_code_params

        if @promo_code.save
            flash[:notice] = t('create_promo_code') % { code: @promo_code.code }
            redirect_to admin_promo_codes_path
        else
            render 'new'
        end
    end

    def edit
        @promo_code = PromoCode.find params[:id]
    end

    def update
        @promo_code = PromoCode.find params[:id]

        if @promo_code.update promo_code_params
            flash[:notice] = t('update_promo_code') % {code: @promo_code.code }
            redirect_to admin_promo_codes_path
        else
            render 'edit'
        end
    end

    def destroy
        @promo_code = PromoCode.find params[:id]
        @promo_code.destroy

        flash[:notice] = t('delete_promo_code') % {code: @promo_code.code }
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
