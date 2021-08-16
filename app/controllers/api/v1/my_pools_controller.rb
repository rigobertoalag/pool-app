class Api::V1::MyPoolsController < ApplicationController
  before_action :authenticate, only: %i[create update destroy]
  before_action :set_pool, only: %i[show update destroy]
  before_action(only: [:update, :destroy]) { |controlador| controlador.authenticate_owner(@pool.user) }

  layout "api/v1/application"
  
  def index
    @pools = MyPool.all
  end

  def show; end

  def create
    @pool = @current_user.my_pools.new(my_pools_params)
    if @pool.save
      render 'api/v1/my_pools/show'
    else
      # render json: { errors: @pool.errors.full_messages }, status: :unprocessable_entity
      error_array!(@pool.errors.full_messages,:unprocessable_entity)
    end
  end

  def update
      @pool.update(my_pools_params)
      render 'api/v1/my_pools/show'
  end

  def destroy
      @pool.destroy
      render json: { message: 'Encuesta eliminada' }
  end

  private

  def set_pool
    @pool = MyPool.find(params[:id])
  end

  def my_pools_params
    params.require(:pool).permit(:title, :description, :expires_at)
  end
end
