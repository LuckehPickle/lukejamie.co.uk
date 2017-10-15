class CreateSizes < ActiveRecord::Migration[5.1]
    def change
        create_table :sizes do |t|
            t.references :product, null: false
            t.string  :label, null: false
            t.integer :stock, null: false, default: 0

            t.timestamps
        end
    end
end
