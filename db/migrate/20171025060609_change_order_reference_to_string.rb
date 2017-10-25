class ChangeOrderReferenceToString < ActiveRecord::Migration[5.1]
    def change
        change_column :orders,         :reference, :string
        change_column :order_products, :order_id,  :string
        add_index :orders, :reference
    end
end
