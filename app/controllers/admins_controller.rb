class AdminsController < ApplicationController

  def index
    @shelters = Shelter.alphabetically_descending_by_name
    @joined_table = Shelter.joins(pets: :applications)
  end
end
