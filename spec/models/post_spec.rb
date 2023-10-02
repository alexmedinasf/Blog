require 'rails_helper'
RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.new(name: 'Jack Sparrow', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                     bio: 'I\'m Captain Jack Sparrow!', posts_counter: 0)
    @post = Post.create(author: @user, title: 'The Black Pearl', text: 'What a ship, it was...',
                        comments_counter: 0, likes_counter: 0)
  end

  it 'should be a post instance' do
    expect(@post).to be_an_instance_of(Post)
  end

  it 'should test the posts_counter method' do
    expect(@user.posts_counter).to eq(1)
  end

  it 'should test the recent_comments method' do
    expect(@post.recent_comments).to eq([])
  end

  # Tests for validations
  it 'is valid with valid attributes' do
    expect(@post).to be_valid
  end

  describe 'the proper form of a title' do
    it 'is not valid without a title' do
      @post.title = nil
      expect(@post).to_not be_valid
    end
    it 'is not valid with a title longer than 250 characters' do
      @post.title = 'a' * 251
      expect(@post).to_not be_valid
    end
  end

  describe 'the proper form of a text' do
    it 'is not valid without a text' do
      @post.text = nil
      expect(@post).to_not be_valid
    end
    it 'is not valid with a text longer than 500 characters' do
      @post.text = 'a' * 501
      expect(@post).to_not be_valid
    end
  end

  it 'is not valid without an author' do
    case @post.author
    when nil
      expect(@post).to_not be_valid
    when @user
      expect(@post).to be_valid
    end
  end

  # Tests for associations
  describe 'the associations of a post' do
    it 'should belong to an author' do
      post = Post.reflect_on_association(:author)
      expect(post.macro).to eq(:belongs_to)
    end
    it 'should possibly have many comments' do
      post = Post.reflect_on_association(:comments)
      expect(post.macro).to eq(:has_many)
    end
    it 'should possibly have many likes' do
      post = Post.reflect_on_association(:likes)
      expect(post.macro).to eq(:has_many)
    end
  end
end
