class CreateProducts < ActiveRecord::Migration[5.1]
    def change
        create_table :products do |t|
            t.string  :slug,        null: false
            t.string  :name,        null: false
            t.text    :description, null: false
            t.decimal :price,       null: false, precision: 7, scale: 2, default: 0
            t.boolean :hidden,      null: false, default: false

            t.timestamps
        end
    end
end
