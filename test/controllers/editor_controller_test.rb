require 'test_helper'

class EditorControllerTest < ActionController::TestCase
  test "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:app_objects)
  end
end
