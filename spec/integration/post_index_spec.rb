require 'rails_helper'

RSpec.describe 'post index page', type: :system do
  before(:each) do
    @user = User.create(name: 'Jack Sparrow', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I\'m Captain Jack Sparrow!', posts_counter: 0)
    @post1 = Post.create(title: 'First Post', author: @user, text: 'I\'m the first post!', likes_counter: 0, comments_counter: 0)
    @post2 = Post.create(title: 'Second Post', author: @user, text: 'I\'m the 2nd post!', likes_counter: 0, comments_counter: 0)
    @post3 = Post.create(title: 'Third Post', author: @user, text: 'I\'m the 3rd post!', likes_counter: 0, comments_counter: 0)
    @post4 = Post.create(title: 'Fourth Post', author: @user, text: 'I\'m the 4th post!', likes_counter: 0, comments_counter: 0)
    @post5 = Post.create(title: 'Fifth Post', author: @user, text: 'I\'m the 5th post!', likes_counter: 0, comments_counter: 0)
    @comment1 = Comment.create(text: 'I\'m the first comment!', author: @user, post: @post1)
    @comment2 = Comment.create(text: 'I\'m the 2nd comment!', author: @user, post: @post1)
    @comment3 = Comment.create(text: 'I\'m the 3rd comment!', author: @user, post: @post1)
    @comment4 = Comment.create(text: 'I\'m the 4th comment!', author: @user, post: @post1)
    @comment5 = Comment.create(text: 'I\'m the 5th comment!', author: @user, post: @post1)
    @comment6 = Comment.create(text: 'I\'m the 6th comment!', author: @user, post: @post1)
  end

  describe 'index page for posts' do
    it 'shows the photo of the user' do
      visit user_posts_path(@user)
      expect(page).to have_selector("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    end

    it 'shows the name of the user' do
      visit user_posts_path(@user)
      expect(page).to have_content(@user.name)
    end

    it 'shows the number of posts written by the user' do
      visit user_posts_path(@user)
      expect(page).to have_content(@user.posts_counter)
    end

    it 'shows the title of the posts' do
      visit user_posts_path(@user)
      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
      expect(page).to have_content(@post3.title)
      expect(page).to have_content(@post4.title)
      expect(page).to have_content(@post5.title)
    end

    it 'shows the text of the posts' do
      visit user_posts_path(@user)
      expect(page).to have_content(@post1.text)
      expect(page).to have_content(@post2.text)
      expect(page).to have_content(@post3.text)
      expect(page).to have_content(@post4.text)
      expect(page).to have_content(@post5.text)
    end

    it 'shows the first 5 comments' do
      visit user_posts_path(@user)
      expect(page).to have_css(".comment-body", :maximum => 5)
    end

    it 'shows the number of comments' do
      visit user_posts_path(@user)
      expect(page).to have_content(@post1.comments_counter)
    end

    it 'shows the number of likes' do
      visit user_posts_path(@user)
      expect(page).to have_content(@post1.likes_counter)
    end

    it 'redirects to show page when post is clicked' do
      visit user_posts_path(@user)
      click_link(@post1.title)
      expect(page).to have_current_path(user_post_path(@user, @post1))
    end
  end
end