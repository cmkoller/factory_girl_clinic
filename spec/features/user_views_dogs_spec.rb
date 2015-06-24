require 'rails_helper'

feature 'user signs out', %Q{
  As an authenticated user
  I want to sign out
  So that my identity is forgotten about on the machine I'm using
} do

  scenario "user views list of dogs" do
    bob = Owner.create(name: "Bob", age: 32, email: "bob@bobmail.com")
    Dog.create(name: "Fido", age: 3, owner: "Bob")

    visit dogs_path
    expect(page).to have_content("Lucy")
  end

  scenario "user views list of only old dogs" do
    bob = Owner.create(name: "Bob", age: 32, email: "bob@bobmail.com")
    Dog.create(name: "Fido", age: 3, owner: "Bob")
    Dog.create(name: "Lucy", age: 12, owner: "Bob")

    visit dogs_path
    click_link "Old Dogs"
    expect(page).to have_content("Lucy")
    expect(page).to have_no_content("Fido")
  end

  scenario "user views list of owners who own a lot of dogs" do
    bob = Owner.create(name: "Bob", age: 32, email: "bob@bobmail.com")
    Dog.create(name: "Fido", age: 3, owner: "Bob")
    Dog.create(name: "Lucy", age: 12, owner: "Bob")
    Dog.create(name: "Buster", age: 7, owner: "Bob")
    Dog.create(name: "Max", age: 1, owner: "Bob")

    visit owners_path
    click_link "Owners with lots of dogs"
    expect(page).to have_content("Bob")
  end


end
