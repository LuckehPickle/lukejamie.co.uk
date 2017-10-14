class CreateAddresses < ActiveRecord::Migration[5.1]
    def change
        create_table :addresses do |t|
            t.references :user, null: false
            t.string :recipient, null: false
            t.string :organisation
            t.string :line_one,  null: false
            t.string :line_two
            t.string :town,      null: false
            t.string :postcode,  null: false

            t.timestamps
        end
    end
end
