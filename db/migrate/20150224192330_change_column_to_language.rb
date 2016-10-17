class ChangeColumnToLanguage < ActiveRecord::Migration
  def up
    change_column_default :languages, :reading_level, 0
    change_column_default :languages, :writing_level, 0
    change_column_default :languages, :speaking_level, 0
    rename_column :languages, :reading_level, :listening_level
  end

  def down
    rename_column :languages, :listening_level, :reading_level
    change_column_default :languages, :reading_level, nil
    change_column_default :languages, :writing_level, nil
    change_column_default :languages, :speaking_level, nil
  end
end
