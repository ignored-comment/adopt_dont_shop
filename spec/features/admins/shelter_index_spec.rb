require 'rails_helper'

RSpec.describe 'the index page' do
  before(:each) do
    @pawsnmo = Shelter.create!(foster_program: true, name: "Paws N Mo'", city: "Charlotte", rank: 4)
    @charlotte = Shelter.create!(foster_program: false, name: "Charlotte Foster Pets'", city: "Charlotte", rank: 6)
    @citycounty = Shelter.create!(foster_program: true, name: "City County", city: "New York City", rank: 2)
    @winthrop = Shelter.create!(foster_program: false, name: "Winthrop", city: "Winthrop", rank: 1)

    @jack = @pawsnmo.pets.create!(adoptable: true, age: 2, breed: "Border-Collie", name: "Jack")
    @harry = @citycounty.pets.create!(adoptable: true, age: 1, breed: "Scottish Terrier", name: "Harry")

    @application1 = Application.create!(name: "Kon Ham", street_address: "5714 Carmel Rd", city: "Charlotte", state: "NC", zipcode: 28226, description: "I'm a cool guy", status: "Pending")
    @application2 = Application.create!(name: "Gaelyn Cooper", street_address: "123 ABC St", city: "Huntsville", state: "AL", zipcode: 35649, description: "I have many pets and have a large yard", status: "Pending")

    @kon_adopts_jack = PetApplication.create!(application_id: @application1.id, pet_id: @jack.id)
    @gaelyn_adopts_harry = PetApplication.create!(application_id: @application2.id, pet_id: @harry.id)
  end

  it 'when I visit the admins/shelter index, I can see a list of all shelters listed alphabetically descending' do
    visit '/admin/shelters'

    expect(page).to have_content("Paws N Mo")
    expect(page).to have_content("City County")
  end
end
