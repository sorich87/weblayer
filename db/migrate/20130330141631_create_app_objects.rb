class CreateAppObjects < ActiveRecord::Migration
  def change
    create_table :app_objects do |t|
      t.string :title
      t.text :fields

      t.timestamps
    end
  end
end
