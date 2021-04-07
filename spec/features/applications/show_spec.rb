require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit an applications show page' do
    it 'can show an application with attributes' do
      application = Application.create!(
        name: "Bob Ham",
        street_address: "5714 Carmel Rd",
        city: "Charlotte",
        state: "NC",
        zipcode: 28226,
        description: "eh breddy gool guy",
        status: "In Progress"
      )

      visit "/applications/#{application.id}"

      expect(page).to have_content("Bob Ham")
      expect(page).to have_content("5714 Carmel Rd")
      expect(page).to have_content("Charlotte")
      expect(page).to have_content("NC")
      expect(page).to have_content("28226")
      expect(page).to have_content("eh breddy gool guy")
      expect(page).to have_content("In Progress")
    end

    it 'I see a section to search for pets' do
      application = Application.create!(
        name: "Bob Ham",
        street_address: "5714 Carmel Rd",
        city: "Charlotte",
        state: "NC",
        zipcode: 28226,
        description: "eh breddy gool guy",
        status: "In Progress"
      )

      visit "applications/#{application.id}"

      expect(page).to have_content("Add a pet to this application:")
    end

    it 'can adopt a searched result of a pet' do
      pawsnmo = Shelter.create!(foster_program: true, name: "Paws N Mo'", city: "Charlotte", rank: 4)
      pawsnmo.pets.create!(adoptable: true, age: 2, breed: "Border-Collie", name: "Jack")

      application = Application.create!(
        name: "Bob Ham",
        street_address: "5714 Carmel Rd",
        city: "Charlotte",
        state: "NC",
        zipcode: 28226,
        description: "eh breddy gool guy",
        status: "In Progress"
      )

      visit "/applications/#{application.id}"

      expect(page).to have_content("No pets applied for yet.")

      fill_in "pet_name", with: "Jack"
      click_on "Submit"

      expect(page).to have_content("Jack")
      expect(page).to have_button("Adopt this Pet")
    end

    it 'can submit an application' do
      pawsnmo = Shelter.create!(foster_program: true, name: "Paws N Mo'", city: "Charlotte", rank: 4)
      pawsnmo.pets.create!(adoptable: true, age: 2, breed: "Border-Collie", name: "Jack")

      application = Application.create!(
        name: "Bob Ham",
        street_address: "5714 Carmel Rd",
        city: "Charlotte",
        state: "NC",
        zipcode: 28226,
        description: "eh breddy gool guy",
        status: "In Progress"
      )

      visit "/applications/#{application.id}"

      fill_in "pet_name", with: "Jack"
      click_on "Submit"

      expect(page).to have_content("Jack")
      expect(page).to have_button("Adopt this Pet")

      click_on "Adopt this Pet"

      expect(page).to have_content("Why you might be a good owner for these pet(s)")

      fill_in "description", with: "OOGA BOOGA BOOGA"

      click_on "Submit New Application"

      expect(page).to have_content("Application status: Pending")
      expect(page).to have_content("Jack")
    end
  end
end
