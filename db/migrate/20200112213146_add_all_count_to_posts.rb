class AddAllCountToPosts < ActiveRecord::Migration[5.2]
  def up
    execute "ALTER TABLE posts ADD COLUMN all_count real GENERATED ALWAYS AS (suki_count+kirai_count) STORED;"
    add_index :posts, :all_count, unique: false
  end

  def down
    remove_column :posts, :all_count
  end
end
