require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:each) { get '/users/:id/posts' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
    it 'returns the correct placeholder text' do
        expect(response.body).to include('Placeholder for listing all posts of a specific user')
    end
  end

  describe 'GET #show' do
    before(:each) { get '/users/:user_id/posts/:id' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      expect(response).to render_template(:show)
    end
    it 'returns the correct placeholder text' do
        expect(response.body).to include('Placeholder for showing a single post')
    end
  end
end