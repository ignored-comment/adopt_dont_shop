class PetApplicationsController < ApplicationRecord

  def index
    @shelters = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets.display_by(params[:adoptable])
    @adopted_pets = @shelter.pets.adopted_pets
  end
end
