class AdminsController < ApplicationController

  def index
    @shelters = Shelter.shelter_join_pet_application
  end

  def new
    
  end
end
