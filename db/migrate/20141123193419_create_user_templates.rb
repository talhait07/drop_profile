class CreateUserTemplates < ActiveRecord::Migration
  def change
    create_table :user_templates do |t|
      t.references :user
      t.references :template
      t.boolean :current, default: false

      t.timestamps
    end
  end
end
