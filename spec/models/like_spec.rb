require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.new(name: 'Jack Sparrow', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                     bio: 'I\'m Captain Jack Sparrow!', posts_counter: 2)
    @post = Post.new(author: @user, title: 'The Black Pearl', text: 'What a ship..!',
                     comments_counter: 2, likes_counter: 4)
  end

  subject { Like.new(author: @user, post: @post) }

  before { subject.save }

  it 'should be a like instance' do
    expect(subject).to be_an_instance_of(Like)
  end

  it 'should test the likes_counter method' do
    expect(@post.likes_counter).to eq(5)
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
      expect(subject.author).to eq(@user)
    end

    it 'should have a post' do
      expect(subject.post).to eq(@post)
    end
  end
end
