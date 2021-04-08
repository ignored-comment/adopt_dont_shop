require 'rails_helper'

RSpec.describe 'the index page' do
  before(:each) do
    @pawsnmo = Shelter.create!(foster_program: true, name: "Paws N Mo'", city: "Charlotte", rank: 4)
    @charlotte = Shelter.create!(foster_program: false, name: "Charlotte Foster Pets'", city: "Charlotte", rank: 6)
  end

  it 'when I visit the admins/shelter index, I can see a list of all shelters listed alphabetically descending' do
    visit '/admin/shelters'

    expect(page).to have_content("Paws N Mo")
    expect(page).to have_content("Charlotte")
    expect(page).to have_content("Foster Program? true")
    expect(page).to have_content("Rank: 4")
    expect(page).to have_content("Charlotte Foster Pets")
    expect(page).to have_content("Rank: 6")
    expect(page).to have_content("Foster Program? false")
  end
end
