class ChangeColumnToSkills < ActiveRecord::Migration
  def up
    change_column_default :skills, :level, 0
    change_column_default :skills, :match, false
  end

  def down
    change_column_default :skills, :level, nil
    change_column_default :skills, :match, nil
  end
end
