class CreateSupportArticles < ActiveRecord::Migration[5.1]
    def change
        create_table :support_articles do |t|
            t.string :slug,  null: false
            t.string :title, null: false
            t.text   :body,  null: false

            t.timestamps
        end

        add_index :support_articles, :slug
    end
end
