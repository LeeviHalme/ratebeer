require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end
  
    Capybara.javascript_driver = :chrome
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = BeerStyle.create name: "Lager"
    @style2 = BeerStyle.create name: "Rauchbier"
    @style3 = BeerStyle.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, beer_style: @style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, beer_style: @style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, beer_style: @style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "shows beers in alphabetical order", js:true do
    visit beerlist_path
    expect(find('#beertable').first('.tablerow')).to have_content "Fastenbier"
  end

  it "shows beers in beer style alphabetical order when sorted by style", js:true do
    visit beerlist_path
    find('#style').click
    expect(find('#beertable').first('.tablerow')).to have_content "Lager"
  end

  it "shows beers in brewery alphabetical order when sorted by brewery", js:true do
    visit beerlist_path
    find('#brewery').click
    expect(find('#beertable').first('.tablerow')).to have_content "Ayinger"
  end
end