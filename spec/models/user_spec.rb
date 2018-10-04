require 'rails_helper'
require_relative '../concerns/test_seeds.rb'

describe 'User' do

  it 'has a name' do
    expect(User.find(1).name).to eq('Ciaran')
  end

  it 'knows the most popular user' do
    expect(User.most_popular.id).to eq(1)
  end

describe 'user log in' do
  it 'allows an existing user to sign in' do
    User.create!(email: "bob@fakeemail.com", password:"s3cur3p4ssw0rd")
    visit '/users/sign_in'

    fill_in 'Email', with: "bob@fakeemail.com"
    fill_in 'Password', with: "s3cur3p4ssw0rd"

    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully.')
  end
end

end
