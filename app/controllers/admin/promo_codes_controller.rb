class Admin::PromoCodesController < ApplicationController

    before_action :authenticate_user!
    layout 'admin'


    # GET /admin/promo-codes
    def index
        @promo_codes = PromoCode.page(params[:page]).per(20)
    end


    # GET /admin/promo-codes/search
    def search
        query = params[:query].present? ? params[:query] : '*'
        @promo_codes = PromoCode.search query,
                                        fields: [:code, :label],
                                        order: {
                                            _score: :asc,
                                            updated_at: :asc
                                        },
                                        page: params[:page],
                                        per_page: 20
        render 'index'
    end


    # GET /admin/promo-codes/new
    def new
        @promo_code = PromoCode.new
    end


    # POST /admin/promo-codes
    def create
        @promo_code = PromoCode.new promo_code_params

        if @promo_code.save
            flash[:notice] = t('admin.promo_code.create') % { code: @promo_code.code }
            redirect_to admin_promo_codes_path
        else
            render 'new'
        end
    end


    # GET /admin/promo-codes/:id/edit
    def edit
        @promo_code = PromoCode.find params[:id]
    end


    # PUT /admin/promo-codes/:id
    def update
        @promo_code = PromoCode.find params[:id]

        if @promo_code.update promo_code_params
            flash[:notice] = t('admin.promo_code.update') % {code: @promo_code.code }
            redirect_to admin_promo_codes_path
        else
            render 'edit'
        end
    end


    # DELETE /admin/promo-codes/:id
    def destroy
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
