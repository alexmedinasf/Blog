require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @user = User.create(name: 'test', bio: 'bio', photo: 'photo')
    @post = Post.create(author: @user, title: 'title', text: 'text')
  end
  describe 'GET #index' do
    before(:each) { get "/users/#{@user.id}/posts" }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before(:each) { get "/users/#{@user.id}/posts/#{@post.id}" }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      expect(response).to render_template(:show)
    end
  end
end
