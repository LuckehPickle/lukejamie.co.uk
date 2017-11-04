class AddDiscountToProducts < ActiveRecord::Migration[5.1]
    def change
        add_column :products, :discount, :decimal, precision: 3, scale: 2, default: 0.0
    end
end
