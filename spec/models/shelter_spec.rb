require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end
    end

    describe '#order_by_recently_created' do
      it 'returns shelters with the most recently created first' do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe '#order_by_number_of_pets' do
      it 'orders the shelters by number of pets they have, descending' do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.adoptable_pets' do
      it 'only returns pets that are adoptable' do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe '.alphabetical_pets' do
      it 'returns pets associated with the given shelter in alphabetical name order' do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe '.shelter_pets_filtered_by_age' do
      it 'filters the shelter pets based on given params' do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe '.pet_count' do
      it 'returns the number of pets at the given shelter' do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end

    it 'can order shelters by name alphabetically, descending' do
      expect(Shelter.alphabetically_descending_by_name).to eq(
        [@shelter_2, @shelter_3, @shelter_1]
      )
    end

    it 'can show table of shelters for pet applications that are currently pending' do
      pawsnmo = Shelter.create!(foster_program: true, name: "Paws N Mo'", city: "Charlotte", rank: 4)
      charlotte = Shelter.create!(foster_program: false, name: "Charlotte Foster Pets'", city: "Charlotte", rank: 6)
      citycounty = Shelter.create!(foster_program: true, name: "City County", city: "New York City", rank: 2)
      winthrop = Shelter.create!(foster_program: false, name: "Winthrop", city: "Winthrop", rank: 1)

      jack = pawsnmo.pets.create!(adoptable: true, age: 2, breed: "Border-Collie", name: "Jack")
      harry = citycounty.pets.create!(adoptable: true, age: 1, breed: "Scottish Terrier", name: "Harry")

      application1 = Application.create!(name: "Kon Ham", street_address: "5714 Carmel Rd", city: "Charlotte", state: "NC", zipcode: 28226, description: "I'm a cool guy", status: "Pending")
      application2 = Application.create!(name: "Gaelyn Cooper", street_address: "123 ABC St", city: "Huntsville", state: "AL", zipcode: 35649, description: "I have many pets and have a large yard", status: "Pending")

      kon_adopts_jack = PetApplication.create!(application_id: application1.id, pet_id: jack.id)
      gaelyn_adopts_harry = PetApplication.create!(application_id: application2.id, pet_id: harry.id)

      expect(Shelter.shelter_join_pet_application).to eq([pawsnmo, citycounty])
    end
  end
end
