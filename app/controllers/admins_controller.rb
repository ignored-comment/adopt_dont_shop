class AdminsController < ApplicationController

  def index
    @shelters = Shelter.alphabetically_descending_by_name
  end
end
