require 'rails_helper'
require_relative '../concerns/test_seeds.rb'

describe 'User' do

  it 'has a name' do
    expect(User.find(1).name).to eq('Ciaran')
  end

  it 'knows the most popular user' do
    expect(User.most_popular.id).to eq(1)
  end

end
