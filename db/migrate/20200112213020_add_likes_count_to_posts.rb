class AddLikesCountToPosts < ActiveRecord::Migration[5.2]
  class MigrationUser < ApplicationRecord
    self.table_name = :posts
  end

  def up
    _up
  rescue => e
    _down
    raise e
  end

  def down
    _down
  end

  private

  def _up
    MigrationUser.reset_column_information

    add_column :posts, :suki_count, :integer, null: false, default: 0 unless column_exists? :posts, :suki_count
    add_column :posts, :kirai_count, :integer, null: false, default: 0 unless column_exists? :posts, :kirai_count
    add_column :posts, :notinterested_count, :integer, null: false, default: 0 unless column_exists? :posts, :notinterested_count
  end

  def _down
    MigrationUser.reset_column_information

    remove_column :posts, :suki_count if column_exists? :posts, :suki_count
    remove_column :posts, :kirai_count if column_exists? :posts, :kirai_count
    remove_column :posts, :notinterested_count if column_exists? :posts, :notinterested_count
  end
end
