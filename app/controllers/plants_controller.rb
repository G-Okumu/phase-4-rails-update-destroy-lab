class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_method

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  # update
  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant
  end
  #delete /plants/:id
  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end

  private

  def find_plant
    Plant.find(params[:id])
  end

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def not_found_method
    render json: {error: "Plant with #{params[:id]},not found"}, status: :not_found
  end
end
