class User < ApplicationRecord
    has_many :posts, foreign_key: :author_id
    has_many :comments, foreign_key: :author_id
    has_many :likes, foreign_key: :author_id

    # method to return the 3 most recent posts for a given user
  def recent_posts
    posts.order(created_at: :desc).limit(3).reverse
  end

  # method to return the 5 most recent comments for a given user
  def recent_comments
    comments.order(created_at: :desc).limit(5).reverse
  end
end
