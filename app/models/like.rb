class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, presence: true
  validates :post_id, presence: true
  counter_culture :post, column_name: -> (model) {"#{model.like_type_name}_count"}

  def like_type_name
    if suki == 1 then
      return 'suki'
    elsif suki == 0 then
      return 'kirai'
    elsif suki == 2 then
      return 'notinterested'

    end      
  end
end
