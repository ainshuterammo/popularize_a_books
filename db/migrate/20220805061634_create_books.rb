class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      t.integer :member_id,     null: false
      t.integer :genre_id
      t.string :isbn,           null: false
      t.string :title
      t.string :image_url
      t.string :author
      t.string :publisher_name
      t.string :catchphrase
      t.text :body

      t.timestamps
    end
  end
end
