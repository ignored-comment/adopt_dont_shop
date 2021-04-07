class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
    end
  end

  def update
    @application = Application.find(params[:id])
    PetApplication.create!(application_id: @application.id, pet_id: params[:pet_id])

    render :action => "show"
  end

  def new

  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}/"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private

  def application_params
    params.permit(:id, :name, :street_address, :city, :state, :zipcode, :description, :status, :pet_id)
  end
end
