class AddIndexToPosts < ActiveRecord::Migration[5.2]
  def change
     add_index :posts, :content, :unique => true
  end
end
