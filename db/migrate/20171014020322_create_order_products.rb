class CreateOrderProducts < ActiveRecord::Migration[5.1]
    def change
        create_table :order_products do |t|
            t.references :order,    null: false
            t.references :product,  null: false
            t.references :size,     null: false
            t.integer    :quantity, null: false

            t.timestamps
        end
    end
end
