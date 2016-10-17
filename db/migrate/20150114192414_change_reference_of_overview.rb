class ChangeReferenceOfOverview < ActiveRecord::Migration
  def change
    remove_reference :overviews, :profile
    add_reference :overviews, :user
  end
end
