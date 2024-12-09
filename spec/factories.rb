FactoryBot.define do
  factory :user do
    username { "Pekka" }
    password { "Foobar1" }
    password_confirmation { "Foobar1" }
  end

  factory :beer_style do
    name { "Lager" }
    description { "Example description" }
  end

  factory :brewery do
    name { "anonymous" }
    year { 1900 }
  end

  factory :beer do
    name { "anonymous" }
    beer_style # olueeseen liittyvä tyyli luodaan beer_style-tehtaalla
    brewery # olueeseen liittyvä panimo luodaan brewery-tehtaalla
  end

  factory :rating do
    score { 10 }
    beer # reittaukseen liittyvä olut luodaan beer-tehtaalla
    user # reittaukseen liittyvä user luodaan user-tehtaalla
  end
end