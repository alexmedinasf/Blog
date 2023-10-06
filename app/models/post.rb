class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy, foreign_key: :post_id
  has_many :likes, dependent: :destroy, foreign_key: :post_id
  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true, length: { maximum: 500 }
  validates :author, presence: true, length: { maximum: 50 }
  validates :likes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # A method that updates the posts counter for a user.

  def update_posts_counter(user_id)
    user = User.find(user_id)
    counter = user.posts.count
    user.update(posts_counter: counter)
  end

  # A method which returns the 5 most recent comments for a given post.
  def recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5).reverse
  end
  before_validation :set_defaults

  private

  def set_defaults
    self.likes_counter = 0
    self.comments_counter ||= 0
  end
end
