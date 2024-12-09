require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "when saving beer" do
    let(:brewery){ Brewery.new name: "test", year: 2000}

    it "works with a proper name and style" do
      style = BeerStyle.create name: "teststyle", description: "testdescription"
      beer = Beer.create name: "testbeer", beer_style: style, brewery: brewery
      
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
    
    it "does not work without a name" do
      style = BeerStyle.create name: "teststyle", description: "testdescription"
      beer = Beer.create beer_style: style, brewery: brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "does not work without a style" do
      beer = Beer.create name: "testbeer", brewery: brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
