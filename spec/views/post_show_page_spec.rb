require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  describe 'User' do
    before(:each) do
      @user1 = User.create( name: 'Sja', password: '215234', bio: 'I am Software Engineer',
                            email: 'sja@gmail.com', confirmed_at: Time.now)
      @user2 = User.create( name: 'Stev', password: '123456', bio: 'My name is Stev',
                            email: 'stev@gmail.com', confirmed_at: Time.now)
      visit root_path
      fill_in 'Email', with: 'sja@gmail.com'
      fill_in 'Password', with: '215234'
      click_button 'Log in'

      @post1 = Post.create(title: 'To Be',
                                    text: 'The big question is: "To be or not to be a Ruby programmer"', comments_counter: 0, likes_counter: 0, user: @user1)
      @post2 = Post.create(title: 'Hello',
                                    text: 'Why people say HTML is not a programming language..."', comments_counter: 0, likes_counter: 0, user: @user1)
      @post3 = Post.create(title: 'Hey',
                                    text: 'With the clif hanger seen in the first half of season 4, do you think..."', comments_counter: 0, likes_counter: 0, user: @user1)

      @comment1 = Comment.create(text: 'This is the first comment for the first post', user: User.first , post: Post.first)
      @comment2 = Comment.create(text: 'This is the second comment', user: User.first , post: Post.first)
      @comment3 = Comment.create(text: 'This is the third comment', user: User.first , post: Post.first)

      visit user_post_path(@user1, @post1)
    end

    it 'shows posts title' do
      expect(page).to have_content('To Be')
    end

    it 'shows the person who wrote the post' do
      expect(page).to have_content('Sja')
    end

    it 'shows number of comments' do
      user = User.first
      post = Post.first
      expect(page).to have_content(post.comments_counter)
    end

    it 'shows number of likes' do
      user = User.first
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it 'can see the post\'s body.' do
      expect(page).to have_content('This is the first comment for the first post')
    end

    it 'can see the username of each commentor.' do
      user = User.first
      post = Post.first
      comment = post.comments.first
      expect(page).to have_content(comment.user.name)
    end

    it 'can see the comments of each commentor.' do
      expect(page).to have_content 'This is the second comment'
    end
  end
end
