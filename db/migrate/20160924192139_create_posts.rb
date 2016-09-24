class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :description
      t.text :image_data

      t.timestamps
    end
  end
end
