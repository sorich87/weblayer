class App::Object < ActiveRecord::Base
  serialize :fields, Array

  validates :title, presence: true
  validates :class_name, presence: true

  before_validation :ensure_class_name

  def self.title_to_class_name(title)
    title.titleize.gsub(' ', '').tableize.classify
  end

  private

  def ensure_class_name
    if self.title.present?
      self.class_name ||= self.class.title_to_class_name(self.title)
    end
  end
end
