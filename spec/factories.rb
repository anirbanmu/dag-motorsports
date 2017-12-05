FactoryBot.define do
  factory :Platform do
    name { Faker::App.name }
  end

  factory :Game do
    name { Faker::App.name }
    release { Faker::Date.backward }
    developer { Faker::Company.name }
    publisher { Faker::Company.name }
  end

  factory :GamePlatformAssociation do
    game { build(:Game) }
    platform { build(:Platform) }
  end
end
