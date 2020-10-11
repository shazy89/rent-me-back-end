class CarsController < ApplicationController
  before_action :set_car, only: [:show, :update, :destroy]

  before_action :check_configuration
    
  def check_configuration
    render 'configuration_missing' if Cloudinary.config.api_key.blank?
  end

  # GET /cars
  def index
    @cars = Car.all

    render json: @cars, include: [:books]
  end

  # GET /cars/1
  def show
    render json: @car, include: [:books]
  end

  # POST /cars
  def create
    
    url = uploadToCloudinary(params[:car][:img])
    @car = Car.new(car_params)
   # binding.pry
    @car.img = url
    if @car.save
      render json: @car, status: :created, location: @car, include: [:books]
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end
   
  # PATCH/PUT /cars/1
  def update

    if @car.update(car_params)

      render json: @car, include: [:books]
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cars/1
  def destroy
  
    @car.destroy
    render json: @car, include: [:books]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      
      @car = Car.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_params
      params.require(:car).permit(:make, :model, :vehicleType, :capacity, :baggingCapacity, :rentPrice, :img)
    end
    def uploadToCloudinary(data)
      Cloudinary::Uploader.upload(data)["url"]
    end
end
  


