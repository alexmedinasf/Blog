require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:each) { @user = User.create(name: 'test', bio: 'bio', photo: 'photo') }
  describe 'GET #index' do
    before(:each) { get '/users' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before(:each) { get "/users/#{@user.id}" }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      expect(response).to render_template(:show)
    end
  end
end