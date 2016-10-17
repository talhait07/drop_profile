class RemoveIndexImpressions < ActiveRecord::Migration
  def up
    remove_index :impressions, name: 'unique visitors'
  end
  def down
    add_index :impressions, [:impressionable_type, :impressionable_id, :ip_address], name: 'unique visitors', unique: true
  end
end
