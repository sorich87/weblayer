require 'test_helper'

class App::ObjectTest < ActiveSupport::TestCase
  test 'validates presence of title and class_name' do
    object = App::Object.new
    assert object.invalid?
    assert_equal ["can't be blank"], object.errors[:title]
    assert_equal ["can't be blank"], object.errors[:class_name]

    object.title = 'Test'
    object.class_name = 'Test'
    assert object.valid?
  end

  test 'set default class name on save' do
    object = App::Object.new(title: 'Test Title 1')
    object.save!
    assert_equal 'TestTitle1', object.class_name
  end
end
