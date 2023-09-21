class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  # method to update the comments counter for a post
  def update_comments_counter
    post.increment!(:comments_counter)
  end

  after_save :update_comments_counter
end

end
