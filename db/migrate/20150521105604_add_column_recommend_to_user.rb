class AddColumnRecommendToUser < ActiveRecord::Migration
  def change
    add_column :users, :recommend, :boolean, :default => true
  end
end
