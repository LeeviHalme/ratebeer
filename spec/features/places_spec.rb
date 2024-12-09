require 'rails_helper'

describe "Places" do
  before :each do
    allow(WeatherstackApi).to receive(:weather_in).with("kumpula").and_return(
      {
        "location" => {
          "name" => "Helsinki",
          "country" => "Finland",
          "region" => "Southern Finland",
          "lat" => "60.176",
          "lon" => "24.934",
          "timezone_id" => "Europe/Helsinki",
          "localtime" => "2024-12-09 20:32",
          "localtime_epoch" => 1733776320,
          "utc_offset" => "2.0"
        },
        "current" => {
          "observation_time" => "06:32 PM",
          "temperature" => -2,
          "weather_code" => 116,
          "weather_icons" => [
            "https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0004_black_low_cloud.png"
          ],
          "weather_descriptions" => [
          "Partly cloudy"
          ],
          "wind_speed" => 7,
          "wind_degree" => 282,
          "wind_dir" => "WNW",
          "pressure" => 1036,
          "precip" => 0,
          "humidity" => 93,
          "cloudcover" => 75,
          "feelslike" => -4,
          "uv_index" => 0,
          "visibility" => 10,
          "is_day" => "no"
        }
       }
    )
  end

  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by the API, all are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), Place.new( name: "Testibaari", id: 2 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Testibaari"
  end

  it "if none are returned by the API, a notice is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end