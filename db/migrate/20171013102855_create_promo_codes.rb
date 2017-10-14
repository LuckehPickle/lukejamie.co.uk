class CreatePromoCodes < ActiveRecord::Migration[5.1]
    def change
        create_table :promo_codes, id: false, primary_key: :code do |t|
            t.string :code, null: false

            t.timestamps
        end
    end
end
