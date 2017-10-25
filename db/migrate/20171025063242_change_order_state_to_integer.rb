class ChangeOrderStateToInteger < ActiveRecord::Migration[5.1]
    def change
        change_column :orders, :state, 'INTEGER USING CAST(state AS INTEGER)', default: 0
    end
end
