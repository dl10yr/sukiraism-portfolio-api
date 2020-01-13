class AddSukipercentToPosts < ActiveRecord::Migration[5.2]
  def up
    execute "ALTER TABLE posts ADD COLUMN suki_percent real GENERATED ALWAYS AS (
      CASE WHEN (suki_count+kirai_count) = 0 THEN NULL
      ELSE suki_count*100/(suki_count+kirai_count) END
      ) STORED;"
    add_index :posts, :suki_percent, unique: false
  end

  def down
    remove_column :posts, :suki_percent
  end
end
