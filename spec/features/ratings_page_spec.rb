require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "shows the number of ratings on the ratings page" do
    visit ratings_path
    expect(page).to have_content "Number of ratings: 0"
    FactoryBot.create :rating, beer: beer1, user: user
    visit ratings_path
    expect(page).to have_content "Number of ratings: 1"
  end

  it "shows the number of ratings in the user's page" do
    visit user_path(user)
    expect(page).to have_content "Has made 0 ratings"
    
    another_user = FactoryBot.create :user, username: "Another"
    FactoryBot.create :rating, beer: beer1, user: another_user

    expect(page).to have_content "Has made 0 ratings"

    FactoryBot.create :rating, beer: beer1, user: user
    
    visit user_path(user)
    expect(page).to have_content "Has made 1 rating"
  end

  it "when destroyed, is removed from the system" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')
    click_button "Create Rating"

    visit ratings_path
    expect(page).to have_content "Number of ratings: 1"
    
    visit user_path(user)
    rating = Rating.find_by(beer: beer1, user: user)
    find("a[href='#{rating_path(rating)}'][data-turbo-method='delete']").click
    
    visit ratings_path
    expect(page).to have_content "Number of ratings: 0"
  end
end