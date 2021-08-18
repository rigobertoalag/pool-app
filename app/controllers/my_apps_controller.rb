class MyAppsController < ApplicationController
  before_action :set_my_app, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /my_apps/new
  def new
    @my_app = MyApp.new
  end

  # GET /my_apps/1/edit
  def edit
  end

  # POST /my_apps or /my_apps.json
  def create
    @my_app = current_user.my_apps.new(my_app_params)

    respond_to do |format|
      if @my_app.save
        format.html { redirect_to "/", notice: "My app was successfully created." }
        format.json { render :show, status: :created, location: @my_app }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @my_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /my_apps/1 or /my_apps/1.json
  def update
    respond_to do |format|
      if @my_app.update(my_app_params)
        format.html { redirect_to "/", notice: "My app was successfully updated." }
        format.json { render :show, status: :ok, location: @my_app }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @my_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_apps/1 or /my_apps/1.json
  def destroy
    @my_app.destroy
    respond_to do |format|
      format.html { redirect_to "/", notice: "My app was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_app
      @my_app = MyApp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_app_params
      params.require(:my_app).permit(:title, :javascript_origins)
    end
end
