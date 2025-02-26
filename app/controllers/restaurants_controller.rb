class RestaurantsController < ApplicationController
  before_action :set_restaurant_user, only: %i[show]
  before_action :set_restaurant_admin, only: %i[edit update destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def show
    @review = Review.new(restaurant_id: @restaurant.id) # Link the review to the restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path, status: :see_other, notice: 'Restaurant was successfully deleted.'
  end

  private

  def set_restaurant_user
    @restaurant = Restaurant.find(params[:id])
  end

  def set_restaurant_admin
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :category)
  end
end
