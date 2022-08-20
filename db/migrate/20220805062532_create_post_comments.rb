class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|

      t.text :comment,      null: false
      t.integer :member_id, null: false
      t.integer :book_id,   null: false

      t.timestamps
    end
  end
end
