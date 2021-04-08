require 'rails_helper'

RSpec.describe 'Applications index page', type: :feature do
  describe 'when I visit the applications index page' do
    it 'can show a list of all application names by link' do
      application4 = Application.create!(name: "Leigh Pulzone", street_address: "52135 Mellow Blvd", city: "Bend", state: "OR", zipcode: 97701, description: "I like turtles", status: "In Progress")

      visit '/applications'

      save_and_open_page

      expect(page).to have_link("Link to Leigh Pulzone's application")
    end
  end
end
