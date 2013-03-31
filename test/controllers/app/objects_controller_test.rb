require 'test_helper'

class App::ObjectsControllerTest < ActionController::TestCase
  setup do
    @app_object = app_objects(:one)
    @request.accept = 'application/json'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:app_objects)
  end

  test "should create app_object" do
    assert_difference('App::Object.count') do
      post :create, title: 'Creation'
    end
  end

  test "should show app_object" do
    get :show, id: @app_object
    assert_response :success
  end

  test "should update app_object" do
    patch :update, id: @app_object, title: 'Update'
    assert_response :success
  end

  test "should destroy app_object" do
    assert_difference('App::Object.count', -1) do
      delete :destroy, id: @app_object
    end
  end
end
