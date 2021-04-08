require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'class methods' do
    before(:each) do
      @pawsnmo = Shelter.create!(foster_program: true, name: "Paws N Mo'", city: "Charlotte", rank: 4)
      @charlotte = Shelter.create!(foster_program: false, name: "Charlotte Foster Pets'", city: "Charlotte", rank: 6)
      @citycounty = Shelter.create!(foster_program: true, name: "City County", city: "New York City", rank: 2)
      @winthrop = Shelter.create!(foster_program: false, name: "Winthrop", city: "Winthrop", rank: 1)
    end

    it 'can order shelters by name alphabetically, descending' do
      expect(Shelter.alphabetically_descending_by_name).to eq(
        [@winthrop, @pawsnmo, @citycounty, @charlotte]
      )
    end
  end
end
