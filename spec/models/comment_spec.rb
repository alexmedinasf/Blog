require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(name: 'Jack Sparrow', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        bio: 'I\'m Captain Jack Sparrow!', posts_counter: 2)
    @post = Post.create(author: @user, title: 'The Black Pearl',
                        text: 'What a ship..!', comments_counter: 0, likes_counter: 4)
    @comment = Comment.create(author: @user, post: @post, text: 'I love this post!')
  end

  it 'should be a comment instance' do
    expect(@comment).to be_an_instance_of(Comment)
  end

  it 'should test the comment_counter method' do
    expect(@post.comments_counter).to eq(1)
  end

  # Tests for validations
  it 'should be valid with valid attributes' do
    expect(@comment).to be_valid
  end

  it 'should not be valid without an author' do
    @comment.author = nil
    expect(@comment).to_not be_valid
  end

  it 'should not be valid without a post' do
    @comment.post = nil
    expect(@comment).to_not be_valid
  end

  it 'should not be valid without a text' do
    @comment.text = nil
    expect(@comment).to_not be_valid
  end

  # Tests for associations
  describe 'the associations of a comnent' do
    it 'should belong to an author' do
      comment = Comment.reflect_on_association(:author)
      expect(comment.macro).to eq(:belongs_to)
    end
    it 'should belong to an post' do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eq(:belongs_to)
    end
  end
end