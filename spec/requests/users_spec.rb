require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'should returns http 200 success' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'should render the correct template' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    before(:each) { get user_path(32) }

    it 'should return correct response' do
      expect(response).to have_http_status(200)
    end

    it 'should render the show template ' do
      expect(response).to render_template(:show)
    end
  end
end
