class AddDisplayPictureToProducts < ActiveRecord::Migration[5.1]
    def change
        add_attachment :products, :display_picture
    end
end
