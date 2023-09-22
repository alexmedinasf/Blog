require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Jack Sparrow', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'You will always remember this as the day that you almost caught Captain Jack Sparrow!', posts_counter: 0) }

  before { subject.save }

  it 'should be a user instance' do
    expect(subject).to be_an_instance_of(User)
  end

  it 'should test the recent_posts method' do
    expect(subject.recent_posts).to eq([])
  end

  # Tests for validations
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  describe 'the proper form of a name' do
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid with a name shorter than 2 characters' do
      subject.name = 'a'
      expect(subject).to_not be_valid
    end
    it 'is not valid with a name longer than 50 characters' do
      subject.name = 'a' * 51
      expect(subject).to_not be_valid
    end
  end

  describe 'the proper form of a bio' do
    it 'is not valid without a bio' do
      subject.bio = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid with a bio shorter than 2 characters' do
      subject.bio = 'a'
      expect(subject).to_not be_valid
    end
    it 'is not valid with a bio longer than 500 characters' do
      subject.bio = 'a' * 501
      expect(subject).to_not be_valid
    end
  end

  it 'is not valid without a photo' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end

  it 'must have a posts_counter' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  # Tests for associations
  describe 'the associations of a user' do
    it 'should possibly have many comments' do
      u = User.reflect_on_association(:comments)
      expect(u.macro).to eq(:has_many)
    end

    it 'should possibly have many likes' do
      u = User.reflect_on_association(:likes)
      expect(u.macro).to eq(:has_many)
    end

    it 'should possibly have many posts' do
      u = User.reflect_on_association(:posts)
      expect(u.macro).to eq(:has_many)
    end
  end
end