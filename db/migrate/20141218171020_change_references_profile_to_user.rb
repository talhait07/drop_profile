class ChangeReferencesProfileToUser < ActiveRecord::Migration
  def change
    remove_reference  :educations, :profile
    add_reference     :educations, :user
    remove_reference  :experiences, :profile
    add_reference     :experiences, :user
    remove_reference  :skills, :profile
    add_reference     :skills, :user
    remove_reference  :references, :profile
    add_reference     :references, :user
    remove_reference  :languages, :profile
    add_reference     :languages, :user
  end
end
