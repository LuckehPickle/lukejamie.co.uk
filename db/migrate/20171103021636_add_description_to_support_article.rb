class AddDescriptionToSupportArticle < ActiveRecord::Migration[5.1]
    def change
        add_column :support_articles, :description, :text
        add_column :support_articles, :category,    :integer, default: 0
    end
end
