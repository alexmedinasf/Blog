class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true, length: { in: 2..50 }
  validates :photo, presence: true
  validates :bio, presence: true, length: { in: 2..500 }
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # method to return the 3 most recent posts for a given user
  def recent_posts
    posts.order(created_at: :desc).limit(3).reverse
  end

  # method to return the 5 most recent comments for a given user
  def recent_comments
    comments.order(created_at: :desc).limit(5).reverse
  end

  # method to return the 5 most recent likes for a given user
  def recent_likes
    likes.order(created_at: :desc).limit(5).reverse
  end
end
