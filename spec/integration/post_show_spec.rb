require 'rails_helper'

RSpec.describe 'post show page', type: :system do
  before(:each) do
    @user = User.create(name: 'Jack Sparrow', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I\'m Captain Jack Sparrow!', posts_counter: 1)
    @user2 = User.create(name: 'Will Turner', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I\'m Will Turner!', posts_counter: 0)
    @post = Post.create(title: 'First Post', author: @user, text: 'I\'m the first post!', likes_counter: 0, comments_counter: 6)
    @comment = Comment.create(text: 'I\'m a comment!', author: @user, post: @post)
    @comment = Comment.create(text: 'I\'m a comment!', author: @user2, post: @post)
    @comment = Comment.create(text: 'I\'m a comment!', author: @user, post: @post)
    @comment = Comment.create(text: 'I\'m a comment!', author: @user2, post: @post)
    @comment = Comment.create(text: 'I\'m a comment!', author: @user, post: @post)
    @comment = Comment.create(text: 'I\'m a comment!', author: @user2, post: @post)
  end

  describe 'show page for posts' do
    it 'shows the title of the post' do
      visit user_post_path(@user, @post)
      expect(page).to have_content(@post.title)
    end

    it 'shows the author of the post' do
      visit user_post_path(@user, @post)
      expect(page).to have_content(@post.author.name)
    end

    it 'shows the number of comments' do
      visit user_post_path(@user, @post)
      expect(page).to have_content(@post.comments_counter)
    end

    it 'shows the number of likes' do
      visit user_post_path(@user, @post)
      expect(page).to have_content(@post.likes_counter)
    end

    it 'shows the text of the post' do
      visit user_post_path(@user, @post)
      expect(page).to have_content(@post.text)
    end

    it 'shows the usernames of the comments' do
      visit user_post_path(@user, @post)
      expect(page).to have_content(@comment.author.name)
    end
  end
end
