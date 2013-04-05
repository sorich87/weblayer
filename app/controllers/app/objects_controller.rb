class App::ObjectsController < ApplicationController
  respond_to :json
  before_action :set_app_object, only: [:show, :update, :destroy]

  # GET /objects
  def index
    @app_objects = App::Object.all
  end

  # GET /objects/1
  def show
  end

  # POST /app/objects
  def create
    @app_object = App::Object.create(app_object_params)
    respond_with @app_object, template: 'app/objects/show'
  end

  # PATCH/PUT /app/objects/1
  def update
    @app_object.update(app_object_params)
    respond_with @app_object, template: 'app/objects/show'
  end

  # DELETE /app/objects/1
  def destroy
    respond_with @app_object.destroy, template: 'app/objects/show'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_object
      @app_object = App::Object.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_object_params
      params.permit(:title, :class_name, fields: [:name, :type])
    end
end
