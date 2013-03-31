class App::Object < ActiveRecord::Base
  serialize :fields, Array

  validates :title, presence: true
end
