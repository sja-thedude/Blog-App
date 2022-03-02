require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  describe 'User' do
    before(:each) do
      @user1 = User.create! name: 'Sja', password: '215234', email: 'sja@gmail.com', confirmed_at: Time.now
      @user2 = User.create! name: 'Moises', password: '234567', email: 'moises@gmail.com', confirmed_at: Time.now
      visit root_path
      fill_in 'Email', with: 'sja@gmail.com'
      fill_in 'Password', with: '215234'
      click_button 'Log in'
      visit root_path
    end

    it 'shows the username of other users' do
      expect(page).to have_content('Sja')
      expect(page).to have_content('Moises')
    end

    it 'shows photo' do
      image = page.all('img')
      expect(image.size).to eql(2)
    end

    it 'shows number of posts for each user' do
      expect(page).to have_content('Number of posts: 0')
    end

    it 'show users page when clicked' do
      expect(page).to have_content('Number of posts: 0')
      click_on 'Sja'
      expect(page).to have_current_path user_path(@user1)
      expect(page).to have_no_content('Moises')
    end
  end
end
