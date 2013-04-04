class AddClassNameToAppObjects < ActiveRecord::Migration
  def change
    add_column :app_objects, :class_name, :string

    App::Object.transaction do
      App::Object.all.each do |object|
        title = object.title.titleize.gsub(' ', '').tableize.classify

        App::Object.connection.execute "UPDATE app_objects
          SET class_name = '#{title}'
          WHERE id = '#{object.id}'"
      end
    end
  end
end
