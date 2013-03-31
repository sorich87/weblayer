class EditorController < ApplicationController
  def index
    @app_objects = App::Object.all
  end
end
