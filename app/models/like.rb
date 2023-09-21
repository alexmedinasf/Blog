class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  # method to update the likes counter for a post
  def update_likes_counter
    post.increment!(:likes_counter)
  end

  after_save :update_likes_counter
end
