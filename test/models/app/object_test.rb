require 'test_helper'

class App::ObjectTest < ActiveSupport::TestCase
  test "presence validations" do
    object = App::Object.new
    assert object.invalid?
    assert_equal ["can't be blank"], object.errors[:title]

    object.title = "Test"
    assert object.valid?
  end
end
