class CreatePromoCodes < ActiveRecord::Migration[5.1]
    def change
        create_table :promo_codes, id: false, primary_key: :code do |t|
            t.string  :code,     null: false
            t.string  :label,    null: false
            t.integer :discount, null: false
            t.date :start_date,  null: false
            t.date :finish_date, null: false

            t.timestamps
        end

        add_index :promo_codes, :code
    end
end
