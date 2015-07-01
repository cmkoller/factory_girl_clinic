require 'rails_helper'


feature 'user signs out', %Q{
  As an authenticated user
  I want to sign out
  So that my identity is forgotten about on the machine I'm using
} do

  scenario "user views all dogs without owners" do
    # Dog.create(name: "Fido", age: 3)
    FactoryGirl.create(:dog)

    visit dogs_path
    click_link "Dogs without owners"
    expect(page).to have_content("Fido")
  end

  scenario "user views list of dogs" do
    # bob = Owner.create(name: "Bob", age: 32, email: "bob@bobmail.com")
    # Dog.create(name: "Fido", age: 3, owner: bob)
    bob = FactoryGirl.create(:owner)
    FactoryGirl.create(:dog, owner: bob)

    visit dogs_path
    expect(page).to have_content("Fido")
  end

  scenario "user views list of only old dogs" do
    # Dog.create(name: "Fido", age: 3)
    # Dog.create(name: "Lucy", age: 12)
    FactoryGirl.create(:dog)
    FactoryGirl.create(:old_dog)

    visit dogs_path
    click_link "Old Dogs"
    expect(page).to have_content("Lucy")
    expect(page).to have_no_content("Fido")
  end

  scenario "user views list of owners who own a lot of dogs" do
    # bob = Owner.create(name: "Bob", age: 32, email: "bob@bobmail.com")
    # Dog.create(name: "Fido", age: 3, owner: "Bob")
    # Dog.create(name: "Lucy", age: 12, owner: "Bob")
    # Dog.create(name: "Buster", age: 7, owner: "Bob")
    # Dog.create(name: "Max", age: 1, owner: "Bob")

    FactoryGirl.create(:owner_with_many_dogs)

    visit owners_path
    click_link "Owners with lots of dogs"
    expect(page).to have_content("Bob")
  end
end
