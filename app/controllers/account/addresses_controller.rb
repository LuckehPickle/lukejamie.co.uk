class Account::AddressesController < ApplicationController

    layout 'store'
    before_action :authenticate_user!

    def index
        @addresses = current_user.addresses
    end

    def new
        @address = Address.new
    end

    def create
        @address = Address.new address_params
        @address.user = current_user

        if @address.save
            flash[:notice] = t('account.address.create') % {
                address: @address.line_one,
                town: @address.town
            }
            redirect_to account_addresses_path
        else
            render 'new'
        end
    end

    def edit
        @address = Address.find params[:id]
    end

    def update
        @address = Address.find params[:id]

        if @address.update address_params
            flash[:notice] = t('account.address.update') % {
                address: @address.line_one,
                town: @address.town
            }
            redirect_to account_addresses_path
        else
            render 'edit'
        end
    end

    def destroy
        @address = Address.find params[:id]
        @address.destroy

        flash[:notice] = t('account.address.delete') % {
            address: @address.line_one,
            town: @address.town
        }
        redirect_to account_addresses_path
    end


    private

        def address_params
            params.require(:address).permit(
                :recipient,
                :organisation,
                :line_one,
                :line_two,
                :town,
                :postcode
            )
        end

end
