require 'rails_helper'

RSpec.describe 'user index page', type: :system do
  before(:each) do
    @user = User.create(name: 'Jack Sparrow', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'I\'m Captain Jack Sparrow!', posts_counter: 0)
  end

  describe 'index page for users' do
    it 'shows the name of the user' do
      visit users_path
      expect(page).to have_content(@user.name.to_s)
    end

    it 'shows the photo of the user' do
      visit users_path
      expect(page).to have_selector("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    end

    it 'shows the number of posts written by the user' do
      visit users_path
      expect(page).to have_content(@user.posts_counter.to_s)
    end

    it 'redirects to show page when user is clicked' do
      visit users_path
      click_link(@user.name)
      expect(page).to have_current_path(user_path(@user))
    end
  end
end
