FactoryGirl.define do

  factory :dog do
    name "Fido"
    age 3
    owner

    factory :old_dog do
      age 12
    end
  end

  factory :owner do
    name "George"
    age 32
    email "george@gmail.com"

    factory :owner_with_many_dogs do
      name "Julia"

      after(:create) do |owner|
        5.times do
          FactoryGirl.create(:dog, owner: owner)
        end
      end
    end

  end

end
