class ImagesController < ApplicationController

    # Remember to download your Cloudinary account details in a .yml format from your Cloudinary dashboard. Add this file to the config folder.
  
     before_action :check_configuration
    
     def check_configuration
       render 'configuration_missing' if Cloudinary.config.api_key.blank?
     end
  
  
    def index
      @images = Image.all
      render json: @images
    end
  
    def new
      @image = Image.new
      render json: @image, status: :ok
  
    end
  
    def create
      url = uploadToCloudinary(params[:image]['imageUrl'])
      binding.pry
      @image = Image.create(image_url: url)
      render json: @image, status: :ok
    end

  
    def show
      @image = Image.find(params[:id])
      render json: @image
    end
  
  
    private
  
    def image_params
      params.require(:image).permit(:id, :image_url)
    end
  
    def uploadToCloudinary(data)
      Cloudinary::Uploader.upload(data)["url"]
    end

  
  end