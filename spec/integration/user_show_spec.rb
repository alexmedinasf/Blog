require 'rails_helper'

RSpec.describe 'user show page', type: :system do
  before(:each) do
    @user = User.create(name: 'Jack Sparrow', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I\'m Captain Jack Sparrow!', posts_counter: 0)
    @post1 = Post.create(title: 'First Post', author: @user, text: 'I\'m the first post!', likes_counter: 0, comments_counter: 0)
    @post2 = Post.create(title: 'Second Post', author: @user, text: 'I\'m the 2nd post!', likes_counter: 0, comments_counter: 0)
    @post3 = Post.create(title: 'Third Post', author: @user, text: 'I\'m the 3rd post!', likes_counter: 0, comments_counter: 0)
    @post4 = Post.create(title: 'Fourth Post', author: @user, text: 'I\'m the 4th post!', likes_counter: 0, comments_counter: 0)
    @post5 = Post.create(title: 'Fifth Post', author: @user, text: 'I\'m the 5th post!', likes_counter: 0, comments_counter: 0)
  end

  describe 'show page for users' do
    it 'shows the photo of the user' do
      visit user_path(@user)
      expect(page).to have_selector("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    end

    it 'shows the name of the user' do
      visit user_path(@user)
      expect(page).to have_content(@user.name)
    end

    it 'shows the number of posts written by the user' do
      visit user_path(@user)
      expect(page).to have_content(@user.posts_counter)
    end

    it 'shows the bio of the user' do
      visit user_path(@user)
      expect(page).to have_content(@user.bio)
    end

    it 'shows the first 3 posts of the user' do
      visit user_path(@user)
      expect(page).to have_css('h3', maximum: 4)
    end

    it 'shows the see all posts button' do
      visit user_path(@user)
      expect(page).to have_content('See all posts')
    end

    it 'redirects to posts index page when see all posts button is clicked' do
      visit user_path(@user)
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
