require 'rails_helper'

describe "Beers page" do
  before :each do
    FactoryBot.create :brewery, name:"Koff"
    FactoryBot.create :beer_style, name:"Lager"
    FactoryBot.create :user
  end

  it "should create a new beer with valid name" do
    sign_in(username: "Pekka", password: "Foobar1")
    visit new_beer_path
    fill_in('beer_name', with:'Test beer')
    select('Koff', from:'beer[brewery_id]')
    select('Lager', from:'beer[beer_style_id]')
    
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "should not create a new beer with invalid name" do
    sign_in(username: "Pekka", password: "Foobar1")
    visit new_beer_path
    fill_in('beer_name', with:'')
    select('Koff', from: 'beer[brewery_id]')
    select('Lager', from: 'beer[beer_style_id]')
    
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    
    expect(page).to have_content "Name is too short (minimum is 1 character)"
  end  
end