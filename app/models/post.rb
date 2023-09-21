class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  # method to update the posts counter for a user
  def update_posts_counter
    author.increment!(:posts_counter)
  end

  after_save :update_posts_counter

  # method which returns the 5 most recent comments for a given post
  def recent_comments
    comments.order(created_at: :desc).limit(5).reverse
  end
end
