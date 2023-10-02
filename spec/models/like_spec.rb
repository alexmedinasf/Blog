require 'rails_helper'
RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.new(name: 'Jack Sparrow', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                     bio: 'I\'m Captain Jack Sparrow!', posts_counter: 2)
    @post = Post.new(author: @user, title: 'The Black Pearl', text: 'What a ship..!',
                     comments_counter: 2, likes_counter: 0)
    @like = Like.create(author: @user, post: @post)
  end

  it 'should be a like instance' do
    expect(@like).to be_an_instance_of(Like)
  end

  it 'should test the likes_counter method' do
    expect(@post.likes_counter).to eq(1)
  end

  # Tests for associations and connections
  describe 'the associations of a like' do
    it 'should belong to an author' do
      like = Like.reflect_on_association(:author)
      expect(like.macro).to eq(:belongs_to)
    end
    it 'should belong to an post' do
      like = Like.reflect_on_association(:post)
      expect(like.macro).to eq(:belongs_to)
    end
  end
  # Tests for the attributes of like
  describe 'the attributes of a like' do
    it 'should have an author' do
      expect(@like.author).to eq(@user)
    end

    it 'should have a post' do
      expect(@like.post).to eq(@post)
    end
  end
end