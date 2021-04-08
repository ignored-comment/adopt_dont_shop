class AdminsController < ApplicationController

  def index_shelters
    @shelters = Shelter.alphabetically_descending_by_name
  end
end
