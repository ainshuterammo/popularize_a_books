class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      t.integer :member_id,   null: false, default: ""
      t.integer :category_id, null: false, default: ""
      t.integer :genre_id,    null: false, default: ""
      t.string :isbn,         null: false, default: ""
      t.string :title,        null: false
      t.string :image,        null: false
      t.string :author,       null: false
      t.string :catchphrase,  default: ""
      t.text :body,           default: ""

      t.timestamps
    end
  end
end
