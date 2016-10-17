class AddAuthProviderAuthUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :auth_provider, :string
    add_column :users, :auth_uid, :string
  end
end
