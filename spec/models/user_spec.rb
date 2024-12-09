require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with invalid password" do
    user_pass_too_short = User.create username: "Pekka", password: "Sec", password_confirmation: "Sec"
    user_pass_too_simple = User.create username: "Pekka", password: "supersecret", password_confirmation: "supersecret"

    expect(user_pass_too_short).not_to be_valid
    expect(user_pass_too_simple).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite style" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have a favorite style" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_style).to eq(beer.beer_style.name)
    end

    it "is the one with highest average rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_styled_beer_with_rating({ user: user }, "IPA", 25)

      expect(user.favorite_style).to eq(best.beer_style.name)
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have a favorite brewery" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do
      brewery = FactoryBot.create(:brewery, name: "testbrewery")
      beer = FactoryBot.create(:beer, brewery: brewery)
      FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_brewery).to eq(brewery)
    end

    it "is the one with highest average rating if several rated" do
      brewery1 = FactoryBot.create(:brewery, name: "testbrewery1")
      brewery2 = FactoryBot.create(:brewery, name: "testbrewery2")
      beer1 = FactoryBot.create(:beer, brewery: brewery1)
      beer2 = FactoryBot.create(:beer, brewery: brewery2)
      FactoryBot.create(:rating, score: 20, beer: beer1, user: user)
      FactoryBot.create(:rating, score: 25, beer: beer2, user: user)

      expect(user.favorite_brewery).to eq(brewery2)
    end
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  
    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end

def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end

def create_styled_beer_with_rating(object, style, score)
  beer_style = FactoryBot.create(:beer_style, name: style)
  beer = FactoryBot.create(:beer, beer_style: beer_style)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end