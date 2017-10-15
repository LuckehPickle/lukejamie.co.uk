class CreateOrders < ActiveRecord::Migration[5.1]
    def change
        create_table :orders, id: false, primary_key: :reference do |t|
            t.column :reference, :uuid, null: false
            t.references :user,    null: false
            t.references :address, null: false
            t.references :promo_code
            t.string :state, null: false

            t.timestamps
        end
    end
end
